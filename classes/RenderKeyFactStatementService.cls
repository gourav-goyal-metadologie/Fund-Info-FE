public class RenderKeyFactStatementService {
    /**
     *	@Custom Metadata Type
     *	Fetch Back_Office_Base_Url__c custom metadata type which will store the
	 *	base url.
     */ 
    public static String Base_URL = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Back_Office_Base_Url__c;
    public static String Post_URL = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).KeyFactStatement_Url__c;
    public static final String HTTP_METHOD_GET = 'GET';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    public static final String USEREMAIL = 'userEmail=';
    public static final String CODE = 'code=';
    public static final String INSTRTYPE = 'instrType=';
    public static Boolean isStatus404 = false;
    public static Boolean isStatus500 = false;

    public static RenderKeyFactStatementServiceToastWrapper sendRequest(Id PortfolioHoldingId) {
        try {            
            KeyFactStatementUtility.KeyFactStatementUtilityWrapper keyFactStatementUtilityWrapper = KeyFactStatementUtility.getKeyFactStatementUtilityWrapper(PortfolioHoldingId);

            if(keyFactStatementUtilityWrapper.code == '10FX' || keyFactStatementUtilityWrapper.code == '002F') {
                return checkCodeValueForDoesNotHaveKFS();
            }else if(keyFactStatementUtilityWrapper.code == '0000' || keyFactStatementUtilityWrapper.code == 'AAAA') {
                return checkCodeValueForInvalidCode();
            }else{
                return genrateFeFundAuthToken(keyFactStatementUtilityWrapper);
            }
        } catch (Exception error) {
            LogService.createErrorLog('RenderKeyFactStatementService.apxc', NULL, error, NULL);
            return null;
        }
    }

    public static RenderKeyFactStatementServiceToastWrapper checkCodeValueForDoesNotHaveKFS() {
        RenderKeyFactStatementServiceToastWrapper renderKeyFactStatementServiceToastWrapperInst = new RenderKeyFactStatementServiceToastWrapper();
        renderKeyFactStatementServiceToastWrapperInst.data = '';
        renderKeyFactStatementServiceToastWrapperInst.isSuccess = false;
        renderKeyFactStatementServiceToastWrapperInst.keyfactStatementErrorMessage = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Does_Not_Have_KFS_Code_Error_Message__c;
        renderKeyFactStatementServiceToastWrapperInst.isSuccessForValidate = false;
        return renderKeyFactStatementServiceToastWrapperInst;
    }

    public static RenderKeyFactStatementServiceToastWrapper checkCodeValueForInvalidCode() {
        RenderKeyFactStatementServiceToastWrapper renderKeyFactStatementServiceToastWrapperInst = new RenderKeyFactStatementServiceToastWrapper();
        renderKeyFactStatementServiceToastWrapperInst.data = '';
        renderKeyFactStatementServiceToastWrapperInst.isSuccess = false;
        renderKeyFactStatementServiceToastWrapperInst.keyfactStatementErrorMessage = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).KFS_Invalid_Code_Error_Message__c;
        renderKeyFactStatementServiceToastWrapperInst.isSuccessForValidate = false;
        return renderKeyFactStatementServiceToastWrapperInst;
    }

    private static RenderKeyFactStatementServiceToastWrapper genrateFeFundAuthToken(KeyFactStatementUtility.KeyFactStatementUtilityWrapper keyFactStatementUtilityWrapper) {
        FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
        return vaidate(keyFactStatementUtilityWrapper, feFundAuthTokenResponse.access_token);
    }

    private static RenderKeyFactStatementServiceToastWrapper vaidate(KeyFactStatementUtility.KeyFactStatementUtilityWrapper keyFactStatementUtilityWrapper, String headerToken) {
        FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(headerToken);
        RenderKeyFactStatementServiceToastWrapper renderKeyFactStatementServiceToastWrapperInst = new RenderKeyFactStatementServiceToastWrapper();
        
        if(feFundValidateLicenseWrapper.data == true) {
            RenderKeyFactStatementServiceWrapper RenderKeyFactStatementServiceWrapperInst = createHttpRequest(keyFactStatementUtilityWrapper, headerToken);
            if(RenderKeyFactStatementServiceWrapperInst.isSuccess == true){
                renderKeyFactStatementServiceToastWrapperInst.data = RenderKeyFactStatementServiceWrapperInst.data;
                renderKeyFactStatementServiceToastWrapperInst.isSuccess = RenderKeyFactStatementServiceWrapperInst.isSuccess;
                renderKeyFactStatementServiceToastWrapperInst.isSuccessForValidate = true;
            }else if(RenderKeyFactStatementServiceWrapperInst.isSuccess == false) {
                renderKeyFactStatementServiceToastWrapperInst.data = 'error';
                renderKeyFactStatementServiceToastWrapperInst.isSuccessForValidate = true;
                renderKeyFactStatementServiceToastWrapperInst.isSuccess = RenderKeyFactStatementServiceWrapperInst.isSuccess;
                if(isStatus404){
                    renderKeyFactStatementServiceToastWrapperInst.keyfactStatementErrorMessage = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Does_Not_Have_KFS_Code_Error_Message__c;
                }else if(isStatus500){
                    renderKeyFactStatementServiceToastWrapperInst.keyfactStatementErrorMessage = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).KFS_Invalid_Code_Error_Message__c;
                }else{
                    renderKeyFactStatementServiceToastWrapperInst.keyfactStatementErrorMessage = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).KFS_Invalid_Code_Error_Message__c;
                }
            }
        }else {
            renderKeyFactStatementServiceToastWrapperInst.data = 'vlalidation';
            renderKeyFactStatementServiceToastWrapperInst.isSuccess = false;
            renderKeyFactStatementServiceToastWrapperInst.keyfactStatementErrorMessage = fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Unauthorised_Message__c;
            renderKeyFactStatementServiceToastWrapperInst.isSuccessForValidate = false;
        }
        return renderKeyFactStatementServiceToastWrapperInst;
    }

    private static RenderKeyFactStatementServiceWrapper createHttpRequest(KeyFactStatementUtility.KeyFactStatementUtilityWrapper keyFactStatementUtilityWrapper, String headerToken) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('prepateEndPoint(portfolioHolding) \n\n'+prepateEndPoint(keyFactStatementUtilityWrapper));
        request.setEndpoint(prepateEndPoint(keyFactStatementUtilityWrapper));
        request.setMethod(HTTP_METHOD_GET);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + headerToken);
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        RenderKeyFactStatementServiceWrapper renderKeyFactStatementServiceWrapperreturn = new RenderKeyFactStatementServiceWrapper();

        System.debug('Key Fact Statement : ' + response.getBody());
        System.debug('Status Code : \n '+ response.getStatusCode());
        if(response.getStatusCode() == 200) {
            return parse(response.getBody());
        }else if(response.getStatusCode() == 404) {
            isStatus404 = TRUE;
            return parse(response.getBody());
        }else if(response.getStatusCode() == 500){
            isStatus500 = TRUE;
            return parse(response.getBody());
        }else{
            return parse(response.getBody());
        }
    }

    private static RenderKeyFactStatementServiceWrapper parse(String jsonBody) {
        return (RenderKeyFactStatementServiceWrapper) System.JSON.deserialize(jsonBody, RenderKeyFactStatementServiceWrapper.class);
    }

    private static String prepateEndPoint(KeyFactStatementUtility.KeyFactStatementUtilityWrapper keyFactStatementUtilityWrapper) {
        return Base_URL + Post_URL + '?' +INSTRTYPE + keyFactStatementUtilityWrapper.instrType + '&' + CODE + keyFactStatementUtilityWrapper.code + '&' + USEREMAIL+ UserInfo.getUserEmail();
    }

    public class RenderKeyFactStatementServiceWrapper {
        @AuraEnabled public Boolean isSuccess {get; set;}
        @AuraEnabled public Error error {get; set;}
        @AuraEnabled public String data {get; set;}
    }

    public class Error {
		@AuraEnabled public Integer errorCode {get; set;}
        @AuraEnabled public String message {get; set;}
        @AuraEnabled public String traceId {get; set;}
	}

    public class RenderKeyFactStatementServiceToastWrapper {
        @AuraEnabled public String data {get; set;}	
	    @AuraEnabled public boolean isSuccess {get; set;}
	    @AuraEnabled public boolean isSuccessForValidate {get; set;}
        @AuraEnabled public String keyfactStatementErrorMessage {get; set;}
    }
}