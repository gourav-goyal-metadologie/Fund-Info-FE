import { LightningElement, track, api } from 'lwc';
import IMAGES from '@salesforce/resourceUrl/FE_FundInfo_Logo';

export default class Test extends LightningElement {
    @api recordId;
    isRecordAvailable = true;

    @api async invoke() {
        if (this.recordId && this.isRecordAvailable) {
            console.log('inside invoke function');

            // window.open('www.google.com', '_blank');
            location = 'www.google.com';
            this.isRecordAvailable = false;
        }
        else {
            console.log('inside else part');
        }
    }


}