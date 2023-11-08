public class FeFundAuthToken {
    /**
     *  Fetch end point url from the custom label
     */
    public static final String AUTH_ENDPOINT_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Authentication_Token_Url__c;

    /**
     *  Store header's POST parameter as String.
     */
    public static final String HTTP_METHOD_POST = 'POST';

    /**
     *  Store header's Content-Type parameter as String.
     */
    public static final String HEADER_CONTENT_TYPE = 'Content-Type';

    /**
     *  Store header's application/json parameter as String.
     */
    public static final String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'application/json';

    /**
     *  Store header's multipart/form-data as String.
     */
    public static final String HEADER_CONTENT_TYPE_MULTIPART_FORMDATA = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW';

    /**
     *  Store webKitFormBounday as String.
     */
    public static final String SET_BODY_WEBKITFORMBOUNDARY = '------WebKitFormBoundary7MA4YWxkTrZu0gW';

    /**
     *  Store contentDispostion as String.
     */
    public static final String SET_BODY_ContentDisposition = 'Content-Disposition: form-data; name=';

    /**
     *  Fetch FE_FundIdentity_Portal_Header__mdt custom metadata record.
     */
    public static final List<Fe_FundInfo__FE_FundIdentity_Portal_Header__mdt> fundIdentiyPortalHeaders = [SELECT ID, Label, Fe_FundInfo__Value__c FROM Fe_FundInfo__FE_FundIdentity_Portal_Header__mdt];
    
    /**
     *  @return It will return FeFundAuthTokenResponseWrapper its a wrapper class.
     *  This method is used for the send request to the Http server the get 
     *  the reponse token
     */
    public static FeFundAuthTokenResponseWrapper generateHeaderToken() {
        try{
            String requestBodyForClientId;
            String requestBodyForGrantType;
            String requestBodyForClientSecret;
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(AUTH_ENDPOINT_URL);
            request.setMethod(HTTP_METHOD_POST);
            request.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_APPLICATION_JSON);
            request.setHeader(HEADER_CONTENT_TYPE, HEADER_CONTENT_TYPE_MULTIPART_FORMDATA);
            
            for(Fe_FundInfo__FE_FundIdentity_Portal_Header__mdt fundIdentiyPortalHeader : fundIdentiyPortalHeaders){
                if(fundIdentiyPortalHeader.Label == 'client_id'){
                    requestBodyForClientId = SET_BODY_WEBKITFORMBOUNDARY + '\r\n' + SET_BODY_ContentDisposition + '\"' + fundIdentiyPortalHeader.Label + '\"\r\n\r\n' + fundIdentiyPortalHeader.Fe_FundInfo__Value__c + '\r\n'; 
                }else if(fundIdentiyPortalHeader.Label == 'grant_type'){
                    requestBodyForGrantType = SET_BODY_WEBKITFORMBOUNDARY + '\r\n' + SET_BODY_ContentDisposition + '\"' + fundIdentiyPortalHeader.Label + '\"\r\n\r\n' + fundIdentiyPortalHeader.Fe_FundInfo__Value__c + '\r\n'; 
                }else if(fundIdentiyPortalHeader.Label == 'client_secret'){
                    requestBodyForClientSecret = SET_BODY_WEBKITFORMBOUNDARY + '\r\n' + SET_BODY_ContentDisposition + '\"' + fundIdentiyPortalHeader.Label + '\"\r\n\r\n' + fundIdentiyPortalHeader.Fe_FundInfo__Value__c + '\r\n'; 
                }
            }
            System.debug(requestBodyForGrantType + requestBodyForClientId + requestBodyForClientSecret + SET_BODY_WEBKITFORMBOUNDARY + '--');
            request.setbody(requestBodyForClientId + requestBodyForGrantType + requestBodyForClientSecret + SET_BODY_WEBKITFORMBOUNDARY + '--');
            
            HttpResponse response = http.send(request);
            
            if(response.getStatusCode() == 200) {
                System.debug(response.getBody());
                return (FeFundAuthTokenResponseWrapper) System.JSON.deserialize(response.getBody(), FeFundAuthTokenResponseWrapper.class);
            } else {
                system.debug(response.getBody());
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
                return (FeFundAuthTokenResponseWrapper) System.JSON.deserialize(response.getBody(), FeFundAuthTokenResponseWrapper.class);
            }
            
            
        }catch(Exception error){
            LogService.createErrorLog('FeFundIdentityPortal.apxc', NULL, error, NULL);
            return null;
        }   
    }
    
    /**
     *  @return Null
     *  This class is used as wrapper class to hold the Http reponse.
     */
    public class FeFundAuthTokenResponseWrapper {
        public String access_token;
        public Integer expires_in;
        public String token_type;
        public String error;
    }
}