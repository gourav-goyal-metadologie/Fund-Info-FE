@isTest
private class GenerateDataExtTest{
    private static testMethod void Test(){
        GenerateDataExt ext = new GenerateDataExt();
        ext.Generate();
        
        // test double data creation
        GenerateDataExt extWithData = new GenerateDataExt();
        
        // test deletion of data
        ext.DeleteData();
    }
}