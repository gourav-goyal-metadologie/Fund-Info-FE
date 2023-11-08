@isTest
global class GetMediumAsyncCallMock implements HttpCalloutMock {
    public static final String HEADER_CONTENT_TYPE = 'Content-Type';
    public static final String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';
    public static final String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer';
    public static final String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkYyM0M1QUQ1QzBBNjY2OUE3RjY2REE2QTA2QTRDMUUzNzMzQTY4ODkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiI4anhhMWNDbVpwcF9adHBxQnFUQjQzTTZhSWsifQ.eyJuYmYiOjE2NTc4MDQ1MDEsImV4cCI6MTY1NzgwODEwMSwiaXNzIjoiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20iLCJhdWQiOlsiaHR0cHM6Ly9wcmVwLWF1dGguZmVmdW5kaW5mby5jb20vcmVzb3VyY2VzIiwiYWR2aXNvcnktYmFja29mZmljZWludGVncmF0aW9uLWFwaS1wcmVwcm9kIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktcHJlcHJvZCJdLCJjbGllbnRfaWQiOiJmZWZ1bmRpbmZvLWFkdmlzZXJ5LWJhY2tvZmZpY2VpbnQtc2pwc2YtcHJlcHJvZCIsInNjb3BlIjpbImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktcmVhZCIsImFkdmlzb3J5LWJhY2tvZmZpY2VpbnRlZ3JhdGlvbi1hcGktd3JpdGUiLCJhZHZpc29yeS1mZWF3cmFwcGVyLWFwaS1yZWFkIiwiYWR2aXNvcnktZmVhd3JhcHBlci1hcGktd3JpdGUiXX0.KJp0XM-uPCqiQj6I3q3VTzYcZOUjODbFkxxVj9bbdrF2Y_RCzsN5usvBGgExCTtQ-b2QfuXrr3wPgGLOBrqJaoxzInZsOnQ7AyZcLaoddQXDa3Sk2bZSRJWjJjXRov5PDOFrkKOazu-cykM9x0z0IuH_f_q1_ZU4VbuGuJjLC2luB76QjBV_EeCQ98GkqYBF167jxLVqu0nfpzSYumwPzU76gEtkCGw3wytIpgXuCVXp2cvQ1Ps0nK5vQ-7Q9q2oqy20eK62ln_SjCnGzzCHEQ1vLmIcfuysX9-KgONobky8SEebkHLx2P6YLoUCTRG3KBGsCpwYnXARUbGEk-m2zw';

    String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    String Post_Fix_Url = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c;
    String ImportPortfolio_PostUrl = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Portfolio_Import__c;
    String MediumAsync_PortUrl = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Medium_Async_Url__c;

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
        
        if(request.getEndpoint().contains(Base_URL+Post_Fix_Url)) {
            response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + token);
            response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
            response.setStatusCode(200);
            String json = '{"data": true, "isSuccess": true}';
            response.setBody(json);
            System.assertEquals('POST', request.getMethod());
        }

        if(request.getEndpoint().contains(Base_URL+ImportPortfolio_PostUrl)){

            response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + token);
            response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
            response.setStatusCode(200);
			String json=		'{'+
			'    "data": {'+
			'        "importBasicPortfolioResult": {'+
			'            "id": 1,'+
			'            "name": "SampleWithUnitsRebalanceSectorAverage",'+
			'            "hasImported": true,'+
			'            "logReference": 508888,'+
			'            "analyticsPortfolioID": 431517035,'+
			'            "analyticsUserID": "24ddcfa9-dee9-48b6-91ff-5599c801cf2b",'+
			'            "isNewPortfolio": false,'+
			'            "autoLoginURL": "https://qa.feanalytics.com/NewDefault.aspx?VendorID=SJP&ctxt=431517035&pfSelected=431517035&pfAdd=1&RandomKey=XSqB6req+S1xTGY7m10L5Q==&RandomReg=7sS+3kG3STaLKyL9Ufsr1w==",'+
			'            "importWarnings": [],'+
			'            "importErrors": [],'+
			'            "importStatusInfo": ['+
			'                {'+
			'                    "name": "ID",'+
			'                    "value": "5088"'+
			'                },'+
			'                {'+
			'                    "name": "TimeStamp",'+
			'                    "value": "19/10/2022 11:04:37"'+
			'                },'+
			'                {'+
			'                    "name": "VendorID",'+
			'                    "value": "SJP"'+
			'                },'+
			'                {'+
			'                    "name": "Ref",'+
			'                    "value": "1"'+
			'                },'+
			'                {'+
			'                    "name": "PortfolioName",'+
			'                    "value": "SampleWithUnitsRebalanceSectorAverage"'+
			'                },'+
			'                {'+
			'                    "name": "PortfolioType",'+
			'                    "value": "BasicPortfolio"'+
			'                },'+
			'                {'+
			'                    "name": "isPasswordHashed",'+
			'                    "value": "False"'+
			'                },'+
			'                {'+
			'                    "name": "OverWrite",'+
			'                    "value": "True"'+
			'                },'+
			'                {'+
			'                    "name": "SeriesOnlyUpdate",'+
			'                    "value": "False"'+
			'                },'+
			'                {'+
			'                    "name": "UserID",'+
			'                    "value": "24ddcfa9-dee9-48b6-91ff-5599c801cf2b"'+
			'                },'+
			'                {'+
			'                    "name": "PortfolioID",'+
			'                    "value": "431517035"'+
			'                },'+
			'                {'+
			'                    "name": "isNewPortfolio",'+
			'                    "value": "False"'+
			'                },'+
			'                {'+
			'                    "name": "hasImported",'+
			'                    "value": "True"'+
			'                },'+
			'                {'+
			'                    "name": "timeTaken",'+
			'                    "value": "2080"'+
			'                },'+
			'                {'+
			'                    "name": "SeriesRowsInXML",'+
			'                    "value": "1"'+
			'                },'+
			'                {'+
			'                    "name": "SeriesRowsDeleted",'+
			'                    "value": "1"'+
			'                },'+
			'                {'+
			'                    "name": "SeriesRowsUpdated",'+
			'                    "value": "0"'+
			'                },'+
			'                {'+
			'                    "name": "SeriesRowsInserted",'+
			'                    "value": "1"'+
			'                },'+
			'                {'+
			'                    "name": "HoldingsRowsInXML",'+
			'                    "value": "3"'+
			'                },'+
			'                {'+
			'                    "name": "HoldingsRowsDeleted",'+
			'                    "value": "3"'+
			'                },'+
			'                {'+
			'                    "name": "HoldingsRowsUpdated",'+
			'                    "value": "0"'+
			'                },'+
			'                {'+
			'                    "name": "HoldingsRowsInserted",'+
			'                    "value": "1"'+
			'                },'+
			'                {'+
			'                    "name": "WarningCount",'+
			'                    "value": "0"'+
			'                },'+
			'                {'+
			'                    "name": "ErrorCount",'+
			'                    "value": "0"'+
			'                },'+
			'                {'+
			'                    "name": "methodDuration",'+
			'                    "value": "3457.3366"'+
			'                },'+
			'                {'+
			'                    "name": "importProcDuration",'+
			'                    "value": "2170.76"'+
			'                }'+
			'            ]'+
			'        }'+
			'    },'+
			'    "isSuccess": true'+
			'}';
            response.setBody(json);
            System.assertEquals('POST', request.getMethod());
        }

        if(request.getEndpoint().contains(Base_URL + MediumAsync_PortUrl)){
            response.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + token);
            response.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
            response.setStatusCode(202);
            String json = '7875a9ce-47d8-4171-a778-3c48735c7716';
            response.setBody(json);
            System.assertEquals('POST', request.getMethod());
        }

        return response;
    }
}