public class FundFactSheetDetailedPDFService {
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__FundFactSheetDetailed_Url__c;
    public static final String HTTP_METHOD_POST = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type'; 
    public static final String HEADER_APPLICATION_JSON = 'application/json';
    public static Boolean IsSTATUS_404 = false;
    public static Boolean IsSTATUS_500 = false;

    public static FundFactSheetDetailedPDFServiceToastWrapper sendRequest(Id portfolioHoldingId) {
        try {
            FundFactSheetDetailedUtility.FundFactSheetDetailedUtilityWrapper fundFactSheetDetailedUtility = FundFactSheetDetailedUtility.getFundFactSheetDetailedUtilityWrapper(portfolioHoldingId);
            return genrateFeFundAuthToken(fundFactSheetDetailedUtility);
        } catch (Exception error) {
            LogService.createErrorLog('FundFactSheetDetailedPDFService.apxc', NULL, error, NULL);
            return null;
        }
    }

    public static FundFactSheetDetailedPDFServiceToastWrapper genrateFeFundAuthToken(FundFactSheetDetailedUtility.FundFactSheetDetailedUtilityWrapper fundFactSheetDetailedUtility) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return validate(fundFactSheetDetailedUtility, feFundAuthTokenResponse.access_token);
    }

    private static FundFactSheetDetailedPDFServiceToastWrapper validate(FundFactSheetDetailedUtility.FundFactSheetDetailedUtilityWrapper fundFactSheetDetailedUtility, String headerToken) {
        
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        
        FundFactSheetDetailedPDFServiceToastWrapper fundFactSheetDetailedPDFServiceToastWrapper = new FundFactSheetDetailedPDFServiceToastWrapper();
        
        if(feFundValidateLicenseWrapper.data == true) {
            FundFactSheetDetailedPDFServiceWrapper FundFactSheetDetailedPDFServiceWrapper = createHttpRequest(fundFactSheetDetailedUtility, headerToken);
            if(FundFactSheetDetailedPDFServiceWrapper.isSuccess == true){
                fundFactSheetDetailedPDFServiceToastWrapper.data = FundFactSheetDetailedPDFServiceWrapper.data;
                fundFactSheetDetailedPDFServiceToastWrapper.isSuccess = FundFactSheetDetailedPDFServiceWrapper.isSuccess;
                fundFactSheetDetailedPDFServiceToastWrapper.isSuccessForValidate = true;
            }else if(FundFactSheetDetailedPDFServiceWrapper.isSuccess == false){
                fundFactSheetDetailedPDFServiceToastWrapper.data = 'error';
                fundFactSheetDetailedPDFServiceToastWrapper.isSuccess = FundFactSheetDetailedPDFServiceWrapper.isSuccess;
                fundFactSheetDetailedPDFServiceToastWrapper.isSuccessForValidate = true;
                if(IsSTATUS_404){
                    fundFactSheetDetailedPDFServiceToastWrapper.fundFactSheetDetailedErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Does_Not_Have_FFSD_Code_Error_Message__c;
                }else if(IsSTATUS_500){
                    fundFactSheetDetailedPDFServiceToastWrapper.fundFactSheetDetailedErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__FFSD_Error_Message__c;
                }else{
                    fundFactSheetDetailedPDFServiceToastWrapper.fundFactSheetDetailedErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__FFSD_Error_Message__c;
                }
            }
        }else {
            fundFactSheetDetailedPDFServiceToastWrapper.data = 'vlalidation';
            fundFactSheetDetailedPDFServiceToastWrapper.isSuccess = false;
            fundFactSheetDetailedPDFServiceToastWrapper.isSuccessForValidate = false;
            fundFactSheetDetailedPDFServiceToastWrapper.fundFactSheetDetailedErrorMessage = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Unauthorised_Message__c;
        }
        return fundFactSheetDetailedPDFServiceToastWrapper;
    }

    private static FundFactSheetDetailedPDFServiceWrapper createHttpRequest(FundFactSheetDetailedUtility.FundFactSheetDetailedUtilityWrapper fundFactSheetDetailedUtility, String headerToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('url AdvisorFactSheet >> '+ Base_URL + Post_URL);
        request.setEndpoint(Base_URL + Post_URL);
        request.setMethod(HTTP_METHOD_POST);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setBody(generateBody(fundFactSheetDetailedUtility.code, fundFactSheetDetailedUtility.instrType));
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());
        if(response.getStatusCode() == 200) {
            return (FundFactSheetDetailedPDFServiceWrapper) System.JSON.deserialize(response.getBody(), FundFactSheetDetailedPDFServiceWrapper.class);
        }else if(response.getStatusCode() == 404){
            IsSTATUS_404 = TRUE;
            return (FundFactSheetDetailedPDFServiceWrapper) System.JSON.deserialize(response.getBody(), FundFactSheetDetailedPDFServiceWrapper.class);
        }else if(response.getStatusCode() == 500){
            IsSTATUS_500 = TRUE;
            return (FundFactSheetDetailedPDFServiceWrapper) System.JSON.deserialize(response.getBody(), FundFactSheetDetailedPDFServiceWrapper.class);
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
        System.debug('FundFactSheetDetailed requestBody >> '+ requestBody);
        return requestBody;
    }

    public class FundFactSheetDetailedPDFServiceWrapper {
        public String data;
        public Boolean isSuccess;
        public Error error;
    }

    public class Error {
		public Integer errorCode;
		public String message;
		public String traceId;
	}

    public class FundFactSheetDetailedPDFServiceToastWrapper {
        @AuraEnabled public String data {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String fundFactSheetDetailedErrorMessage {get; set;}
    }

}