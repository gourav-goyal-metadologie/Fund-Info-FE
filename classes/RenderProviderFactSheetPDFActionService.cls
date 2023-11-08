public class RenderProviderFactSheetPDFActionService {
    public String base64Data {get; set;}

    public RenderProviderFactSheetPDFActionService() {
        String recordId = ApexPages.currentPage().getParameters().get('data');
        RenderProviderFactSheetPDFService.RenderProviderFactSheetPDFServiceToastWrapper renderProviderFactSheetPDFServiceToastWrapperInst  = getProviderFactSheetPDF(recordId);

        if (String.isNotBlank(renderProviderFactSheetPDFServiceToastWrapperInst.data)) {
            this.base64Data = 'data:application/pdf;base64,'+ getProviderFactSheetPDF(recordId).data;
        }
    }

    @AuraEnabled(cacheable=false)
    public static RenderProviderFactSheetPDFService.RenderProviderFactSheetPDFServiceToastWrapper getProviderFactSheetPDF(String portfolioHoldingId){
        System.debug('portfolioHoldingId -- '+ portfolioHoldingId);
        return RenderProviderFactSheetPDFService.sendRequest(portfolioHoldingId);
    }

    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT 
                    Id,
                    Fe_FundInfo__ProviderFactSheet_Error_Message__c,
                    Fe_FundInfo__Does_Not_Have_PFS_Code_Error_Message__c,
                    Fe_FundInfo__ProviderFactSheet_Success_Message__c,
                    Fe_FundInfo__Unauthorised_Message__c, 
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c
                FROM Fe_FundInfo__FE_EndPoint__mdt WITH SECURITY_ENFORCED];
    }
}