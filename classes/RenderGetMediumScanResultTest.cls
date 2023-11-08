@isTest
private class RenderGetMediumScanResultTest {

    @isTest
    static void testData() {
        Test.setMock(HttpCalloutMock.class, new RenderGetMediumScanResultMock());

        Test.startTest();

        RenderGetMediumScanResult.sendRequest('7875a9ce-47d8-4171-a778-3c48735c7716');
        
        Test.stopTest();
    }

    class ValidateNagtiveMock implements HttpCalloutMock{
        public String HEADER_CONTENT_TYPE = 'Content-Type';
        public String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
        public String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
        public String HEADER_AUTHORIZATION = 'Authorization';
        public String HEADER_BEARER_AUTHORIZATION = 'Bearer';
        public String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw';
    
        String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
        String Post_Fix_Url = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c;
    
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

    
        Test.setMock(HttpCalloutMock.class, new ValidateNagtiveMock());
    
        Test.startTest();
    
        RenderGetMediumScanResult.sendRequest('7875a9ce-47d8-4171-a778-3c48735c7716');

        Test.stopTest();

    }

    class NegativeMediumScanResult implements HttpCalloutMock{
        public String HEADER_CONTENT_TYPE = 'Content-Type';
        public String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
        public String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
        public String HEADER_AUTHORIZATION = 'Authorization';
        public String HEADER_BEARER_AUTHORIZATION = 'Bearer';
        public String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw';
    
        String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
        String Post_Fix_Url = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c;
        String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__MediumScanResult_Url__c;
    
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
                String json = '{"data": true, "isSuccess": true}';
                response.setBody(json);
                System.assertEquals('POST', request.getMethod());
            }

            if(request.getEndpoint().contains(Base_URL + Post_URL)){
                response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + token);
                response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
                response.setStatusCode(500);
                String json=		'{'+
                '    "isSuccess": false,'+
                '    "error": {'+
                '        "errorCode": 500,'+
                '        "message": "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><soap:Fault><faultcode>soap:Client</faultcode><faultstring>System.Web.Services.Protocols.SoapException: Server was unable to read request. ---&gt; System.InvalidOperationException: There is an error in XML document (22, 50). ---&gt; System.InvalidOperationException: Instance validation error: '+'test' +'is not a valid value for InstrumentType.\r\n   at Microsoft.Xml.Serialization.GeneratedAssembly.XmlSerializationReader1.Read3_InstrumentType(String s)\r\n   at Microsoft.Xml.Serialization.GeneratedAssembly.XmlSerializationReader1.Read27_BasicHolding(Boolean isNullable, Boolean checkType)\r\n   at Microsoft.Xml.Serialization.GeneratedAssembly.XmlSerializationReader1.Read28_BasicPortfolio(Boolean isNullable, Boolean checkType)\r\n   at Microsoft.Xml.Serialization.GeneratedAssembly.XmlSerializationReader1.Read40_ImportBasicPortfolio()\r\n   at System.Xml.Serialization.XmlSerializer.Deserialize(XmlReader xmlReader, String encodingStyle, XmlDeserializationEvents events)\r\n   --- End of inner exception stack trace ---\r\n   at System.Xml.Serialization.XmlSerializer.Deserialize(XmlReader xmlReader, String encodingStyle, XmlDeserializationEvents events)\r\n   at System.Web.Services.Protocols.SoapServerProtocol.ReadParameters()\r\n   --- End of inner exception stack trace ---\r\n   at System.Web.Services.Protocols.SoapServerProtocol.ReadParameters()\r\n   at System.Web.Services.Protocols.WebServiceHandler.CoreProcessRequest()</faultstring><detail /></soap:Fault></soap:Body></soap:Envelope>",'+
                '        "traceId": "00-804b39d989b32d45b09b26af432f7033-8421a7638cc1e341-00"'+
                '    }'+
                '}';
                response.setBody(json);
                System.assertEquals('GET', request.getMethod());
            }
    
            return response;
        }
    }

    @isTest
    static void negativeMediumScanResultTest() {

    
        Test.setMock(HttpCalloutMock.class, new NegativeMediumScanResult());
    
        Test.startTest();
    
        RenderGetMediumScanResult.sendRequest('7875a9ce-47d8-4171-a778-3c48735c7716');

        Test.stopTest();

    }


    @isTest
    static void renderAdvisorFactSheetPDFActionServiceTest() {
       
        Test.setMock(HttpCalloutMock.class, new RenderGetMediumScanResultMock());
       
        Test.startTest();

        Test.setCurrentPage(Page.GenerateMediumScanResultPdf);
        
        ApexPages.currentPage().getParameters().put('data', '7875a9ce-47d8-4171-a778-3c48735c7716');
        GenerateMediumScanResultPdfController renderAdvisorFactSheetPDFActionService = new GenerateMediumScanResultPdfController();
        
        Test.stopTest();
    }

    @isTest
    static void fetchCustomMetaDataTypeTest() {
        Test.startTest();

        GenerateMediumScanResultPdfController.fetchCustomMetaDataType();

        Test.stopTest();
    }

    @isTest
    static void portfolioCompletedNotificationTest() {
        Fe_FundInfo__Log__c log = new Fe_FundInfo__Log__c();
        log.Fe_FundInfo__APEX_Class__c = 'John Doe';
        insert log;

        Test.startTest();

        GenerateMediumScanResultPdfController.portfolioCompletedNotification('test', log.Id, true, true);
        
        Test.stopTest();
    }


    @isTest
    static void getMediumScanRequestIdsControllerTest() {
        Test.startTest();
        GetMediumScanRequestIdsController getMediumScanRequestIdsController = new GetMediumScanRequestIdsController();
        Test.stopTest();
    }

}