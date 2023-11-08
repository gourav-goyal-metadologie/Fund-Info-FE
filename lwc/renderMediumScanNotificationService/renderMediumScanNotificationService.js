import { LightningElement, api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendRequest from '@salesforce/apex/GetTokenForNotificationService.sendRequest';
import getNotificationRequestId from '@salesforce/apex/GetMediumAsyncCall.getNotificationRequestId';
import getPortfolioName from '@salesforce/apex/GetMediumAsyncCall.getPortfolioName';
import getMediumScanResult from '@salesforce/apex/GenerateMediumScanResultPdfController.getMediumScanResult';
import fetchCustomMetaDataType from '@salesforce/apex/GenerateMediumScanResultPdfController.fetchCustomMetaDataType';
import portfolioCompletedNotification from '@salesforce/apex/GenerateMediumScanResultPdfController.portfolioCompletedNotification';

import CustomToast from '@salesforce/resourceUrl/CustomToast';
import { loadStyle } from 'lightning/platformResourceLoader';

const BASE_URL = window.location.origin;

export default class RenderMediumScanNotificationService extends LightningElement {
 
    @api recordId;
    token;
    requestId;
    isRecordIdAvailable = false;
    getMediumScanRequestVfPage;
    callVFPage = false;
    @track unauthorisedMessage;
    @track unauthorisedMessageHyperlink;
    @track mediumScanPDFErrorMessage;
    @track successMessageForMediumScan;
    @track responseWork = true;
    addLoadingTime = 1;
    pdfResponse = false;
    isExecuting = false;

    connectedCallback() {
        Promise.all([
            loadStyle( this, CustomToast )
            ]).then(() => {
                console.log( 'Files loaded' );
            })
            .catch(error => {
                console.log( error.body.message );
        });
    }

    timegap = false;
    dontShowToast = false;

    @api async invoke() {
        window.addEventListener("message", this.handleResponse.bind(this), false);
        if (this.recordId && !this.isRecordIdAvailable ) {
            this.isRecordIdAvailable = true;
            
            // demo 
            getNotificationRequestId({ portfolioId: this.recordId })
                .then(result => {
                    if (result.requestIdData == 'error for validation' && !result.isSuccess
                        && !result.isSuccessForValidate && result.warningDescription == '') { 
                            this.dontShowToast = true;
                        }
                })
                .catch(error => {
                    console.log('err ', error.message);
                })
            
            setTimeout(() => {
                if (!this.dontShowToast) {
                    this.showNotification('Medium Scan generation in progress, notification will be sent when complete.', 'warning');
                }    
            }, 1000);

            setTimeout(() => {
                this.timegap = true;
                this.getPortfolioNameApexCall(this.recordId);
                // fetch custom metadata type.
                this.fetchCustomMetaDataForToastMessage();
                // call GetMediumAsyncCall apex class to get Notification.
                this.genrateNotificationRequestId(this.recordId);
            }, 5000);
            
        }
        else {
            if (!this.dontShowToast) {
                let evt = new ShowToastEvent({
                    title: 'FE Analytics - Medium Scan',
                    message: 'Medium scan generation is already in progress.',
                    variant: 'error'
                 });
                 this.dispatchEvent(evt);
            }
        }
    }

    // this method is used for to get Notification response from VF page.
    handleResponse(message) {
        try {
            let sourceValid = 'MediumScan' + this.recordId;
            if (message.data.source === sourceValid && this.responseWork) {
                this.responseWork = false;
                console.log('Finally In the JS', message.data.message);
                this.genrateMediumScanResultPdf(message.data.message);
            }
            else if (message.data.source === 'MediumScanFailedError' && this.responseWork) {
                this.responseWork = false;
                this.completedNotification('');
                this.showNotification('Document generation failed for '+ this.portfolioName +'. Please try again.', 'error', 'sticky');
            }
        } catch (error) {
            console.log(error);
            this.showNotification('Document generation failed for '+ this.portfolioName +'. Please try again.', 'error', 'sticky');
            this.completedNotification('');
        }
    }

    portfolioName = '';
    getPortfolioNameApexCall(currentRecordId) {
        getPortfolioName({portfolioId: currentRecordId}) 
            .then(result => {
                this.portfolioName = result;
            })
            .catch(error => {
                console.log(error.message);
            })
    }

    warningDescriptionValue = '';
    // TODO : we need to pass current record id and will get the respone of request id
    genrateNotificationRequestId(currentRecordId) {
        getNotificationRequestId({ portfolioId: currentRecordId })
            .then(result => {
                console.log('result');
                console.log(result);
                if (result.requestIdData == 'error for validation' && !result.isSuccess
                    && !result.isSuccessForValidate && result.warningDescription == '')
                {
                    let message = this.unauthorisedMessage.split('LINK')[0];
                    let urlLabel = this.unauthorisedMessage.split('LINK')[1];
                    let message2 = this.unauthorisedMessage.split('LINK')[2];

                    //added for Enable the Action Again
                    this.isRecordIdAvailable = false;
                    this.responseWork = true;
                    this.dontShowToast = false;

                    if (this.timegap) {
                        this.showToastNotificationWithHyperLink(message, message2, 'error', urlLabel, this.unauthorisedMessageHyperlink);
                        // send notification when error occured.
                        this.completedNotification('');
                    }
                }
                else if (result.requestIdData == 'Portfolio Holdings are not available' && !result.isSuccess
                            && result.isSuccessForValidate && warningDescription == '')
                {
                    //added for Enable the Action Again
                    this.isRecordIdAvailable = false;
                    this.responseWork = true;
                    this.showNotification('Portfolio Holdings are not available', 'error', 'sticky');
                    // send notification when error occured.
                    this.completedNotification('');
                }
                else if (result.isSuccessForValidate && result.warningDescription != '') {
                    if (result.requestIdData != '' && result.isSuccess) {
                        console.log('inside warnning message and we will get requestIdData ', result.warningDescription);
                        this.warningDescriptionValue = result.warningDescription;
                        console.log('warningDescriptionValue >> '+ this.warningDescriptionValue);
                        this.getNotificationToken(result.requestIdData);
                    }
                    else if (result.requestIdData != '' && !result.isSuccess) {
                        // TODO : pdf will not genrate we need to show toast message
                        this.requestId = '';
                        //added for Enable the Action Again
                        this.isRecordIdAvailable = false;
                        this.responseWork = true;

                        this.showNotification(this.mediumScanPDFErrorMessage, 'error', 'sticky');
                        // send notification when error occured.
                        this.completedNotification('');
                    }
                }
                else if (result.isSuccessForValidate && result.isSuccess && result.warningDescription == '')
                {
                    if (result.requestIdData != '') {
                        // TODO : we need pass this requestId it to mediumScanResult apex class
                        console.log('inside requestId it to mediumScanResult apex class');
                        console.log(result.requestIdData);
                        this.portfolioName = result.portfolioName;
                        this.getNotificationToken(result.requestIdData);
                    }
                    else if (result.requestIdData == '') {
                        // TODO : pdf will not genrate we need to show error using toast message.
                        this.requestId = '';
                        //added for Enable the Action Again
                        this.isRecordIdAvailable = false;
                        this.responseWork = true;
                        this.showNotification(this.mediumScanPDFErrorMessage, 'error', 'sticky');
                        // send notification when error occured.
                        this.completedNotification('');
                    }
                }
            })
            .catch(error => {
                console.log(error.message);
                this.isRecordIdAvailable = false;
                this.responseWork = true;
                this.showNotification('Document generation failed for '+ this.portfolioName +'. Please try again.', 'error', 'sticky');
                this.completedNotification('');
            })
    }

    getNotificationToken(requestIdData) {
        sendRequest()
            .then(result => {
                if (result.data && result.isSuccess && result.isSuccessForValidate) {
                    console.log('inside token response');
                    console.log(result);
                    this.callVFPage = true;
                    this.getMediumScanRequestVfPage = BASE_URL + '/apex/fe_fundinfo__GetMediumScanRequestIds?token=' + result.data + '&requestId=' + requestIdData + '&baseURL=' + BASE_URL + '&recordId=' + this.recordId;
                } else if (result.data == 'validate' && !result.isSuccess && !result.isSuccessForValidate) {  //TODO: Toast message
                    let message = this.unauthorisedMessage.split('LINK')[0];
                    let urlLabel = this.unauthorisedMessage.split('LINK')[1];
                    let message2 = this.unauthorisedMessage.split('LINK')[2];
                    
                    //added for Enable the Action Again
                    this.isRecordIdAvailable = false;
                    this.responseWork = true;
                    this.showToastNotificationWithHyperLink(message, message2, 'error', urlLabel, this.unauthorisedMessageHyperlink);
                    // send notification when error occured.
                    this.completedNotification('');
                } else if (result.data == 'error' && !result.isSuccess && result.isSuccessForValidate)
                {  //added for Enable the Action Again
                    this.isRecordIdAvailable = false;
                    this.responseWork = true; 
                    // error message when any error occured
                    this.showNotification(this.mediumScanPDFErrorMessage, 'error', 'sticky');
                    // send notification when error occured.
                    this.completedNotification('');
                }
            })
            .catch(error => {
                console.log(error);
                //added for Enable the Action Again
                this.isRecordIdAvailable = false;
                this.responseWork = true;
                this.showNotification('Document generation failed for '+ this.portfolioName +'. Please try again.', 'error', 'sticky');
                // send notification when error occured.
                this.completedNotification('');
            })
    }

    // TODO: We need to pass requestId in this method;
    genrateMediumScanResultPdf(requestId) {
        getMediumScanResult({ requestId: requestId })
            .then(result => {
                console.log(result);
                this.isMediumScanResultCalled = false;
                if (result.data == 'validate' && !result.isSuccess && !result.isSuccessForValidate
                    && result.mediumScanResultErrorMessage == 'validate')
                {
                    let message = this.unauthorisedMessage.split('LINK')[0];
                    let urlLabel = this.unauthorisedMessage.split('LINK')[1];
                    let message2 = this.unauthorisedMessage.split('LINK')[2];
                    //added for Enable the Action Again
                    this.isRecordIdAvailable = false;
                    this.responseWork = true;
                    this.showToastNotificationWithHyperLink(message, message2, 'error', urlLabel, this.unauthorisedMessageHyperlink);
                    // send notification when error occured.
                    this.completedNotification('');
                } else if (result.data == 'error' && !result.isSuccess && result.isSuccessForValidate
                            && result.mediumScanResultErrorMessage != '')
                {
                    // TODO : show toast message and pdf will not generate
                    //added for Enable the Action Again
                    this.isRecordIdAvailable = false;
                    this.responseWork = true;
                    this.showNotification(result.mediumScanResultErrorMessage, 'error', 'sticky');
                    // send notification when error occured.
                    this.completedNotification('');
                } else if (result.data != ''
                            && result.isSuccess
                            && result.isSuccessForValidate
                            && result.mediumScanResultErrorMessage == '')
                {
                    // TODO : here were will show the toast message with Success response and generate pdf
                    console.log('inside pdf generate method');
                    this.pdfResponse = true;
                    this.completedNotification(requestId);
                }
            })
            .catch(error => {
                console.log(error);
                this.isRecordIdAvailable = false;
                this.responseWork = true;
                this.showNotification('Document generation failed for '+ this.portfolioName +'. Please try again.', 'error', 'sticky');
                this.completedNotification('');
            })
    }

    /**
     *  Fetch custom metadata type
     */
    fetchCustomMetaDataForToastMessage() {
        fetchCustomMetaDataType()
            .then(result => {
                console.log(result);
                this.unauthorisedMessage = result.Fe_FundInfo__Unauthorised_Message__c;
                this.unauthorisedMessageHyperlink = result.Fe_FundInfo__Unauthorised_Message_Hyperlink__c;
                this.mediumScanPDFErrorMessage = result.Fe_FundInfo__MediumScanResult_Error_Message__c;
                this.successMessageForMediumScan = result.Fe_FundInfo__MediumScanResult_Success_Message__c;
            })
            .catch(error => {
                console.log(error.message);
            })
    }

    showNotification(message, variant, mode) {
        const evt = new ShowToastEvent({
            title: 'FE Analytics - Medium Scan',
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }

    showToastNotificationWithHyperLink(message, message2, variant, urlLabel, url) {
        const evt = new ShowToastEvent({
            title: 'Invalid FE Analytics User',
            message: message + ' {1} ' + message2,
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

    handleOnLoad() {
        setTimeout(() => {
            if (this.pdfResponse) {
                this.showNotification(this.successMessageForMediumScan, 'success');
            }
        }, this.addLoadingTime * 1000);
    }

    completedNotification(requetedId) {
        let isWarningTextHoldingIdentifier = (this.warningDescriptionValue.startsWith("Holding identifier")) ? true : false;
        let isWarningTextHoldingDuplicate = (this.warningDescriptionValue.startsWith("Duplicated holdings")) ? true : false;
    
        portfolioCompletedNotification({data : requetedId, recordId : this.recordId, isWarningTextHoldingIdentifier: isWarningTextHoldingIdentifier, isWarningTextHoldingDuplicate: isWarningTextHoldingDuplicate }).then(result =>{
            console.log('result>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ');
            console.log(requetedId);
            console.log(this.recordId);
            if(requetedId !== '' && this.warningDescriptionValue === '') {
                this.showNotification('Medium Scan for portfolio ' + this.portfolioName+ ' is now available, go to notifications to open.', 'success');   
            }
            else if (requetedId !== '' && this.warningDescriptionValue !== '') {
                this.showNotification('Medium Scan for portfolio ' + this.portfolioName +' is now available, go to notifications to open. \n' + this.warningDescriptionValue, 'warning', 'sticky');
            }
            this.isRecordIdAvailable = false;
            this.responseWork = true;
        }).catch(error=>{
            console.log('error', error);
        })
    }
}

