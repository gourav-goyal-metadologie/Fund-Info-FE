public class RenderKIIDocumentService {
    /**
     *	@Custom Metadata Type
     *	Fetch Back_Office_Base_Url__c custom metadata type which will store the
     *	base url. 
     */ 
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).GetKIIDocument_Url__c;
    public static final String HTTP_METHOD_POST = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type'; 
    public static final String HEADER_APPLICATION_JSON = 'application/json';
    public static Boolean IsSTATUS_404 = false;
    public static Boolean IsSTATUS_500 = false;

    public static RenderKIIDocumentServiceToastWrapper sendRequest(Id PortfolioHoldingId) {
        try {
            KIIDocumentUtility.KIIDocumentUtilityWrapper kIIDocumentUtilityWrapper = KIIDocumentUtility.getKIIDocumentUtilityWrapper(PortfolioHoldingId);
            return genrateFeFundAuthToken(kIIDocumentUtilityWrapper);
        } catch (Exception error) {
            LogService.createErrorLog('RenderKIIDocumentService.apxc', NULL, error, NULL);
            return null;
        }
    }
 
    private static RenderKIIDocumentServiceToastWrapper genrateFeFundAuthToken(KIIDocumentUtility.KIIDocumentUtilityWrapper kIIDocumentUtilityWrapper) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return validate(kIIDocumentUtilityWrapper, feFundAuthTokenResponse.access_token);
    }
 
    private static RenderKIIDocumentServiceToastWrapper validate(KIIDocumentUtility.KIIDocumentUtilityWrapper kIIDocumentUtilityWrapper, String headerToken) {
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        RenderKIIDocumentServiceToastWrapper renderKIIDocumentServiceToastWrapperInst = new RenderKIIDocumentServiceToastWrapper();
        
        if(feFundValidateLicenseWrapper.data == true) {
            RenderKIIDocumentServiceWrapper RenderKIIDocumentServiceWrapperInst = createHttpRequest(kIIDocumentUtilityWrapper, headerToken);
            if(RenderKIIDocumentServiceWrapperInst.isSuccess == true){
                renderKIIDocumentServiceToastWrapperInst.data = RenderKIIDocumentServiceWrapperInst.data;
                renderKIIDocumentServiceToastWrapperInst.isSuccess = RenderKIIDocumentServiceWrapperInst.isSuccess;
                renderKIIDocumentServiceToastWrapperInst.isSuccessForValidate = true;
            }else if(RenderKIIDocumentServiceWrapperInst.isSuccess == false){
                renderKIIDocumentServiceToastWrapperInst.data = 'error';
                renderKIIDocumentServiceToastWrapperInst.isSuccess = RenderKIIDocumentServiceWrapperInst.isSuccess;
                renderKIIDocumentServiceToastWrapperInst.isSuccessForValidate = true;
                if(IsSTATUS_404){
                    renderKIIDocumentServiceToastWrapperInst.kiiErrorMessage =  Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Does_Not_Have_KII_Code_Error_Message__c;
                }else if(IsSTATUS_500){
                    renderKIIDocumentServiceToastWrapperInst.kiiErrorMessage =  Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).KII_Error_Message__c;
                }else {
                    renderKIIDocumentServiceToastWrapperInst.kiiErrorMessage =  Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).KII_Error_Message__c;
                }
            }
        }else {
            renderKIIDocumentServiceToastWrapperInst.data = 'vlalidation';
            renderKIIDocumentServiceToastWrapperInst.isSuccess = false;
            renderKIIDocumentServiceToastWrapperInst.isSuccessForValidate = false;
            renderKIIDocumentServiceToastWrapperInst.kiiErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Unauthorised_Message__c;
        }
        return renderKIIDocumentServiceToastWrapperInst;
    }
 
    private static RenderKIIDocumentServiceWrapper createHttpRequest(KIIDocumentUtility.KIIDocumentUtilityWrapper kIIDocumentUtilityWrapper, String headerToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('url KII >> '+ Base_URL + Post_URL);
        request.setEndpoint(Base_URL + Post_URL);
        request.setMethod(HTTP_METHOD_POST);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setBody(generateBody(kIIDocumentUtilityWrapper.code, kIIDocumentUtilityWrapper.instrType));
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());
        if(response.getStatusCode() == 200) {
            return (RenderKIIDocumentServiceWrapper) System.JSON.deserialize(response.getBody(), RenderKIIDocumentServiceWrapper.class);
        } else if(response.getStatusCode() == 404) {
            IsSTATUS_404 = TRUE;
            return (RenderKIIDocumentServiceWrapper) System.JSON.deserialize(response.getBody(), RenderKIIDocumentServiceWrapper.class);
        } else if(response.getStatusCode() == 500) {
        IsSTATUS_500 = TRUE;
        return (RenderKIIDocumentServiceWrapper) System.JSON.deserialize(response.getBody(), RenderKIIDocumentServiceWrapper.class);   
        }
        else{
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
        System.debug('requestBody >> '+ requestBody);
        return requestBody;
    }
     
    public class RenderKIIDocumentServiceWrapper {
        public String data;
        public Boolean isSuccess;
        public Error error;
    }
 
    public class Error {
        public Integer errorCode;	
        public String message;
        public String traceId;
    }

    public class RenderKIIDocumentServiceToastWrapper {
        @AuraEnabled public String data {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String kiiErrorMessage {get; set;}
    }
}