public class RenderKIIDocumentPDFActionService {
    public String base64Data {get; set;}
    public RenderKIIDocumentPDFActionService() {
        Id recordId = ApexPages.currentPage().getParameters().get('data');
        RenderKIIDocumentService.RenderKIIDocumentServiceToastWrapper renderKIIDocumentServiceToastWrapperInst  = getKIIDocumentPDF(recordId);

        if (String.isNotBlank(renderKIIDocumentServiceToastWrapperInst.data)) {
            this.base64Data = 'data:application/pdf;base64,'+ getKIIDocumentPDF(recordId).data;
        }
    }

    @AuraEnabled(cacheable=false)
    public static RenderKIIDocumentService.RenderKIIDocumentServiceToastWrapper getKIIDocumentPDF(String portfolioHoldingId){
        System.debug('portfolioHoldingId -- '+ portfolioHoldingId);
        return RenderKIIDocumentService.sendRequest(portfolioHoldingId);
    }

    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT Id,
                    Fe_FundInfo__KII_Error_Message__c,
                    Fe_FundInfo__KII_Success_Message__c,
                    Fe_FundInfo__Unauthorised_Message__c, 
                    Fe_FundInfo__Does_Not_Have_KII_Code_Error_Message__c,
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c
                    FROM Fe_FundInfo__FE_EndPoint__mdt WITH SECURITY_ENFORCED
                ];
    }
}