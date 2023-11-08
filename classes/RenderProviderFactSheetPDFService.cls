public class RenderProviderFactSheetPDFService {

    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__ProviderFactSheet_Url__c;
    public static final String HTTP_METHOD_POST = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type'; 
    public static final String HEADER_APPLICATION_JSON = 'application/json';
    public static Boolean IsSTATUS_404 = false;
    public static Boolean IsSTATUS_500 = false;


    public static RenderProviderFactSheetPDFServiceToastWrapper sendRequest(String portfolioHoldingId) {
        try {
           ProviderFactSheetUtility.ProviderFactSheetUtilityWrapper providerFactSheetUtilityWrapper  =  ProviderFactSheetUtility.getProviderFactSheetUtilityWrapper(portfolioHoldingId); 
           return genrateFeFundAuthToken(providerFactSheetUtilityWrapper);
        } catch (Exception error) {
            LogService.createErrorLog('RenderProviderFactSheetPDFService.apxc', NULL, error, NULL);
            return null;
        }
    }

    private static RenderProviderFactSheetPDFServiceToastWrapper genrateFeFundAuthToken(ProviderFactSheetUtility.ProviderFactSheetUtilityWrapper providerFactSheetUtilityWrapper) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return vaidate(providerFactSheetUtilityWrapper, feFundAuthTokenResponse.access_token);
    }

    private static RenderProviderFactSheetPDFServiceToastWrapper vaidate(ProviderFactSheetUtility.ProviderFactSheetUtilityWrapper providerFactSheetUtilityWrapper, String headerToken) {
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        RenderProviderFactSheetPDFServiceToastWrapper renderProviderFactSheetPDFServiceToastWrapperInst = new RenderProviderFactSheetPDFServiceToastWrapper();
        
        if(feFundValidateLicenseWrapper.data == true) {
            RenderProviderFactSheetPDFServiceWrapper renderProviderFactSheetPDFServiceWrapperInst = createHttpRequest(providerFactSheetUtilityWrapper, headerToken);
            System.debug('renderProviderFactSheetPDFServiceWrapperInst >> ' + renderProviderFactSheetPDFServiceWrapperInst);
            if(renderProviderFactSheetPDFServiceWrapperInst.isSuccess == true){
                renderProviderFactSheetPDFServiceToastWrapperInst.data = renderProviderFactSheetPDFServiceWrapperInst.data;
                renderProviderFactSheetPDFServiceToastWrapperInst.isSuccess = renderProviderFactSheetPDFServiceWrapperInst.isSuccess;
                renderProviderFactSheetPDFServiceToastWrapperInst.isSuccessForValidate = true;
            }else if(renderProviderFactSheetPDFServiceWrapperInst.isSuccess == false){
                renderProviderFactSheetPDFServiceToastWrapperInst.data = 'error';
                renderProviderFactSheetPDFServiceToastWrapperInst.isSuccess = renderProviderFactSheetPDFServiceWrapperInst.isSuccess;
                renderProviderFactSheetPDFServiceToastWrapperInst.isSuccessForValidate = true;
                if(IsSTATUS_404){
                    renderProviderFactSheetPDFServiceToastWrapperInst.providerFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Does_Not_Have_PFS_Code_Error_Message__c;
                }else if(IsSTATUS_500){
                    renderProviderFactSheetPDFServiceToastWrapperInst.providerFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__ProviderFactSheet_Error_Message__c;
                }else{
                    renderProviderFactSheetPDFServiceToastWrapperInst.providerFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__ProviderFactSheet_Error_Message__c;
                }
            }
        }else {
            renderProviderFactSheetPDFServiceToastWrapperInst.data = 'vlalidation';
            renderProviderFactSheetPDFServiceToastWrapperInst.isSuccess = false;
            renderProviderFactSheetPDFServiceToastWrapperInst.isSuccessForValidate = false;
            renderProviderFactSheetPDFServiceToastWrapperInst.providerFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Unauthorised_Message__c;
        }
        System.debug('renderProviderFactSheetPDFServiceToastWrapperInst >> '+ renderProviderFactSheetPDFServiceToastWrapperInst);
        return renderProviderFactSheetPDFServiceToastWrapperInst;
    }

    private static RenderProviderFactSheetPDFServiceWrapper createHttpRequest(ProviderFactSheetUtility.ProviderFactSheetUtilityWrapper providerFactSheetUtilityWrapper, String headerToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('url ProviderFactSheet >> '+ Base_URL + Post_URL);
        request.setEndpoint(Base_URL + Post_URL);
        request.setMethod(HTTP_METHOD_POST);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setBody(generateBody(providerFactSheetUtilityWrapper.code, providerFactSheetUtilityWrapper.instrType));
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());
        if(response.getStatusCode() == 200) {
            return (RenderProviderFactSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), RenderProviderFactSheetPDFServiceWrapper.class);
        }else if(response.getStatusCode() == 404){
            IsSTATUS_404 = TRUE;
            return (RenderProviderFactSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), RenderProviderFactSheetPDFServiceWrapper.class);
        }else if(response.getStatusCode() == 500){
            IsSTATUS_500 = TRUE;
            System.debug('inside 500');
            return (RenderProviderFactSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), RenderProviderFactSheetPDFServiceWrapper.class);
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
        System.debug('ProviderFactSheet requestBody >> '+ requestBody);
        return requestBody;
    }
    
    public class RenderProviderFactSheetPDFServiceWrapper {
        public String data;
        public Boolean isSuccess;
        public Error error;
    }

    public class Error {
		public Integer errorCode;	
		public String message;
		public String traceId;
	}

    public class RenderProviderFactSheetPDFServiceToastWrapper {
        @AuraEnabled public String data {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String providerFactSheetErrorMessage {get; set;}
    }
}