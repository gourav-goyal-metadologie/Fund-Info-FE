@isTest
private class FundFactSheetDetailedActionServiceTest {

    class FundFactSheetDetailedPDFServiceNegativeMock implements HttpCalloutMock{

        private String HEADER_AUTHORIZATION = 'Authorization';
        private String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
        private String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
        private String HEADER_TOKEN = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NzE2OTI5ODQsImV4cCI6MTY3MTY5NjU4NCwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCIsImNvcmUtbm90aWZpY2F0aW9uc2VydmljZS1hcGkiXSwiY2xpZW50X2lkIjoiZmVmdW5kaW5mby1hZHZpc2VyeS1iYWNrb2ZmaWNlaW50LXNqcHNmLXByZXByb2QiLCJzY29wZSI6WyJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXJlYWQiLCJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXdyaXRlIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcmVhZCIsImFkdmlzb3J5LWZlYXdyYXBwZXItYXBpLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktY29uc3VtZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktcHVibGlzaGVyLXJlYWQiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktc3Vic2NyaXB0aW9uaW5mbyIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBpLXN1YnNjcmlwdGlvbmluZm8tcmVhZCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBwdG9hcHAtY29ubmVjdCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtZW5kdXNlci1jb25uZWN0Il19.j65Ea5Cw21rksQ7ucNbeymgByYKHa22UKLZl64rz-6ezuqnCEVA6xnl_lKHjYrZHV3ZB3GzhQwXimrcq1aXiXfznXUHswMtes_PdLcXpc1ApXMeP_yHXGIHmAMNlBVwabGrGm7QLg2cP6iwZUoMGdn01P0rnbua542hK6LfVGrSnVnJSsJ6NS7wvI8w5x0RtBhGcQx7msJI3Monfr6_8Jku8a4Ah9O75DBBeEArh8_G5JdMOgxtmqzxdLrgqaNXc1B3ZaIC5TLLMRpq_Po7574nJHllXs7KL0H8HOMfDGEj47MGI15dFEA50c_wzccMLw6WZhqHO61nYeCkTSwOMPw';

        public HttpResponse respond(HttpRequest request) {

            HttpResponse response = new HttpResponse();
            if(request.getEndpoint().contains(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c)) {
                
                response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + HEADER_TOKEN);
                response.setHeader('Content-Type', 'application/json');
                response.setStatusCode(200);
                response.setBody('{"access_token":"eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NzE2MTUxMjQsImV4cCI6MTY3MTYxODcyNCwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCIsImNvcmUtbm90aWZpY2F0aW9uc2VydmljZS1hcGkiXSwiY2xpZW50X2lkIjoiZmVmdW5kaW5mby1hZHZpc2VyeS1iYWNrb2ZmaWNlaW50LXNqcHNmLXByZXByb2QiLCJzY29wZSI6WyJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXJlYWQiLCJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXdyaXRlIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcmVhZCIsImFkdmlzb3J5LWZlYXdyYXBwZXItYXBpLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktY29uc3VtZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktcHVibGlzaGVyLXJlYWQiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktc3Vic2NyaXB0aW9uaW5mbyIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBpLXN1YnNjcmlwdGlvbmluZm8tcmVhZCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBwdG9hcHAtY29ubmVjdCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtZW5kdXNlci1jb25uZWN0Il19.IBdp4cpvzKYYofMLDxikPXDD2vxNb1ckUUaR9DJPA9NHC6yj6CjLGwfzgvQH2WvdEA0fjRLq1xhYIOjMwYFJvDc0tF28GOWegi-PMrOJVrdoiLuAKQmDJ5_tmDmZQ4yqX7wnBpNQ6T1UUf0cbQyoPZPnsDwbb-d9NZyh39kj8QhYpw0P_s1VqIAZanssACYzWh9JncdcMCp9q7hMEyPIH0Y61RYx8Y3AIqeeDf2N1fUXwT2xzbC2OAnBtFd0WHFmzoDtEk_GIne-Z-pVYQMV4Gi1s9rslEJussOcbwrRx5xHR49z37g5qb-2Q1wNwE6LjK7OsbZWiUhzlUqLr9KGkw","expires_in":3600,"token_type":"Bearer"}');
                System.assertEquals('POST', request.getMethod());
            }
            else if(request.getEndpoint().contains(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c + Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c)) {

                response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + HEADER_TOKEN);
                response.setHeader('Content-Type', 'application/json');
                response.setStatusCode(200);
                response.setBody('{"data":false,"isSuccess":true}');
                System.assertEquals('POST', request.getMethod());
            }
            return response;
        }
    }
    
    @TestSetup
    static void setupData() {

        Fe_FundInfo__FE_EndPoint__mdt metadata = Fe_FundInfo__FE_EndPoint__mdt.getAll().values();
        Fe_FundInfo__Log__c log = new Fe_FundInfo__Log__c();
        log.Fe_FundInfo__APEX_Class__c = 'Test';
        insert log;

    }

    @isTest
    static void fetchCustomMetaDataTypeTest() {

        Test.startTest();
        Fe_FundInfo__FE_EndPoint__mdt metadata1 = FundFactSheetDetailedActionService.fetchCustomMetaDataType();
        Fe_FundInfo__FE_EndPoint__mdt metadata2 = [SELECT Id FROM Fe_FundInfo__FE_EndPoint__mdt];
        Test.stopTest();
        System.assertEquals(metadata1.Id, metadata2.Id);

    }

    @isTest
    static void fundFactSheetDetailedActionServicePositiveTest() {

        Fe_FundInfo__Log__c log = [SELECT Id FROM Fe_FundInfo__Log__c];
        Pagereference generateFundFactSheetDetailedPDFPage = Page.GenerateFundFactSheetDetailedPDF;
        Test.setCurrentPage(generateFundFactSheetDetailedPDFPage);
        ApexPages.currentPage().getParameters().put('data', log.Id);
        Test.setMock(HttpCalloutMock.class, new FundFactSheetDetailedActionServiceMock());
        Test.startTest();
        FundFactSheetDetailedActionService fundFactSheetDetailedActionService = new FundFactSheetDetailedActionService();
        Test.stopTest();
        System.assertEquals(true, log.Id!=null);

    }

    @isTest
    static void fundFactSheetDetailedActionServiceNegativeTest() {

        Fe_FundInfo__Log__c log = [SELECT Id FROM Fe_FundInfo__Log__c];
        Pagereference generateFundFactSheetDetailedPDFPage = Page.GenerateFundFactSheetDetailedPDF;
        Test.setCurrentPage(generateFundFactSheetDetailedPDFPage);
        ApexPages.currentPage().getParameters().put('data', log.Id);
        Test.setMock(HttpCalloutMock.class, new FundFactSheetDetailedPDFServiceNegativeMock());
        Test.startTest();
        FundFactSheetDetailedActionService fundFactSheetDetailedActionService = new FundFactSheetDetailedActionService();
        Test.stopTest();
        System.assertEquals(true, log.Id!=null);

    }

}