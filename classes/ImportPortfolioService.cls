global class ImportPortfolioService {
    /**
     *  @Custom Label
     *  Fetch Back_Office_Base_Url__c custom metadata type which will store the
     *  base url.
     */ 
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static String Subfix_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Portfolio_Import__c;
    public static final String HTTP_METHOD_Post = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';

    @AuraEnabled(cacheable=false)
    global static AutoLoginURLWithValidateResponseWrapper sendRequestForOperUrl(Id portfolioId) {
        try{
            FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
            FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(feFundAuthTokenResponse.access_token);
            AutoLoginURLWithValidateResponseWrapper autoLoginURLWithValidateResponseWrapperInst = new AutoLoginURLWithValidateResponseWrapper();
            if(feFundValidateLicenseWrapper.data == true) {
                ImportPortfolioServiceWrapper importPortfolioServiceWrapperInstance = sendPortfolioImportRequest(feFundAuthTokenResponse.access_token, portfolioId);
                if(String.isNotBlank(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.autoLoginURL) 
                    && importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings.isEmpty()){
                    autoLoginURLWithValidateResponseWrapperInst.autoLoginURL = importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.autoLoginURL;
                    autoLoginURLWithValidateResponseWrapperInst.isValidateSuccess = 'true';
                    autoLoginURLWithValidateResponseWrapperInst.warningDescription = '';
                }else{
                    autoLoginURLWithValidateResponseWrapperInst.autoLoginURL = importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.autoLoginURL;
                    String warningCode = '';
                    Boolean isDuplicate = false;
                    for(ImportPortfolioServiceWrapper.ImportWarnings importWarning : importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings) {
                        if(importWarning.warningItem == 'Holding.Duplicate') {
                            if(String.isNotBlank(importWarning.warningDescription)){
                                isDuplicate = true;
                            }
                        } 
                        else {
                            if(String.isNotBlank(importWarning.warningDescription)){
                                warningCode += importWarning.warningDescription.split('Holding.Code=')[1].split(' at holding item')[0] + ', ';
                            }
                        }
                    }
                    if(isDuplicate) {
                        warningCode = 'Duplicated holdings identified have been aggregated into a single holding.';
                    } else{
                        if(String.isNotBlank(warningCode)){
                            warningCode = warningCode.removeEnd(', ');
                        }
                        if(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings.size() > 1){
                            warningCode =  'Holding identifiers '+ warningCode + ' not recognised. These have been excluded from the portfolio.';
                        }
                        else {
                            warningCode =  'Holding identifier '+ warningCode + ' not recognised. This has been excluded from the portfolio.';
                        }
                    }
                    autoLoginURLWithValidateResponseWrapperInst.warningDescription = warningCode;
                    autoLoginURLWithValidateResponseWrapperInst.isValidateSuccess = 'true';
                }
            }else if (feFundValidateLicenseWrapper.data == false) {
                autoLoginURLWithValidateResponseWrapperInst.autoLoginURL = '';
                autoLoginURLWithValidateResponseWrapperInst.isValidateSuccess = 'false';
                autoLoginURLWithValidateResponseWrapperInst.warningDescription = '';
            }else {
                autoLoginURLWithValidateResponseWrapperInst.autoLoginURL = '';
                autoLoginURLWithValidateResponseWrapperInst.warningDescription = 'Technical error occurred';
                autoLoginURLWithValidateResponseWrapperInst.isValidateSuccess = 'false';
            }
            System.debug('autoLoginURLWithValidateResponseWrapperInst >> '+ autoLoginURLWithValidateResponseWrapperInst);
            return autoLoginURLWithValidateResponseWrapperInst;
        }
        catch(Exception error){
            LogService.createErrorLog('PortfolioImportService.apxc', NULL, error, NULL);
            return null;
        }
    }

    // Fetch custom metadata type.
    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT Id, Fe_FundInfo__Unauthorised_Message__c, 
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c,
                    Fe_FundInfo__Medium_Scan_PDF_Error_Message__c,
                    Fe_FundInfo__Success_Message_For_Medium_Scan__c 
                    FROM Fe_FundInfo__FE_EndPoint__mdt];
    }

    /**
     *  @return ImportPortfolioServiceWrapper
     *  This method is used for send Request to the auth token class.
     *  @param It will accept two parameters userEmail and Portfolio Id.
     */ 
    global static AnalyticsPortfolioIdWithValidateResponseWrapper sendRequest(Id portfolioId) {
        try{
            FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse = FeFundAuthToken.generateHeaderToken();
            FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper = FeFundValidateLicenseService.validateLicense(feFundAuthTokenResponse.access_token);
            AnalyticsPortfolioIdWithValidateResponseWrapper analyticsPortfolioIdWithValidateResponseWrapperInstance = new AnalyticsPortfolioIdWithValidateResponseWrapper();
            if(feFundValidateLicenseWrapper.data == true) {
                ImportPortfolioServiceWrapper importPortfolioServiceWrapperInstance = sendPortfolioImportRequest(feFundAuthTokenResponse.access_token, portfolioId);
                if(String.isNotBlank(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.autoLoginURL)
                    && importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings.isEmpty()) {
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isSuccess = 'true';
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.analyticsPortfolioID = String.valueOf(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.analyticsPortfolioID);
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isPortfolioHoldingExist = 'true';
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.warningDescription = '';
                    System.debug('analyticsPortfolioIdWithValidateResponseWrapperInstance \n\n' + analyticsPortfolioIdWithValidateResponseWrapperInstance);
                }else{
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.analyticsPortfolioID = String.valueOf(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.analyticsPortfolioID);
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.warningDescription = importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings[0].warningDescription;
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isPortfolioHoldingExist = 'true';
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isSuccess = 'false';
                }
            }
            else if (feFundValidateLicenseWrapper.data == false) {
                analyticsPortfolioIdWithValidateResponseWrapperInstance.isSuccess = 'false';
                analyticsPortfolioIdWithValidateResponseWrapperInstance.analyticsPortfolioID = '';
                analyticsPortfolioIdWithValidateResponseWrapperInstance.isPortfolioHoldingExist = 'true';
                System.debug('analyticsPortfolioIdWithValidateResponseWrapperInstance \n\n' + analyticsPortfolioIdWithValidateResponseWrapperInstance);
            }
            return analyticsPortfolioIdWithValidateResponseWrapperInstance;
        }
        catch(Exception error){
            System.debug('error in PortfolioImportService >> \n\n' + error.getStackTraceString()    + error.getMessage());
            LogService.createErrorLog('PortfolioImportService.apxc', NULL, error, NULL);
            return null;
        }
    }

    public static AnalyticsPortfolioIdWithValidateResponseWrapper sendRequest(FeFundAuthToken.FeFundAuthTokenResponseWrapper feFundAuthTokenResponse, FeFundValidateLicenseService.FeFundValidateLicenseWrapper feFundValidateLicenseWrapper, Id portfolioId) {
        AnalyticsPortfolioIdWithValidateResponseWrapper analyticsPortfolioIdWithValidateResponseWrapperInstance = new AnalyticsPortfolioIdWithValidateResponseWrapper();
        if(feFundValidateLicenseWrapper.data == True){
            ImportPortfolioServiceWrapper importPortfolioServiceWrapperInstance = sendPortfolioImportRequest(feFundAuthTokenResponse.access_token, portfolioId);
                if(String.isNotBlank(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.autoLoginURL)
                    && importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings.isEmpty()) {
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isSuccess = 'true';
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.analyticsPortfolioID = String.valueOf(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.analyticsPortfolioID);
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isPortfolioHoldingExist = 'true';
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.warningDescription = '';
                    System.debug('analyticsPortfolioIdWithValidateResponseWrapperInstance \n\n' + analyticsPortfolioIdWithValidateResponseWrapperInstance);
                }else{
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.analyticsPortfolioID = String.valueOf(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.analyticsPortfolioID);
                    String warningCode = '';
                    Boolean isDuplicate = false;
                    for(ImportPortfolioServiceWrapper.ImportWarnings importWarning : importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings) {
                        if(importWarning.warningItem == 'Holding.Duplicate') {
                            if(String.isNotBlank(importWarning.warningDescription)){
                                isDuplicate = true;
                            }
                        } 
                        else {
                            if(String.isNotBlank(importWarning.warningDescription)){
                                warningCode += importWarning.warningDescription.split('Holding.Code=')[1].split(' at holding item')[0] + ', ';
                            }
                        }
                    }
                    if(isDuplicate) {
                        warningCode = 'Duplicated holdings identified have been aggregated into a single holding.';
                    } else{
                        if(String.isNotBlank(warningCode)){
                            warningCode = warningCode.removeEnd(', ');
                        }
                        if(importPortfolioServiceWrapperInstance.data.importBasicPortfolioResult.importWarnings.size() > 1){
                            warningCode =  'Holding identifiers '+ warningCode + ' not recognised. These have been excluded from the portfolio.';
                        }
                        else {
                            warningCode =  'Holding identifier '+ warningCode + ' not recognised. This has been excluded from the portfolio.';
                        }
                    }
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.warningDescription = warningCode;
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isPortfolioHoldingExist = 'true';
                    analyticsPortfolioIdWithValidateResponseWrapperInstance.isSuccess = 'false';
                }
        }else if(feFundValidateLicenseWrapper.data == False){
            analyticsPortfolioIdWithValidateResponseWrapperInstance.isSuccess = 'false';
            analyticsPortfolioIdWithValidateResponseWrapperInstance.analyticsPortfolioID = '';
            analyticsPortfolioIdWithValidateResponseWrapperInstance.isPortfolioHoldingExist = 'true';
            System.debug('analyticsPortfolioIdWithValidateResponseWrapperInstance \n\n' + analyticsPortfolioIdWithValidateResponseWrapperInstance);
        }
        return analyticsPortfolioIdWithValidateResponseWrapperInstance;
    }

    /**
     *  @return ImportPortfolioServiceWrapper 
     *  This method is used for the send Http Request to the Portfolio short scan.
     *  @param It will accept Header Token as parameter.
     */ 
    public static ImportPortfolioServiceWrapper sendPortfolioImportRequest(String HEADER_TOKEN, Id portfolioId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Base_URL + Subfix_URL);
        request.setMethod(HTTP_METHOD_Post);
        request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + HEADER_TOKEN);
        request.setTimeout(120000);
        request.setHeader('Content-Type', 'application/json');

        ImportPortfolioServiceUtility.ImportPortfolioServiceUtilityWrapper importPortfolioServiceUtilityWrapper =  ImportPortfolioServiceUtility.getImportPortfolioServiceUtilityWrapper(portfolioId);

        request.setBody(portfolioImportRequestBody(importPortfolioServiceUtilityWrapper));

        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            System.debug('request body \n'+ response.getBody());
            System.debug('The status code returned : ' + response.getStatusCode());
            ImportPortfolioServiceWrapper importPortfolioServiceWrapperInstance = ImportPortfolioServiceWrapper.parse(response.getBody());
            System.debug('PortfolioImportxServiceWrapperInstance > > > \n ' + importPortfolioServiceWrapperInstance);   
            return importPortfolioServiceWrapperInstance;
        } else {
            System.debug('Error : ' + response.getBody());
            System.debug('Status Code : \n '+ response.getStatusCode());
            return null;
        }
    }

    /**
     *  @return String 
     *  This method is used for the generate request body for portfolio import.
     *  @param It will accept List of Portfolio__c.
     */
    private static String portfolioImportRequestBody(ImportPortfolioServiceUtility.ImportPortfolioServiceUtilityWrapper importPortfolioServiceUtilityWrapper) {
        DateTime myDateTime = System.now();
        String formattedStartDate = myDateTime.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss');
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('loginName', UserInfo.getUserEmail());
        gen.writeStringField('startDate',  String.isNotBlank(importPortfolioServiceUtilityWrapper.portfolioStartDate) 
                                    ? importPortfolioServiceUtilityWrapper.portfolioStartDate
                                    : formattedStartDate);
        gen.writeStringField('PortfolioNamePrefix', String.isNotBlank(Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0).Fe_FundInfo__Portfolio_Name_Prefix__c) ? Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0).Fe_FundInfo__Portfolio_Name_Prefix__c : '');
        gen.writeStringField('portfolioName', importPortfolioServiceUtilityWrapper.portfolioNameFieldValue);
        gen.writeFieldName('holdings');
        gen.writeStartArray();

        for (SObject portfolioHolding : importPortfolioServiceUtilityWrapper.portfolioHoldings) {    
            gen.writeStartObject();
            gen.writeStringField('instrumentType', Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0).Fe_FundInfo__Instrument_Type__c);
            gen.writeStringField('holdingIdentifier', String.isNotBlank((String)portfolioHolding.get(Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0).Fe_FundInfo__Holding_Identifier_Field__c)) ? (String)portfolioHolding.get(FE_Analytic_Mapping__mdt.getAll().values().get(0).Holding_Identifier_Field__c) : '');
            gen.writeNumberField('holdingAmount', (Decimal)portfolioHolding.get(Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0).Fe_FundInfo__Holding_Amount_Field__c) != null ? (Decimal)portfolioHolding.get(FE_Analytic_Mapping__mdt.getAll().values().get(0).Holding_Amount_Field__c) : 0);
            gen.writeEndObject();
        }

        gen.writeEndArray();

        gen.writeStringField('firstName', String.isNotBlank(importPortfolioServiceUtilityWrapper.clientFirstName) ? importPortfolioServiceUtilityWrapper.clientFirstName : '');
        gen.writeStringField('lastName', String.isNotBlank(importPortfolioServiceUtilityWrapper.clientLastName) ? importPortfolioServiceUtilityWrapper.clientLastName : '');
        gen.writeStringField('holdingValueType', Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0).Fe_FundInfo__Holding_Value_Type__c);
        gen.writeStringField('rebalanceType', Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0).Fe_FundInfo__ReBalance_Type__c); // 

        gen.writeEndObject();
        String requestBody = gen.getAsString();
        System.debug('request body >> '+ requestBody);
        return requestBody;
    }

    global class AnalyticsPortfolioIdWithValidateResponseWrapper{
        global String analyticsPortfolioID;
        global String isSuccess;
        global String isPortfolioHoldingExist;
        global String warningDescription;
    }

    global class AutoLoginURLWithValidateResponseWrapper{
        @AuraEnabled global String autoLoginURL {get; set;}
        @AuraEnabled global String isValidateSuccess {get; set;}
        @AuraEnabled global String warningDescription {get; set;}
    }
}