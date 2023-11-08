@isTest
private class LogServiceTest {
    
    @isTest
    public static void getErrorLogTest() { 
        
        String className ='TestClass';
        Integer statusCode = 400;
        Exception error;
        try{
            Account a = New Account();
            a.name = '';
            insert a;    
        }
        Catch(Exception e){
            error = e;
        }
        
        String jsonBody = '{"Test":"Name","Body":"Body"}';
        Test.startTest();
        LogService.getErrorLog( className, statusCode, error, jsonBody );
        Test.StopTest();
    } 
    
    @isTest
    public static void createErrorLogTest() { 
        
        String className ='TestClass';
        Integer statusCode = 400;
        Exception error;
        try{
            Account a = New Account();
            a.name = '';
            insert a;    
        }
        Catch(Exception e){
            error = e;
        }
        
        String jsonBody = '{"Test":"Name","Body":"Body"}';
        Test.startTest();
        LogService.createErrorLog( className, statusCode, error, jsonBody );
        Test.StopTest();
    } 
    
    @isTest
    public static void logUpsertFailuresTest() { 
                
        String className ='TestClass';
        List<sObject> upsertRecords =new List<sObject>();
        List<Database.UpsertResult> upsertResults = new List<Database.UpsertResult>();
        Test.startTest();
        LogService.logUpsertFailures( className, upsertRecords, upsertResults );
        Test.StopTest();
    } 
    
    @isTest
    public static void logInsertUpdateFailuresTest() { 
        
        List<Account> accountList = new list<Account>{ New Account( Name='Test' ) };
        Database.SaveResult[] saveList = Database.update(accountList, false);  
        
        String className ='TestClass';
        List<sObject> upsertRecords =new List<sObject>();
        Test.startTest();
        LogService.logInsertUpdateFailures( className, accountList, saveList );
        Test.StopTest();
    } 
    
    @isTest
    public static void logNoWriteInsertUpdateFailuresTest() { 
        
        List<Account> accountList = new list<Account>{ New Account( Name='Test' ) };
        Database.SaveResult[] saveList = Database.update(accountList, false); 
        
        String className ='TestClass';
        List<sObject> upsertRecords =new List<sObject>();
        Test.startTest();
        LogService.logNoWriteInsertUpdateFailures( className, accountList, saveList );
        Test.StopTest();
    } 
    
    @isTest
    public static void logDeleteFailuresTest() { 
        
        List<Account> accountList = new list<Account>{ New Account( Name='Test' ) };
        insert accountList;
        Database.DeleteResult[] deleteList = Database.delete(accountList, false); 
        
        String className ='TestClass';
        List<sObject> upsertRecords =new List<sObject>();
        Test.startTest();
        LogService.logDeleteFailures( className, accountList, deleteList );
        Test.StopTest();
    } 
    @isTest
    public static void logSendEmailFailuresTest() { 
        
        List<Messaging.SingleEmailMessage> allMessage = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setPlainTextBody( 'test' );
        allMessage.add(mail);
        Messaging.SendEmailResult [] sendEmailResults = Messaging.sendEmail(allMessage,false);
        
        String className ='TestClass';
        List<sObject> upsertRecords =new List<sObject>();
        Test.startTest();
        LogService.logSendEmailFailures('CommonUtility.apxc.sendEmail()', sendEmailResults);
        Test.StopTest();
    } 
   
     
}