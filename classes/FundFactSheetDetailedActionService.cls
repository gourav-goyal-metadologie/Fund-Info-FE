public class FundFactSheetDetailedActionService {

    public String base64Data {get; set;}

    public FundFactSheetDetailedActionService() {
        Id recordId = ApexPages.currentPage().getParameters().get('data');
        FundFactSheetDetailedPDFService.FundFactSheetDetailedPDFServiceToastWrapper fundFactSheetDetailedPDFServiceToastWrapper  = getFundFactSheetDetailedPDF(recordId);

        if (String.isNotBlank(fundFactSheetDetailedPDFServiceToastWrapper.data) && fundFactSheetDetailedPDFServiceToastWrapper.data != 'error') {
            System.debug('inside if condition');
            this.base64Data = 'data:application/pdf;base64,'+ getFundFactSheetDetailedPDF(recordId).data;
        }
    }

    @AuraEnabled(cacheable=false)
    public static FundFactSheetDetailedPDFService.FundFactSheetDetailedPDFServiceToastWrapper getFundFactSheetDetailedPDF(Id portfolioHoldingId){
        System.debug('portfolioHoldingId -- '+ portfolioHoldingId);
        return FundFactSheetDetailedPDFService.sendRequest(portfolioHoldingId);
    }

    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT
                    Id,
                    Fe_FundInfo__FFSD_Error_Message__c,
                    Fe_FundInfo__FundFactSheetDetailed_Success_Message__c,
                    Fe_FundInfo__Does_Not_Have_FFSD_Code_Error_Message__c,
                    Fe_FundInfo__Unauthorised_Message__c,
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c
                FROM Fe_FundInfo__FE_EndPoint__mdt WITH SECURITY_ENFORCED];
    }

}