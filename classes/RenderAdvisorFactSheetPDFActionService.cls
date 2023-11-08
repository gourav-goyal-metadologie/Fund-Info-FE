public class RenderAdvisorFactSheetPDFActionService {
    public static string dataFromApex;
    public String base64Data {get; set;}
    public RenderAdvisorFactSheetPDFActionService() {
        Id recordId = ApexPages.currentPage().getParameters().get('data');
        RenderAdvisorFactSheetPDFService.RenderAdvisorFactSheetPDFServiceToastWrapper renderAdvisorFactSheetPDFServiceToastWrapperInst  = getAdvisorFactSheetPDF(recordId);

        if (String.isNotBlank(renderAdvisorFactSheetPDFServiceToastWrapperInst.data)) {
            this.base64Data = 'data:application/pdf;base64,'+ getAdvisorFactSheetPDF(recordId).data;
        }
    }

    @AuraEnabled(cacheable=false)
    public static RenderAdvisorFactSheetPDFService.RenderAdvisorFactSheetPDFServiceToastWrapper getAdvisorFactSheetPDF(Id portfolioHoldingId){
        System.debug('portfolioHoldingId -- '+ portfolioHoldingId);
        return RenderAdvisorFactSheetPDFService.sendRequest(portfolioHoldingId);
    }

    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT
                    Id,
                    Fe_FundInfo__AdvisorFactSheet_Error_Message__c,
                    Fe_FundInfo__AdvisorFactSheet_Success_Message__c,
                    Fe_FundInfo__Does_Not_Have_AFS_Code_Error_Message__c,
                    Fe_FundInfo__Unauthorised_Message__c,
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c
                FROM Fe_FundInfo__FE_EndPoint__mdt WITH SECURITY_ENFORCED];
    }
}