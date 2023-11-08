@isTest
global class GetTokenForNotificationServiceMock implements HttpCalloutMock {
    public static final String HEADER_CONTENT_TYPE = 'Content-Type';
    public static final String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
    public static final String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer';
    public static final String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw';

    String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    String Post_Fix_Url = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c;
    String Post_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__GetTokenForNotification_Url__c;

    global HTTPResponse respond(HTTPRequest request) {

        HTTPResponse response = new HTTPResponse();

        if(request.getEndpoint().contains(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c)){
            response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
            response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_MULTIPART_FORMDATA);
            response.setStatusCode(200);
            response.setBody('{"access_token":"eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw","expires_in":3600,"token_type":"Bearer"}'); 
            System.assertEquals(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c, request.getEndpoint());
            System.assertEquals('POST', request.getMethod());    
        }
        
        if(request.getEndpoint().contains(Base_URL + Post_Fix_Url)) {
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
            response.setStatusCode(200);
            String json=		'{'+
            '    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyNGRkY2ZhOS1kZWU5LTQ4YjYtOTFmZi01NTk5YzgwMWNmMmIiLCJzY29wZSI6Im5vdGlmaWNhdGlvbnNlcnZpY2UtZW5kdXNlci1jb25uZWN0IiwibmJmIjoxNjY5NzI5Nzc2LCJleHAiOjE2NzAzMzQ1NzYsImlhdCI6MTY2OTcyOTc3NiwiaXNzIjoiaHR0cHM6Ly9mZXRlc3RhdXRoLm9ubWljcm9zb2Z0LmNvbSIsImF1ZCI6ImNvcmUtbm90aWZpY2F0aW9uc2VydmljZS1hcGkifQ.K6rSwVeK7X4kn5SB9gVWByq8G-EJe1ptrszCT1qsleo",'+
            '    "isSuccess": true'+
            '}';
            response.setBody(json);
        }
        return response;
    }
}