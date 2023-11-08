public class MediumAsyncUtility {
    public static Fe_FundInfo__FE_Analytic_Mapping__mdt feAnalyticMappings = Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0);

    public static MediumAsyncUtilityWrapper getMediumAsyncUtilityWrapper(Id portfolioId) {
        MediumAsyncUtilityWrapper mediumAsyncUtilityWrapper = new MediumAsyncUtilityWrapper();
        MediumAsyncUtilityWrapper.portfolioNameFieldValue = getPortfolioNameTable(portfolioId);
        return mediumAsyncUtilityWrapper;
    }

    public static String getPortfolioNameTable(Id portfolioId) {

        String portfolioName = '';
        String objectName = feAnalyticMappings.Fe_FundInfo__Portfolio_Name_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Portfolio_Name_Field__c;

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            List<SObject> sobjectList = new List<SObject>();
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName + ' WHERE Id =: portfolioId WITH SECURITY_ENFORCED';
            sobjectList = Database.query(query);

            if(!sobjectList.isEmpty()){
                if(sobjectList[0].get(fieldName) != NULL){
                    portfolioName = String.valueOf(sobjectList[0].get(fieldName));
                }
            }
        }
        return portfolioName;
    }

    public class MediumAsyncUtilityWrapper {
        public String portfolioNameFieldValue;
    }
}