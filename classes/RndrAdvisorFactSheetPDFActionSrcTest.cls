@isTest
private class RndrAdvisorFactSheetPDFActionSrcTest {
    @TestSetup
    static void setupData(){
        Fe_FundInfo__Log__c log = new Fe_FundInfo__Log__c();
		log.Fe_FundInfo__APEX_Class__c = 'Test';
		insert log;
    }

    @isTest
    static void renderAdvisorFactSheetPDFActionServiceTest() {
        Fe_FundInfo__Log__c log = [SELECT Id FROM Fe_FundInfo__Log__c];
       
        Test.setMock(HttpCalloutMock.class, new RndrAdvisorFactSheetPDFActionSrcMock());
       
        Test.startTest();

        Test.setCurrentPage(Page.GenerateAdvisorFactSheetPDF);
        
        ApexPages.currentPage().getParameters().put('data', log.Id);
        RenderAdvisorFactSheetPDFActionService renderAdvisorFactSheetPDFActionService = new RenderAdvisorFactSheetPDFActionService();
        
        Test.stopTest();
    }

    @isTest 
    static void fetchCustomMetaDataTypeTest() {

        Test.startTest();

        RenderAdvisorFactSheetPDFActionService.fetchCustomMetaDataType();
        
        Test.stopTest();
    }

    private class ValidateNagtiveMock implements HttpCalloutMock{
        public String HEADER_CONTENT_TYPE = 'Content-Type';
        public String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
        public String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
        public String HEADER_AUTHORIZATION = 'Authorization';
        public String HEADER_BEARER_AUTHORIZATION = 'Bearer';
        public String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw';
    
        String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
        String Post_Fix_Url = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c;
        String portId = '431517035';
        String subfixUrlMedium = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Medium_Scan_Url__c + portId;
        String Base_URLMedium = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    
        public HTTPResponse respond(HTTPRequest request) {
    
            HTTPResponse response = new HTTPResponse();
    
            if(request.getEndpoint().contains(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c)){
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_MULTIPART_FORMDATA);
                response.setStatusCode(200);
                response.setBody('{"access_token":"eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw","expires_in":3600,"token_type":"Bearer"}'); 
                System.assertEquals(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c, request.getEndpoint());
                System.assertEquals('POST', request.getMethod());    
            }
            
            if(request.getEndpoint().contains(Base_URL+Post_Fix_Url)) {
                response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + token);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setStatusCode(200);
                String json = '{"data": false, "isSuccess": true}';
                response.setBody(json);
                System.assertEquals('POST', request.getMethod());
            }
    
            return response;
        } 
    }

    @isTest
    static void validateNagtiveMockTest() {

        Fe_FundInfo__Log__c log = [SELECT Id FROM Fe_FundInfo__Log__c];
       
        Test.setMock(HttpCalloutMock.class, new ValidateNagtiveMock());
       
        Test.startTest();

        Test.setCurrentPage(Page.GenerateAdvisorFactSheetPDF);
        
        ApexPages.currentPage().getParameters().put('data', log.Id);
        RenderAdvisorFactSheetPDFActionService renderAdvisorFactSheetPDFActionService = new RenderAdvisorFactSheetPDFActionService();
        
        Test.stopTest();
    }

    private class AdvisorFactSheetNagtiveMock implements HttpCalloutMock{
        public String HEADER_CONTENT_TYPE = 'Content-Type';
        public String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
        public String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
        public String HEADER_AUTHORIZATION = 'Authorization';
        public String HEADER_BEARER_AUTHORIZATION = 'Bearer';
        public String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw';
    
        String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
        String Post_Fix_Url = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c;
        String portId = '431517035';
        String subfixUrlMedium = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Medium_Scan_Url__c + portId;
        String Base_URLMedium = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    
        public HTTPResponse respond(HTTPRequest request) {
    
            HTTPResponse response = new HTTPResponse();
    
            if(request.getEndpoint().contains(FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c)){
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_MULTIPART_FORMDATA);
                response.setStatusCode(200);
                response.setBody('{"access_token":"eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw","expires_in":3600,"token_type":"Bearer"}'); 
                System.assertEquals(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c, request.getEndpoint());
                System.assertEquals('POST', request.getMethod());    
            }
            
            if(request.getEndpoint().contains(Base_URL+Post_Fix_Url)) {
                response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + token);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setStatusCode(200);
                String json = '{"data": true, "isSuccess": true}';
                response.setBody(json);
                System.assertEquals('POST', request.getMethod());
            }

            if(request.getEndpoint().contains(Base_URL+Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__AdvisorFactSheet_Url__c)) {

                response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + token);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setStatusCode(500);
                String json=		'{'+
                '    "isSuccess": false,'+
                '    "error": {'+
                '        "errorCode": 500,'+
                '        "message": "test",'+
                '        "traceId": "00-d50062314278df7835b96862606bd94a-7fbbbd2e0ebc5fb3-00"'+
                '    }'+
                '}';
                response.setBody(json);
                System.assertEquals('POST', request.getMethod());
            }
    
            return response;
        } 
    }

    @isTest
    static void AdvisorFactSheeetNagtiveMockTest() {

        Fe_FundInfo__Log__c log = [SELECT Id FROM Fe_FundInfo__Log__c];
       
        Test.setMock(HttpCalloutMock.class, new AdvisorFactSheetNagtiveMock());

        AdviserFactSheetUtility.AdviserFactSheetUtilityWrapper adviserFactSheetUtility = AdviserFactSheetUtility.getAdviserFactSheetUtilityWrapper(log.Id);
       
        Test.startTest();

        RenderAdvisorFactSheetPDFService.genrateFeFundAuthToken(adviserFactSheetUtility);
        
        Test.stopTest();
    }
}