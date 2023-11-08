public class GetTokenForNotificationService {
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__GetTokenForNotification_Url__c;
    public static final String HTTP_METHOD_POST = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type'; 
    public static final String HEADER_APPLICATION_JSON = 'application/json';
    
    @AuraEnabled
    public static TokenForNotification sendRequest() {
        return genrateFeFundAuthToken();
    }

    public static TokenForNotification genrateFeFundAuthToken() {
        return vaidate(FeFundAuthToken.generateHeaderToken().access_token);
    }

    private static TokenForNotification vaidate(String headerToken) {
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        TokenForNotification tokenForNotification = new TokenForNotification();
        if(feFundValidateLicenseWrapper.data == true) {
            GetTokenForNotificationServiceWrapper getTokenForNotificationServiceWrapper = createHttpRequest(headerToken);
            if(getTokenForNotificationServiceWrapper.isSuccess){
                tokenForNotification.data = getTokenForNotificationServiceWrapper.data;
                tokenForNotification.isSuccess = getTokenForNotificationServiceWrapper.isSuccess;
                tokenForNotification.isSuccessForValidate = True;
            }else{
                tokenForNotification.data = 'error';
                tokenForNotification.isSuccess = getTokenForNotificationServiceWrapper.isSuccess;
                tokenForNotification.isSuccessForValidate = True;
                tokenForNotification.tokenForNotificationErrorMessage = 'Not working';
            }
        }else {
            tokenForNotification.data = 'validate';
            tokenForNotification.isSuccess = false;
            tokenForNotification.isSuccessForValidate = false;
            tokenForNotification.tokenForNotificationErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Unauthorised_Message__c;
        }
        return tokenForNotification;
    }

    private static GetTokenForNotificationServiceWrapper createHttpRequest(String headerToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('url GetTokenForNotification >> '+ Base_URL + Post_URL);
        request.setEndpoint(Base_URL + Post_URL);
        request.setMethod(HTTP_METHOD_POST);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setBody(generateBody());
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());

        if(response.getStatusCode() == 200) {
            return parse(response.getBody());
        }else{
            return parse(response.getBody());
        }
    }

    private static GetTokenForNotificationServiceWrapper parse(String jsonBody) {
        return (GetTokenForNotificationServiceWrapper) System.JSON.deserialize(jsonBody, GetTokenForNotificationServiceWrapper.class);
    }

    private static String generateBody() {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('userEmail', UserInfo.getUserEmail());
        gen.writeEndObject();
        String requestBody = gen.getAsString();
        System.debug('GetTokenForNotificationService requestBody >> '+ requestBody);
        return requestBody;
    }

    public class GetTokenForNotificationServiceWrapper{
        public String data;
	    public boolean isSuccess;
        public Error error;
    }

    public class Error{
        public Integer errorCode;
        public String message;
        public String traceId;
    }

    public class TokenForNotification {
        @AuraEnabled public String data {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String tokenForNotificationErrorMessage {get; set;}
    }
}