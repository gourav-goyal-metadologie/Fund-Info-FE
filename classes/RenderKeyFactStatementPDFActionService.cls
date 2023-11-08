public class RenderKeyFactStatementPDFActionService {
    public String base64Data {get; set;}
    public RenderKeyFactStatementPDFActionService() {
        Id recordId = ApexPages.currentPage().getParameters().get('data');
        RenderKeyFactStatementService.RenderKeyFactStatementServiceToastWrapper RenderKeyFactStatementServiceToastWrapperInst  = getKeyFactStatementPDF(recordId);

        if (String.isNotBlank(RenderKeyFactStatementServiceToastWrapperInst.data)) {
            this.base64Data = 'data:application/pdf;base64,'+ getKeyFactStatementPDF(recordId).data;
        }
    }

    @AuraEnabled(cacheable=false)
    public static RenderKeyFactStatementService.RenderKeyFactStatementServiceToastWrapper getKeyFactStatementPDF(Id portfolioHoldingId){
        System.debug('portfolioHoldingId -- '+ portfolioHoldingId);
        return RenderKeyFactStatementService.sendRequest(portfolioHoldingId);
    }

    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT Id,
                    Fe_FundInfo__KeyFactStatement_PDF_Success_Message__c,
                    Fe_FundInfo__Does_Not_Have_KFS_Code_Error_Message__c,
                    Fe_FundInfo__KFS_Invalid_Code_Error_Message__c,
                    Fe_FundInfo__Unauthorised_Message__c, 
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c
                    FROM Fe_FundInfo__FE_EndPoint__mdt WITH SECURITY_ENFORCED
                ];
    }
}