public class RenderGetMediumScanResult {
    /**
     *	@Custom Metadata Type
     *	Fetch Back_Office_Base_Url__c custom metadata type which will store the
     *	base url. 
     */ 
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__MediumScanResult_Url__c;
    public static final String HTTP_METHOD_GET = 'GET';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type'; 
    public static final String HEADER_APPLICATION_JSON = 'application/json';
    public static Boolean IsSTATUS_404 = false;
    public static Boolean IsSTATUS_500 = false;

    public static RenderGetMediumScanResultToastWrapper sendRequest(String requestId) {
        try {
            return genrateFeFundAuthToken(requestId);
        } catch (Exception error) {
            LogService.createErrorLog('RenderGetMediumScanResult.apxc', NULL, error, NULL);
            return Null;
        }
    }

    private static RenderGetMediumScanResultToastWrapper genrateFeFundAuthToken(String requestId) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return validate(feFundAuthTokenResponse.access_token, requestId);
    }

    private static RenderGetMediumScanResultToastWrapper validate(String headerToken, String requestId) {
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        RenderGetMediumScanResultToastWrapper renderGetMediumScanResultToastWrapper = new RenderGetMediumScanResultToastWrapper();
        if(feFundValidateLicenseWrapper.data == true) {
            RenderGetMediumScanResultWrapper renderGetMediumScanResultWrapper = createHttpRequest(headerToken, requestId);
            if(renderGetMediumScanResultWrapper.isSuccess == true){
                renderGetMediumScanResultToastWrapper.data = renderGetMediumScanResultWrapper.data;
                renderGetMediumScanResultToastWrapper.isSuccess = renderGetMediumScanResultWrapper.isSuccess;
                renderGetMediumScanResultToastWrapper.isSuccessForValidate = true;
                renderGetMediumScanResultToastWrapper.mediumScanResultErrorMessage = '';
            }else if(renderGetMediumScanResultWrapper.isSuccess == false){
                renderGetMediumScanResultToastWrapper.data = 'error';
                renderGetMediumScanResultToastWrapper.isSuccess = renderGetMediumScanResultWrapper.isSuccess;
                renderGetMediumScanResultToastWrapper.isSuccessForValidate = true;
                if(IsSTATUS_404){
                    renderGetMediumScanResultToastWrapper.mediumScanResultErrorMessage =  Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Does_Not_Have_MSR_Code_Error_Message__c;
                }else if(IsSTATUS_500){
                    renderGetMediumScanResultToastWrapper.mediumScanResultErrorMessage =  Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__MediumScanResult_Error_Message__c;
                }else {
                    renderGetMediumScanResultToastWrapper.mediumScanResultErrorMessage =  Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__MediumScanResult_Error_Message__c;
                }
            }
        }else if (feFundValidateLicenseWrapper.data == false) {
            renderGetMediumScanResultToastWrapper.data = 'validate';
            renderGetMediumScanResultToastWrapper.isSuccess = false;
            renderGetMediumScanResultToastWrapper.isSuccessForValidate = false;
            renderGetMediumScanResultToastWrapper.mediumScanResultErrorMessage = 'validate';
        }
        return renderGetMediumScanResultToastWrapper;
    }

    private static RenderGetMediumScanResultWrapper createHttpRequest(String headerToken, String requestId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('GetMediumScanresult Url >> '+ Base_URL + Post_URL + requestId);
        request.setEndpoint(Base_URL + Post_URL + requestId);
        request.setMethod(HTTP_METHOD_GET);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());

        if(response.getStatusCode() == 200) {
            return (RenderGetMediumScanResultWrapper) System.JSON.deserialize(response.getBody(), RenderGetMediumScanResultWrapper.class);
        }else if(response.getStatusCode() == 404) {
            IsSTATUS_404 = TRUE;
            return (RenderGetMediumScanResultWrapper) System.JSON.deserialize(response.getBody(), RenderGetMediumScanResultWrapper.class);
        }else if(response.getStatusCode() == 500) {
            IsSTATUS_500 = TRUE;
            return (RenderGetMediumScanResultWrapper) System.JSON.deserialize(response.getBody(), RenderGetMediumScanResultWrapper.class);   
        }else {
            return null;
        }
    }

    public class RenderGetMediumScanResultWrapper {
        public String data;
        public Boolean isSuccess;
        public Error error;
    }

    public class Error {
        public Integer errorCode;	
        public String message;
        public String traceId;
    }

    public class RenderGetMediumScanResultToastWrapper {
        @AuraEnabled public String data {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String mediumScanResultErrorMessage {get; set;}
    }
    
}