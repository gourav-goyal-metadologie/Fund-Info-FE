@isTest
private class RndrProviderFactSheetPDFActionSrcTest {

    private class rndrProviderFactSheetPDFSrcNegativeMock implements HttpCalloutMock{

        String HEADER_CONTENT_TYPE = 'Content-Type';
        String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
        String HEADER_AUTHORIZATION = 'Authorization';
        String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
        String headerToken = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2Njg1OTkyNDQsImV4cCI6MTY2ODYwMjg0NCwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCIsImNvcmUtbm90aWZpY2F0aW9uc2VydmljZS1hcGkiXSwiY2xpZW50X2lkIjoiZmVmdW5kaW5mby1hZHZpc2VyeS1iYWNrb2ZmaWNlaW50LXNqcHNmLXByZXByb2QiLCJzY29wZSI6WyJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXJlYWQiLCJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXdyaXRlIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcmVhZCIsImFkdmlzb3J5LWZlYXdyYXBwZXItYXBpLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktY29uc3VtZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktcHVibGlzaGVyLXJlYWQiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktc3Vic2NyaXB0aW9uaW5mbyIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBpLXN1YnNjcmlwdGlvbmluZm8tcmVhZCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBwdG9hcHAtY29ubmVjdCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtZW5kdXNlci1jb25uZWN0Il19.P797ZqEwRrpjCViKRDcINZNa2nGEZ0Bf3mTIiu5DE6w9QEp68ZeJ3AgXNgi7t1yO08aj7RiKf1yPdk_cwrbTfIehcObZmiyEwycxbdjh20K4Lxeaa-K3u-jqGbXRRNl1O2lkho8ww39aVcvtAln4349NyBwpMZh77huRR1YzUq1oRfv8QfkfRMkA6QS-ZxSuqzNwFYqrdTDp1UdcM9V-yEbyTHagv3-amvzPnWVgoAuCGMmHmIfQP1PXOZoXvUFy8viwfzH0TWd5y6zdvRo0waqEAP9GP9sf3UXDC9PIteMX0sxLYOPutLV8MmZ6Yxn3_08PMUfrHZZOhvq7Y4wSog';
        String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';

        public HttpResponse Respond(HttpRequest request) {

            HttpResponse response = new HttpResponse();
            if(request.getEndpoint().contains(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c)) {
                response.setStatusCode(200);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_MULTIPART_FORMDATA);
                response.setBody('{"access_token":"eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2Njg1OTkyNDQsImV4cCI6MTY2ODYwMjg0NCwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCIsImNvcmUtbm90aWZpY2F0aW9uc2VydmljZS1hcGkiXSwiY2xpZW50X2lkIjoiZmVmdW5kaW5mby1hZHZpc2VyeS1iYWNrb2ZmaWNlaW50LXNqcHNmLXByZXByb2QiLCJzY29wZSI6WyJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXJlYWQiLCJhZHZpc29yeS1iYWNrb2ZmaWNlaW50ZWdyYXRpb24tYXBpLXdyaXRlIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcmVhZCIsImFkdmlzb3J5LWZlYXdyYXBwZXItYXBpLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktY29uc3VtZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktcHVibGlzaGVyLXJlYWQiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoZXItd3JpdGUiLCJub3RpZmljYXRpb25zZXJ2aWNlLWFwaS1wdWJsaXNoLXdyaXRlIiwibm90aWZpY2F0aW9uc2VydmljZS1hcGktc3Vic2NyaXB0aW9uaW5mbyIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBpLXN1YnNjcmlwdGlvbmluZm8tcmVhZCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtYXBwdG9hcHAtY29ubmVjdCIsIm5vdGlmaWNhdGlvbnNlcnZpY2UtZW5kdXNlci1jb25uZWN0Il19.P797ZqEwRrpjCViKRDcINZNa2nGEZ0Bf3mTIiu5DE6w9QEp68ZeJ3AgXNgi7t1yO08aj7RiKf1yPdk_cwrbTfIehcObZmiyEwycxbdjh20K4Lxeaa-K3u-jqGbXRRNl1O2lkho8ww39aVcvtAln4349NyBwpMZh77huRR1YzUq1oRfv8QfkfRMkA6QS-ZxSuqzNwFYqrdTDp1UdcM9V-yEbyTHagv3-amvzPnWVgoAuCGMmHmIfQP1PXOZoXvUFy8viwfzH0TWd5y6zdvRo0waqEAP9GP9sf3UXDC9PIteMX0sxLYOPutLV8MmZ6Yxn3_08PMUfrHZZOhvq7Y4wSog","expires_in":3600,"token_type":"Bearer"}');
            }
            if(request.getEndpoint() == Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c + Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c) {
                response.setStatusCode(200);
                response.setHeader(HEADER_AUTHORIZATION, (HEADER_BEARER_AUTHORIZATION + headerToken));
                response.setHeader('Content-Type', 'application/json');
                response.setBody('{"userEmail" : "ahsan.hassan@fefundinfo.com", "data" : true}');
            }
            else if(request.getEndpoint() == Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c + Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__ProviderFactSheet_Url__c) {
                response.setStatusCode(500);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setHeader(HEADER_AUTHORIZATION, (HEADER_BEARER_AUTHORIZATION + headerToken));
                String json = '{"userEmail" : "ahsan.hassan@fefundinfo.com", "code" : "GBP", "instrType" : "C", "isSuccess" : true}';
                response.setBody(json);
            }
            return response;
        }
    }
    
    @TestSetup
    static void setupData() {
        Fe_FundInfo__Log__c log = new Fe_FundInfo__Log__c();
		log.Fe_FundInfo__APEX_Class__c = 'Test';
		insert log;
    }

    @isTest
    static void renderProviderFactSheetPDFActionServiceTest() {
        Fe_FundInfo__Log__c log = [SELECT Id FROM Fe_FundInfo__Log__c];

        Test.setMock(HttpCalloutMock.class, new RndrProviderFactSheetPDFActionSrcMock());

        Test.startTest();

        Test.setCurrentPage(Page.GenerateProviderFactSheetPDF);
        ApexPages.currentPage().getParameters().put('data', log.Id);
        RenderProviderFactSheetPDFActionService renderProviderFactSheetPDFActionService = new RenderProviderFactSheetPDFActionService();
        
        Test.stopTest();
        System.assert(RenderProviderFactSheetPDFActionService.base64Data != null);
    }

    @isTest
    static void rndrProviderFactSheetPDFServiceNegativeTest() {
        Fe_FundInfo__Log__c log = [SELECT Id FROM Fe_FundInfo__Log__c];

        Test.setMock(HttpCalloutMock.class, new rndrProviderFactSheetPDFSrcNegativeMock());
        
        Test.startTest();
        Test.setCurrentPage(Page.GenerateProviderFactSheetPDF);
        ApexPages.currentPage().getParameters().put('data', log.Id);

        RenderProviderFactSheetPDFActionService renderProviderFactSheetPDFActionService = new RenderProviderFactSheetPDFActionService();
        
        Test.stopTest();
        System.assert(RenderProviderFactSheetPDFActionService.base64Data == null);
    }

    @isTest
    static void fetchCustomMetaDataTypeTest() {
        Test.startTest();
        Fe_FundInfo__FE_EndPoint__mdt endpointMetadata = RenderProviderFactSheetPDFActionService.fetchCustomMetaDataType();
        Test.stopTest();
        System.assert(endpointMetadata != null);
    }
}