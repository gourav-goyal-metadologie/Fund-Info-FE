public class RenderAdvisorFactSheetPDFService {
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__AdvisorFactSheet_Url__c;
    public static final String HTTP_METHOD_POST = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type'; 
    public static final String HEADER_APPLICATION_JSON = 'application/json';
    public static Boolean IsSTATUS_404 = false;
    public static Boolean IsSTATUS_500 = false;

    public static RenderAdvisorFactSheetPDFServiceToastWrapper sendRequest(Id portfolioHoldingId) {
        try {
            AdviserFactSheetUtility.AdviserFactSheetUtilityWrapper adviserFactSheetUtility = AdviserFactSheetUtility.getAdviserFactSheetUtilityWrapper(portfolioHoldingId);
            return genrateFeFundAuthToken(adviserFactSheetUtility);
        } catch (Exception error) {
            LogService.createErrorLog('RenderAdvisorFactSheetPDFService.apxc', NULL, error, NULL);
            return null;
        }
    }

    public static RenderAdvisorFactSheetPDFServiceToastWrapper genrateFeFundAuthToken(AdviserFactSheetUtility.AdviserFactSheetUtilityWrapper adviserFactSheetUtility) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return validate(adviserFactSheetUtility, feFundAuthTokenResponse.access_token);
    }

    private static RenderAdvisorFactSheetPDFServiceToastWrapper validate(AdviserFactSheetUtility.AdviserFactSheetUtilityWrapper adviserFactSheetUtility, String headerToken) {
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        RenderAdvisorFactSheetPDFServiceToastWrapper renderAdvisorFactSheetPDFServiceToastWrapperInst = new RenderAdvisorFactSheetPDFServiceToastWrapper();
        if(feFundValidateLicenseWrapper.data == true) {
            RenderAdvisorFactSheetPDFServiceWrapper renderAdvisorFactSheetPDFServiceWrapperInst = createHttpRequest(adviserFactSheetUtility, headerToken);
            if(renderAdvisorFactSheetPDFServiceWrapperInst.isSuccess == true){
                renderAdvisorFactSheetPDFServiceToastWrapperInst.data = renderAdvisorFactSheetPDFServiceWrapperInst.data;
                renderAdvisorFactSheetPDFServiceToastWrapperInst.isSuccess = renderAdvisorFactSheetPDFServiceWrapperInst.isSuccess;
                renderAdvisorFactSheetPDFServiceToastWrapperInst.isSuccessForValidate = true;
            }else if(renderAdvisorFactSheetPDFServiceWrapperInst.isSuccess == false){
                renderAdvisorFactSheetPDFServiceToastWrapperInst.data = 'error';
                renderAdvisorFactSheetPDFServiceToastWrapperInst.isSuccess = renderAdvisorFactSheetPDFServiceWrapperInst.isSuccess;
                renderAdvisorFactSheetPDFServiceToastWrapperInst.isSuccessForValidate = true;
                if(IsSTATUS_404){
                    renderAdvisorFactSheetPDFServiceToastWrapperInst.advisorFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Does_Not_Have_AFS_Code_Error_Message__c;
                }else if(IsSTATUS_500){
                    renderAdvisorFactSheetPDFServiceToastWrapperInst.advisorFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__AdvisorFactSheet_Error_Message__c;
                }else{
                    renderAdvisorFactSheetPDFServiceToastWrapperInst.advisorFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__AdvisorFactSheet_Error_Message__c;
                }
            }
        }else {
            renderAdvisorFactSheetPDFServiceToastWrapperInst.data = 'vlalidation';
            renderAdvisorFactSheetPDFServiceToastWrapperInst.isSuccess = false;
            renderAdvisorFactSheetPDFServiceToastWrapperInst.isSuccessForValidate = false;
            renderAdvisorFactSheetPDFServiceToastWrapperInst.advisorFactSheetErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Unauthorised_Message__c;
        }
        System.debug('renderAdvisorFactSheetPDFServiceToastWrapperInst > '+ renderAdvisorFactSheetPDFServiceToastWrapperInst);
        return renderAdvisorFactSheetPDFServiceToastWrapperInst;
    }

    private static RenderAdvisorFactSheetPDFServiceWrapper createHttpRequest(AdviserFactSheetUtility.AdviserFactSheetUtilityWrapper adviserFactSheetUtility, String headerToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('url AdvisorFactSheet >> '+ Base_URL + Post_URL);
        request.setEndpoint(Base_URL + Post_URL);
        request.setMethod(HTTP_METHOD_POST);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setBody(generateBody(adviserFactSheetUtility.code, adviserFactSheetUtility.instrType));
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());
        if(response.getStatusCode() == 200) {
            return (RenderAdvisorFactSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), RenderAdvisorFactSheetPDFServiceWrapper.class);
        }else if(response.getStatusCode() == 404){
            IsSTATUS_404 = TRUE;
            return (RenderAdvisorFactSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), RenderAdvisorFactSheetPDFServiceWrapper.class);
        }else if(response.getStatusCode() == 500){
            IsSTATUS_500 = TRUE;
            return (RenderAdvisorFactSheetPDFServiceWrapper) System.JSON.deserialize(response.getBody(), RenderAdvisorFactSheetPDFServiceWrapper.class);
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
        System.debug('AdvisorFactSheet requestBody >> '+ requestBody);
        return requestBody;
    }

    public class RenderAdvisorFactSheetPDFServiceWrapper {
        public String data;
        public Boolean isSuccess;
        public Error error;
    }

    public class Error {
		public Integer errorCode;	
		public String message;
		public String traceId;
	}

    public class RenderAdvisorFactSheetPDFServiceToastWrapper {
        @AuraEnabled public String data {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String advisorFactSheetErrorMessage {get; set;}
    }
}