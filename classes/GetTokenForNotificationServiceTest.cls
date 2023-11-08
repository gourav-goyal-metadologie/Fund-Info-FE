@isTest
private class GetTokenForNotificationServiceTest {    
   
    @TestSetup
    static void setupData() {
        Fe_FundInfo__Log__c log = new Fe_FundInfo__Log__c();
        log.Fe_FundInfo__APEX_Class__c = 'John Doe';
        insert log;
    }

    @isTest
    static void sendRequestTest() {
        Test.setMock(HttpCalloutMock.class, new GetTokenForNotificationServiceMock());
        Test.startTest();
            GetTokenForNotificationService.sendRequest();
        Test.stopTest();
    }

}