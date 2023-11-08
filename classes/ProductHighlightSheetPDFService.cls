public class ProductHighlightSheetPDFService {
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__ProductHighlightSheet_Url__c;
    public static final String HTTP_METHOD_POST = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type';
    public static final String HEADER_APPLICATION_JSON = 'application/json';
    public static Boolean IsSTATUS_404 = false;
    public static Boolean IsSTATUS_500 = false;

    public static ProductHighlightSheetPDFServiceToastWrapper sendRequest(Id portfolioHoldingId) {
        try {
            ProductHighlightSheetUtility.ProductHighlightSheetUtilityWrapper productHighlightSheetUtilityWrapper = ProductHighlightSheetUtility.getProductHighlightSheetUtilityWrapper(portfolioHoldingId);
            return genrateFeFundAuthToken(productHighlightSheetUtilityWrapper);
        } catch (Exception error) {
            LogService.createErrorLog('ProductHighlightSheetPDFService.apxc', NULL, error, NULL);
            return null;
        }
    }

    public static ProductHighlightSheetPDFServiceToastWrapper genrateFeFundAuthToken(ProductHighlightSheetUtility.ProductHighlightSheetUtilityWrapper productHighlightSheetUtilityWrapper) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return validate(productHighlightSheetUtilityWrapper, feFundAuthTokenResponse.access_token);
    }

    private static ProductHighlightSheetPDFServiceToastWrapper validate(ProductHighlightSheetUtility.ProductHighlightSheetUtilityWrapper productHighlightSheetUtilityWrapper, String headerToken) {
        
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        
        ProductHighlightSheetPDFServiceToastWrapper productHighlightSheetPDFServiceToastWrapper = new ProductHighlightSheetPDFServiceToastWrapper();
        
        if(feFundValidateLicenseWrapper.data == true) {
            ProductHighlightSheetPDFServiceWrapper productHighlightSheetPDFServiceWrapper = createHttpRequest(productHighlightSheetUtilityWrapper, headerToken);
            if(productHighlightSheetPDFServiceWrapper.isSuccess == true) {
                productHighlightSheetPDFServiceToastWrapper.data = productHighlightSheetPDFServiceWrapper.data;
                productHighlightSheetPDFServiceToastWrapper.isSuccess = productHighlightSheetPDFServiceWrapper.isSuccess;
                productHighlightSheetPDFServiceToastWrapper.isSuccessForValidate = true;
            }
            else if(productHighlightSheetPDFServiceWrapper.isSuccess == false) {
                productHighlightSheetPDFServiceToastWrapper.data = 'error';
                productHighlightSheetPDFServiceToastWrapper.isSuccess = productHighlightSheetPDFServiceWrapper.isSuccess;
                productHighlightSheetPDFServiceToastWrapper.isSuccessForValidate = true;
                if(IsSTATUS_404) {
                    productHighlightSheetPDFServiceToastWrapper.productHighlightSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Does_Not_Have_PHS_Code_Error_Message__c;
                }
                else if(IsSTATUS_500) {
                    productHighlightSheetPDFServiceToastWrapper.productHighlightSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__ProductHighlightSheet_Error_Message__c;
                }
                else {
                    productHighlightSheetPDFServiceToastWrapper.productHighlightSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__ProductHighlightSheet_Error_Message__c;
                }
            }
        }
        else {
            productHighlightSheetPDFServiceToastWrapper.data = 'vlalidation';
            productHighlightSheetPDFServiceToastWrapper.isSuccess = false;
            productHighlightSheetPDFServiceToastWrapper.isSuccessForValidate = false;
            productHighlightSheetPDFServiceToastWrapper.productHighlightSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Unauthorised_Message__c;
        }
        return productHighlightSheetPDFServiceToastWrapper;

    }

    private static ProductHighlightSheetPDFServiceWrapper createHttpRequest(ProductHighlightSheetUtility.ProductHighlightSheetUtilityWrapper productHighlightSheetUtilityWrapper, String headerToken) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('url ProductHighlightSheet >> '+ Base_URL + Post_URL);
        request.setEndpoint(Base_URL + Post_URL);
        request.setMethod(HTTP_METHOD_POST);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setBody(generateBody(productHighlightSheetUtilityWrapper.code, productHighlightSheetUtilityWrapper.instrType));
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());
        if(response.getStatusCode() == 200) {
            return (ProductHighlightSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), ProductHighlightSheetPDFServiceWrapper.class);
        }
        else if(response.getStatusCode() == 404) {
            IsSTATUS_404 = TRUE;
            return (ProductHighlightSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), ProductHighlightSheetPDFServiceWrapper.class);
        }
        else if(response.getStatusCode() == 500) {
            IsSTATUS_500 = TRUE;
            return (ProductHighlightSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), ProductHighlightSheetPDFServiceWrapper.class);
        }
        else {
            return null;
        }

    }

    private static String generateBody(String code, String instrType) {

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('userEmail', UserInfo.getUserEmail());
        gen.writeStringField('code', code);
        gen.writeStringField('instrType', instrType);
        gen.writeEndObject();
        String requestBody = gen.getAsString();
        System.debug('FundFactSheetDetailed requestBody >> '+ requestBody);
        return requestBody;

    }

    public class ProductHighlightSheetPDFServiceWrapper {

        public String data;
        public Boolean isSuccess;
        public Error error;

    }

    public class Error {

		public Integer errorCode;
		public String message;
		public String traceId;

	}

    public class ProductHighlightSheetPDFServiceToastWrapper {

        @AuraEnabled public String data {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String productHighlightSheetErrorMessage {get; set;}

    }

}