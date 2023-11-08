import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import getFundFactSheetDetailedPDF from '@salesforce/apex/FundFactSheetDetailedActionService.getFundFactSheetDetailedPDF';
import fetchCustomMetaDataType from '@salesforce/apex/FundFactSheetDetailedActionService.fetchCustomMetaDataType';
import IMAGES from '@salesforce/resourceUrl/FE_FundInfo_Logo';
import CustomToast from '@salesforce/resourceUrl/CustomToast';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class FeAnalyticsFactsheetPdf extends LightningElement {
    @api recordId;
    retriveRecordId = true;
    isLoading = true;
    isShowPdf = false;
    addLoadingTime = 1;
    pdfResponse;
    @track SamplePDFURL;
    fundInfoLogo = IMAGES;

    @track unauthorisedMessage;
    @track unauthorisedMessageHyperlink;
    @track fundFactSheetDetailedPdfSuccessMessage;
    @track fundFactSheetDetailedPdfErrorMessage;
    @track fundFactSheetDetailedCodeError;

    // using in quick action.
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
                console.log( 'Files loaded' );
            })
            .catch(error => {
                console.log( error.body.message );
        });

        if (this.retriveRecordId && this.recordId) {
            this.fetchCustomMetaDataForToastMessage();
            this.SamplePDFURL = '/apex/fe_FundInfo__GenerateFundFactSheetDetailedPDFHelper?data=';
            getFundFactSheetDetailedPDF({ portfolioHoldingId: this.recordId }) 
                .then(result =>{
                    console.log('inside result');
                    console.log(result);
                    this.retriveRecordId = false;
                    if (result.isSuccessForValidate && result.data != 'error' && result.isSuccess) {
                        this.retriveRecordId = false;
                        this.isShowPdf = true;
                        this.SamplePDFURL += this.recordId;
                        this.pdfResponse = true;
                    } else if (result.isSuccessForValidate && result.data == 'error' && !result.isSuccess) { 
                        console.log('inside 404 and 500 status code');
                        this.retriveRecordId = false;
                        this.isShowPdf = true;
                        this.isLoading = false;
                        this.showNotification(result.fundFactSheetDetailedErrorMessage, 'error', 'sticky');
                        this.dispatchEvent(new CloseActionScreenEvent());
                    }
                    // invalid user.
                    else if (!result.isSuccessForValidate && result.data == 'vlalidation' && !result.isSuccess) {
                        this.retriveRecordId = false;
                        this.isShowPdf = true;
                        this.isLoading = false;
                        let message = this.unauthorisedMessage.split('LINK')[0];
                        let urlLabel = this.unauthorisedMessage.split('LINK')[1];
                        let message2 = this.unauthorisedMessage.split('LINK')[2];
                        this.showToastNotificationWithHyperLink(message, message2, 'error', urlLabel, this.unauthorisedMessageHyperlink);
                        this.dispatchEvent(new CloseActionScreenEvent());
                    }
                })
                .catch(error =>{
                    console.log('enter in console error');
                    console.log(error);
                    this.isLoading = false;
                    this.retriveRecordId = false;
                    this.showNotification(this.fundFactSheetDetailedPdfErrorMessage, 'error', 'sticky');
                    this.dispatchEvent(new CloseActionScreenEvent());
                })
        }
    }

    fetchCustomMetaDataForToastMessage() {
        fetchCustomMetaDataType()
            .then(result => {
                console.log(result);
                this.fundFactSheetDetailedPdfErrorMessage = result.Fe_FundInfo__FFSD_Error_Message__c;
                this.fundFactSheetDetailedPdfSuccessMessage = result.Fe_FundInfo__FundFactSheetDetailed_Success_Message__c;
                this.unauthorisedMessage = result.Fe_FundInfo__Unauthorised_Message__c;
                this.unauthorisedMessageHyperlink = result.Fe_FundInfo__Unauthorised_Message_Hyperlink__c;
                this.fundFactSheetDetailedCodeError = result.Fe_FundInfo__Does_Not_Have_FFSD_Code_Error_Message__c;
            })
            .catch(error => {
                console.log(error);
            })
    }

    handleCancel(event) {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    showNotification(message, variant, mode) {
        const evt = new ShowToastEvent({
            title: 'FE Analytics Factsheet',
            message: message, 
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
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

    handleOnLoad(){
        setTimeout(() => {
            if (this.pdfResponse) {
                this.dispatchEvent(new CloseActionScreenEvent());
            }
        }, this.addLoadingTime*1000);
    }
}