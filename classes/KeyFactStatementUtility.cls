public  class KeyFactStatementUtility {

    public  static Fe_FundInfo__FE_Analytic_Mapping__mdt feAnalyticMappings = Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0);

    public static KeyFactStatementUtilityWrapper getKeyFactStatementUtilityWrapper(Id protfolioHoldingId) {
        KeyFactStatementUtilityWrapper keyFactStatementUtilityWrapper = new KeyFactStatementUtilityWrapper();
        keyFactStatementUtilityWrapper.code = getHoldingIdentifier(protfolioHoldingId);
        keyFactStatementUtilityWrapper.instrType = getHoldingInstrumentType(protfolioHoldingId);
        return keyFactStatementUtilityWrapper;
    }

    private static String getHoldingIdentifier(Id protfolioHoldingId) {
        // code__c
        String code = '';
        String objectName = feAnalyticMappings.Fe_FundInfo__Holding_Identifier_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Holding_Identifier_Field__c;

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            List<SObject> sobjectList = new List<SObject>();
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName + ' WHERE Id =: protfolioHoldingId WITH SECURITY_ENFORCED';
            sobjectList = Database.query(query);

            if(!sobjectList.isEmpty()){
                if(sobjectList[0].get(fieldName) != NULL){
                    code = String.valueOf(sobjectList[0].get(fieldName));
                }
            }
        }
        return code;
    }

    private static String getHoldingInstrumentType(Id protfolioHoldingId) {
        // Instr Type
        String instrType = '';
        String objectName = feAnalyticMappings.Fe_FundInfo__Holding_Instrument_Type_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Holding_Instrument_Type_Field__c;

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            List<SObject> sobjectList = new List<SObject>();
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName + ' WHERE Id =: protfolioHoldingId WITH SECURITY_ENFORCED';
            sobjectList = Database.query(query);

            if(!sobjectList.isEmpty()){
                if(sobjectList[0].get(fieldName) != NULL){
                    instrType = String.valueOf(sobjectList[0].get(fieldName));
                }
            }
        }
        return instrType;
    }

    public class KeyFactStatementUtilityWrapper{
        public String code;
        public String instrType;
    }
}