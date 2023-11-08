import { LightningElement, track, api } from 'lwc';

export default class CustomToast extends LightningElement {
    @track showToastBar = false;
    @api toastTitle = 'Medium Scan with title';
    @api toastMessage = 'Medium Scan Successfully Generated';
    @api toastIconName = 'utility:success';
    @api isAutoCloseAble = false;
    @api isSuccessToast = false;
    @api isErrorToast = false;
    @api isWarningToast = false;
    @api isErrorWithHyperLinkToast = false;
    @api autoCloseTime = 5000;

    @api firstToastMessageHyperLink;
    @api secondToastMessageHyperLink;
    @api hyperLinkLabelName;
    @api hyperLinkUrl;

    connectedCallback() {
        this.showToastBar = true;

        if (this.isAutoCloseAble === true) {
            setTimeout(() => {
                this.closeModel();
            }, this.autoCloseTime);
        }
    }

    closeModel() {
        this.showToastBar = false;
    }
}