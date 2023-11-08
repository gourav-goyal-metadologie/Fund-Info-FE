public without sharing class GetMediumScanRequestIdsController {
    public String token{get; set;}
    public String requestId{get; set;}
    public String baseUrl{get; set;}
    public String recordId{get; set;}

    public GetMediumScanRequestIdsController() {
       this.token = Apexpages.currentPage().getParameters().get('token');
       this.requestId = Apexpages.currentPage().getParameters().get('requestId');
       this.baseUrl = Apexpages.currentPage().getParameters().get('baseURL');
       this.recordId = Apexpages.currentPage().getParameters().get('recordId');
    }
}