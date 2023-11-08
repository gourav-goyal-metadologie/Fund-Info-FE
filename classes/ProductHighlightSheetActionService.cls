public class ProductHighlightSheetActionService {

    public String base64Data {get; set;}

    public ProductHighlightSheetActionService() {

        Id recordId = ApexPages.currentPage().getParameters().get('data');

        ProductHighlightSheetPDFService.ProductHighlightSheetPDFServiceToastWrapper productHighlightSheetPDFServiceToastWrapper  = getProductHighlightSheetPDF(recordId);

        if (String.isNotBlank(productHighlightSheetPDFServiceToastWrapper.data)) {
            this.base64Data = 'data:application/pdf;base64,'+ productHighlightSheetPDFServiceToastWrapper.data;  
        }

    }

    @AuraEnabled(cacheable=false)
    public static ProductHighlightSheetPDFService.ProductHighlightSheetPDFServiceToastWrapper getProductHighlightSheetPDF(Id portfolioHoldingId){
        System.debug('portfolioHoldingId -- '+ portfolioHoldingId);
        return ProductHighlightSheetPDFService.sendRequest(portfolioHoldingId);
    }

    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT
                    Id,
                    Fe_FundInfo__ProductHighlightSheet_Error_Message__c,
                    Fe_FundInfo__ProductHighlightSheet_Success_Message__c,
                    Fe_FundInfo__Does_Not_Have_PHS_Code_Error_Message__c,
                    Fe_FundInfo__Unauthorised_Message__c,
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c
                FROM Fe_FundInfo__FE_EndPoint__mdt WITH SECURITY_ENFORCED];
    }

}