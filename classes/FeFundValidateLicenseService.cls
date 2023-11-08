public class FeFundValidateLicenseService {
   /**
     *	@Custom Label
     *	Fetch FE_EndPoint__mdt custom metadata type which will store the
	 *	base url.
     */ 
    public static String Base_URL = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Base_Url__c;
    public static final String HTTP_METHOD_Post = 'POST';
    public static final String HEADER_AUTHORIZATION = 'Authorization';
    public static final String HEADER_BEARER_AUTHORIZATION = 'Bearer ';
    /**
     * 	Fetch FE_EndPoint__mdt custom metadata type which will store the postfix url.
     */ 
    public static final String Post_Fix_Url = Fe_FundInfo__FE_EndPoint__mdt.getAll().values().get(0).Fe_FundInfo__Back_Office_Validate_Url__c;
    
    /**
     *	@return Null
     * 	This method is used for the send Http Request to the Portfolio validate end point.
     * 	@param It will accept one parameters Header Token.
     */ 
    public static  FeFundValidateLicenseService.FeFundValidateLicenseWrapper validateLicense(String HEADER_TOKEN) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            system.debug('validate url >> ' + Base_URL + Post_Fix_Url);
            request.setEndpoint(Base_URL + Post_Fix_Url);
            request.setMethod(HTTP_METHOD_Post);
            request.setHeader(HEADER_AUTHORIZATION, HEADER_BEARER_AUTHORIZATION + HEADER_TOKEN);
            request.setHeader('Content-Type', 'application/json');
            request.setBody(getrequestBody(UserInfo.getUserEmail()));
            HttpResponse response = http.send(request);
            return (response.getStatusCode() == 200) 
            ? (FeFundValidateLicenseWrapper) System.JSON.deserialize(response.getBody(), FeFundValidateLicenseWrapper.class)
            : null;
        } catch (Exception error) {
            return null;
        }
    }

    /**
     *	@return String
     * 	This method is used for the generate requeset body.
     * 	@param It will accept one parameter userEmail.
     */ 
    public static String getrequestBody(String userEmail) {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('userEmail', userEmail);
        gen.writeEndObject();
        String requestBody = gen.getAsString();
        System.debug('requestBody >> '+ requestBody);
        return requestBody;
    }
    
    /**
     * 	This class is used for the store the reponse.
     */ 
    public class FeFundValidateLicenseWrapper{
        public Boolean data;
	    public Boolean isSuccess;
        public Error error;
    }

	public class Error {
		public Integer errorCode;
		public String message;
		public String traceId;
	}
}