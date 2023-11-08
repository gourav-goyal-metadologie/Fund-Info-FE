public class GetMediumAsyncCall {
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Medium_Async_Url__c;
    public static final String HTTP_METHOD_POST = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String HEADER_CONTENT_TYPE =  'Content-Type'; 
    public static final String HEADER_APPLICATION_JSON = 'application/json';

    // method is used in lwc call.
    @AuraEnabled
    public static GetMediumAsyncCallWrapper getNotificationRequestId(Id portfolioId) {
        try {
            return genrateFeFundAuthToken(portfolioId);
        } catch (Exception error) {
            LogService.createErrorLog('GetMediumAsyncCall.apxc', NULL, error, NULL);
            return Null;
        }
    }

    public static GetMediumAsyncCallWrapper genrateFeFundAuthToken(Id portfolioId) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return validate(feFundAuthTokenResponse, portfolioId);
    }

    public static GetMediumAsyncCallWrapper validate(FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse, Id portfolioId) {
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(feFundAuthTokenResponse.access_token);
        System.debug('feFundValidateLicenseWrapper >> '+ feFundValidateLicenseWrapper);
        MediumAsyncUtility.MediumAsyncUtilityWrapper mediumAsyncUtilityWrapper  = MediumAsyncUtility.getMediumAsyncUtilityWrapper(portfolioId);
        GetMediumAsyncCallWrapper getMediumAsyncCallWrapper = new GetMediumAsyncCallWrapper();
        if(feFundValidateLicenseWrapper.isSuccess == true) {
            getMediumAsyncCallWrapper = importPortfolio(feFundAuthTokenResponse, feFundValidateLicenseWrapper, portfolioId, mediumAsyncUtilityWrapper.portfolioNameFieldValue);
        }else if(feFundValidateLicenseWrapper.isSuccess == false) 
        {
            getMediumAsyncCallWrapper.requestIdData = 'error for validation';
            getMediumAsyncCallWrapper.isSuccess = False;
            getMediumAsyncCallWrapper.isSuccessForValidate = False;
            getMediumAsyncCallWrapper.warningDescription = '';
            getMediumAsyncCallWrapper.portfolioName = mediumAsyncUtilityWrapper.portfolioNameFieldValue;
        }
        return getMediumAsyncCallWrapper;
    }

    private static getMediumAsyncCallWrapper importPortfolio(FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse, FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper, Id portfolioId, String portfolioName) {
        ImportPortfolioService.AnalyticsPortfolioIdWithValidateResponseWrapper analyticsPortIdWithValiRespWrapInst = ImportPortfolioService.sendRequest(feFundAuthTokenResponse, feFundValidateLicenseWrapper, portfolioId);
        System.debug('analyticsPortIdWithValiRespWrapInst >> '+ analyticsPortIdWithValiRespWrapInst);
        GetMediumAsyncCallWrapper getMediumAsyncCallWrapper = new GetMediumAsyncCallWrapper();
        
        if(analyticsPortIdWithValiRespWrapInst.analyticsPortfolioID != ''
                && analyticsPortIdWithValiRespWrapInst.warningDescription != ''
                && analyticsPortIdWithValiRespWrapInst.isPortfolioHoldingExist == 'true'
                && analyticsPortIdWithValiRespWrapInst.isSuccess == 'false') 
        {
            getMediumAsyncCallWrapper.warningDescription = analyticsPortIdWithValiRespWrapInst.warningDescription;
            getMediumAsyncCallWrapper.isSuccessForValidate = True;
            String requestId = createHttpRequest(feFundAuthTokenResponse.access_token, analyticsPortIdWithValiRespWrapInst.analyticsPortfolioID);
            getMediumAsyncCallWrapper.requestIdData = String.isNotBlank(requestId) ? requestId : '';
            getMediumAsyncCallWrapper.isSuccess = String.isNotBlank(requestId) ? True : False;
            getMediumAsyncCallWrapper.portfolioName = portfolioName;
            System.debug('inside export error warning >> '+ getMediumAsyncCallWrapper);
            return getMediumAsyncCallWrapper;
        } else if(analyticsPortIdWithValiRespWrapInst.isSuccess == 'false') {
            System.debug('inside false is Success');
            getMediumAsyncCallWrapper.isSuccessForValidate = False;
            getMediumAsyncCallWrapper.requestIdData = 'error for validation';
            getMediumAsyncCallWrapper.warningDescription = '';
            getMediumAsyncCallWrapper.isSuccess = False;
            getMediumAsyncCallWrapper.portfolioName = portfolioName;
            System.debug('getMediumAsyncCallWrapper .. > '+ getMediumAsyncCallWrapper);
            return getMediumAsyncCallWrapper;
        } else if(String.isNotBlank(analyticsPortIdWithValiRespWrapInst.analyticsPortfolioID) 
                && analyticsPortIdWithValiRespWrapInst.isSuccess == 'true' 
                && analyticsPortIdWithValiRespWrapInst.warningDescription == ''
                && analyticsPortIdWithValiRespWrapInst.isPortfolioHoldingExist == 'true')
        {
           String requestId = createHttpRequest(feFundAuthTokenResponse.access_token, analyticsPortIdWithValiRespWrapInst.analyticsPortfolioID);
           getMediumAsyncCallWrapper.isSuccessForValidate = True;
           getMediumAsyncCallWrapper.isSuccess = String.isNotBlank(requestId) ? True : False;
           getMediumAsyncCallWrapper.requestIdData = String.isNotBlank(requestId) ? requestId : '';
           getMediumAsyncCallWrapper.warningDescription = '';
           getMediumAsyncCallWrapper.portfolioName = portfolioName;
           return getMediumAsyncCallWrapper;
        }
        return Null;
    }

    private static String createHttpRequest(String headerToken, String analyticsPortfolioID) {
        String reponseRequestId;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('url medium async call >> '+ Base_URL + Post_URL + analyticsPortfolioID);
        request.setEndpoint(Base_URL + Post_URL + analyticsPortfolioID);
        request.setMethod(HTTP_METHOD_POST);
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_APPLICATION_JSON);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setBody(generateBody());
        request.setTimeout(120000);
        HttpResponse response = http.send(request);

        System.debug('reponse \n\n' + response.getStatusCode());
        System.debug(response.getBody());

        if(response.getStatusCode() == 202) {
            reponseRequestId = response.getBody();
        }else{
            reponseRequestId = response.getBody();
        }
        return reponseRequestId;
    }

    private static String generateBody() {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('userEmail', UserInfo.getUserEmail());
        gen.writeEndObject();
        String requestBody = gen.getAsString();
        return requestBody;
    }

    @AuraEnabled
    public static string getPortfolioName(Id portfolioId){
        try {
            MediumAsyncUtility.MediumAsyncUtilityWrapper mediumAsyncUtilityWrapper  = MediumAsyncUtility.getMediumAsyncUtilityWrapper(portfolioId);
            return mediumAsyncUtilityWrapper.portfolioNameFieldValue;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class GetMediumAsyncCallWrapper {
        @AuraEnabled public String requestIdData {get; set;}
        @AuraEnabled public Boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String warningDescription {get; set;}
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public String portfolioName {get; set;}
    }

}