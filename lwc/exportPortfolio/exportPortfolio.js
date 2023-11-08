import { LightningElement, track, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendRequestForOperUrl from '@salesforce/apex/ImportPortfolioService.sendRequestForOperUrl';
import fetchCustomMetaDataType from '@salesforce/apex/ImportPortfolioService.fetchCustomMetaDataType';
import IMAGES from '@salesforce/resourceUrl/FE_FundInfo_Logo';
import CustomToast from '@salesforce/resourceUrl/CustomToast';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class ExportPortfolio extends LightningElement {
    @api recordId;
    flag = false;
    pageId;
    isLoading = true;
    fundInfoLogo = IMAGES;
    @track unauthorisedMessage;
    @track unauthorisedMessageHyperlink;
    @track mediumScanPDFErrorMessage;
    @track successMessageForMediumScan;

    renderedCallback() {

        const style = document.createElement('style');
        style.innerText = `
        .slds-modal__content{
            padding : 0 !important;
            font-weight: bold;
            background-color: var(--slds-c-modal-content-color-background, var(--sds-c-modal-content-color-background, var(--slds-c-modal-color-background, var(--sds-c-modal-color-background, var(--lwc-colorBackgroundAlt,rgb(255, 255, 255))))));
            color: var(--slds-c-modal-content-text-color, var(--sds-c-modal-content-text-color, var(--slds-c-modal-text-color, var(--sds-c-modal-text-color))));
            overflow: hidden;
            overflow-y: auto;
        }`;
        this.template.querySelector('lightning-quick-action-panel').appendChild(style);
        const style1 = document.createElement('style');
        style.innerText = `.slds-spinner_brand.slds-spinner:before, .slds-spinner_brand.slds-spinner:after, .slds-spinner_brand .slds-spinner__dot-a:before, .slds-spinner_brand .slds-spinner__dot-b:before, .slds-spinner_brand .slds-spinner__dot-a:after, .slds-spinner_brand .slds-spinner__dot-b:after, .slds-spinner--brand.slds-spinner:before, .slds-spinner--brand.slds-spinner:after, .slds-spinner--brand .slds-spinner__dot-a:before, .slds-spinner--brand .slds-spinner__dot-b:before, .slds-spinner--brand .slds-spinner__dot-a:after, .slds-spinner--brand .slds-spinner__dot-b:after {
                            /* background-color: var(--lwc-brandPrimary,rgb(27, 150, 255)); */
                            background-color: #009CA6;
                        }
        .slds-spinner {
            position: absolute;
            top: 55%;
            left: 50%;
            z-index: 9051;
            transform: translate(-50%, -50%) rotate(90deg);
        }
        slds-spinner_container {
            position: unset !important;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: var(--lwc-zIndexSpinner,9050);
            background-color: var(--lwc-colorBackgroundTempModalTintAlt,rgba(255, 255, 255, 0.75));
            visibility: visible;
            opacity: 1;
            transition: opacity .2s ease,visibility 0s;
            transition-delay: 0s,.3s;
        }`;
        const spinner = this.template.querySelector('lightning-spinner');
        if (spinner) {
            spinner.appendChild(style1);
        }
        Promise.all([
            loadStyle( this, CustomToast )
            ]).then(() => {
                // console.log( 'Files loaded' );
            })
            .catch(error => {
                console.log( error.body.message );
        });

        if (!this.flag && this.recordId) {
            this.fetchCustomMetaDataForToastMessage();
            sendRequestForOperUrl({ portfolioId: this.recordId })
                .then((result) => {
                    this.flag = true;
                    if (result.isValidateSuccess == 'true') {
                        this.isLoading = false;
                        this.closeAction();
                        console.log('inside when validate  is success');
                        // this url need to open into the new tab.
                        if (result.autoLoginURL != null && result.warningDescription == '') {
                            this.handleOnLoad();
                            window.open(result.autoLoginURL, '_blank');
                        }
                        else {
                            window.open(result.autoLoginURL, '_blank');
                            this.showNotification(result.warningDescription, 'warning', 'sticky');
                        }
                    }
                    else if (result.isValidateSuccess == 'false' && result.autoLoginURL == '' && result.warningDescription == '') {
                        this.closeAction();
                        this.flag = true;
                        this.isLoading = false;
                        let message = this.unauthorisedMessage.split('LINK')[0];
                        let urlLabel = this.unauthorisedMessage.split('LINK')[1];
                        let message2 = this.unauthorisedMessage.split('LINK')[2];
                        this.showToastNotificationWithHyperLink(message, message2, 'error', urlLabel, this.unauthorisedMessageHyperlink);
                    }
                    else if (result.warningDescription == 'Technical error occurred' && result.autoLoginURL == '' && result.isValidateSuccess == 'false') {
                        this.showNotification(result.warningDescription, 'error');
                    }
                })
            .catch((error) => {
                this.closeAction();
                this.flag = true;
                this.isLoading = false;
                this.showNotification('Technical error occurred', 'error', 'sticky');
            });
        }
    }

    showToastNotificationWithHyperLink(message, message2, variant, urlLabel, url) {
        const evt = new ShowToastEvent({
            title: 'Invalid FE Analytics User',
            message: message + ' {1} '+ message2, 
            variant: variant,
            mode: 'sticky',
            messageData: [
                'Salesforce',
                {
                    url: url,
                    label: urlLabel,
                },
            ],
        });
        this.dispatchEvent(evt);
    }

    showNotification(message, variant, mode) {
        const evt = new ShowToastEvent({
            title: 'Export Portfolio',
            message: message, 
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }

    closeAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    // Fetch custom metadata type
    fetchCustomMetaDataForToastMessage() {
        fetchCustomMetaDataType()
            .then(result => {
                console.log(result);
                this.unauthorisedMessage = result.Fe_FundInfo__Unauthorised_Message__c;
                this.unauthorisedMessageHyperlink = result.Fe_FundInfo__Unauthorised_Message_Hyperlink__c;
                this.mediumScanPDFErrorMessage = result.Fe_FundInfo__Medium_Scan_PDF_Error_Message__c;
                this.successMessageForMediumScan = result.Fe_FundInfo__Success_Message_For_Medium_Scan__c;
            })
            .catch(error => {
                console.log(error);
            })
    }

    handleCancel(event) {
        this.dispatchEvent(new CloseActionScreenEvent());
    }   
    
    handleOnLoad(){
        setTimeout(() => {
            this.isLoading = false;
            console.log('inside success response');
            this.showNotification('Portfolio exported successfully!', 'success');
        }, this.addLoadingTime*1000);
    }
}

