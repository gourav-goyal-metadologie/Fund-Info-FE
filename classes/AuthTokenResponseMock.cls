@isTest
global class AuthTokenResponseMock  implements HttpCalloutMock {
    public static final String HEADER_CONTENT_TYPE = 'Content-Type';
    public static final String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
    public static final String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
   
    global HTTPResponse respond(HTTPRequest request) {
     
        HttpResponse response = new HttpResponse();
        response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
        response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_MULTIPART_FORMDATA);
        response.setStatusCode(200);
        response.setBody('{"access_token":"eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw","expires_in":3600,"token_type":"Bearer"}');
        System.assertEquals(Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c, request.getEndpoint());
        System.assertEquals('POST', request.getMethod());
       
        return response;       
    }
}