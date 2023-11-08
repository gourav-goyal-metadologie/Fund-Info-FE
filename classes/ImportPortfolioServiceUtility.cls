global class ImportPortfolioServiceUtility {

    global static Fe_FundInfo__FE_Analytic_Mapping__mdt feAnalyticMappings = Fe_FundInfo__FE_Analytic_Mapping__mdt.getAll().values().get(0);

    global static ImportPortfolioServiceUtilityWrapper getImportPortfolioServiceUtilityWrapper(Id portfolioId) {
        ImportPortfolioServiceUtilityWrapper importPortfolioServiceUtilityWrapper = new ImportPortfolioServiceUtilityWrapper();
        importPortfolioServiceUtilityWrapper.portfolioNameFieldValue = getPortfolioNameTable(portfolioId);
        importPortfolioServiceUtilityWrapper.initialChargeFieldValue = getInitialChargeTable(portfolioId);
        importPortfolioServiceUtilityWrapper.annualChargeFieldValue = getAnnualChargeTable(portfolioId);
        importPortfolioServiceUtilityWrapper.portfolioStartDate = getPortfolioStartDate(portfolioId);
        importPortfolioServiceUtilityWrapper.clientFirstName = getClientFirstName(portfolioId);
        importPortfolioServiceUtilityWrapper.clientLastName = getClientLastName(portfolioId);
        importPortfolioServiceUtilityWrapper.portfolioHoldings = getPortfolioHoldings(portfolioId);
        System.debug('ImportPortfolioServiceUtilityWrapper \n\n'+ ImportPortfolioServiceUtilityWrapper);
        return importPortfolioServiceUtilityWrapper;
    }

    global static String getPortfolioNameTable(Id portfolioId) {

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

    global static String getInitialChargeTable(Id portfolioId) {
        String initialChargeValue = '';
        String objectName = feAnalyticMappings.Fe_FundInfo__Initial_Charge_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Initial_Charge_Field__c;

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName + ' WHERE Id =: portfolioId WITH SECURITY_ENFORCED';
            List<SObject> sobjectList = new List<SObject>();
            sobjectList = Database.query(query);
            if(!sobjectList.isEmpty()){
                if(sobjectList[0].get(fieldName) != NULL){
                    initialChargeValue = String.valueOf(sobjectList[0].get(fieldName));
                }
            }
        }
        return initialChargeValue;
    }

    global static String getAnnualChargeTable(Id portfolioId) {
        String annualChargeValue = '';
        String objectName = feAnalyticMappings.Fe_FundInfo__Annual_Charge_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Annual_Charge_Field__c;

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName + ' WHERE Id =: portfolioId WITH SECURITY_ENFORCED';
            List<SObject> sobjectList = new List<SObject>();
            sobjectList = Database.query(query);
            if(!sobjectList.isEmpty()){
                if(sobjectList[0].get(fieldName) != NULL) {
                    annualChargeValue = String.valueOf(sobjectList[0].get(fieldName));
                }  
            }
        }
        return annualChargeValue;
    }

    global static String getPortfolioStartDate(Id portfolioId) {
        
        String objectName = feAnalyticMappings.Fe_FundInfo__Portfolio_Start_Date_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Portfolio_Start_Date_Field__c;
        String formatted = '';

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName +' WHERE Id =: portfolioId WITH SECURITY_ENFORCED';
            List<SObject> startDataValue = new List<SObject>();
            startDataValue = Database.query(query);
            if(!startDataValue.isEmpty()){
                if(startDataValue[0].get(fieldName) != null){
                    try {
                        DateTime myDateTime = Datetime.valueOf(startDataValue[0].get(fieldName));
                        formatted = myDateTime.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss');
                    } catch (Exception e) {
                        Date myDate = Date.valueOf(startDataValue[0].get(fieldName));
                        formatted = DateTime.newInstance(myDate.year(), myDate.month(), myDate.day()).format('yyyy-MM-dd\'T\'HH:mm:ss');
                    }
                }
            }
        }
        return formatted;
    }

    global static String getClientLastName(Id portfolioId) {
        String clientLastName = '';
        String objectName = feAnalyticMappings.Fe_FundInfo__Client_Last_Name_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Client_Last_Name_Field__c;

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName +' WHERE Id =: portfolioId WITH SECURITY_ENFORCED';
            List<SObject> sobjectList = new List<SObject>();
            sobjectList = Database.query(query);
            if(!sobjectList.isEmpty()){
                if(sobjectList[0].get(fieldName) != null){
                    clientLastName = String.valueOf(sobjectList[0].get(fieldName));   
                }
            }
        }
        return clientLastName;
    }

    global static String getClientFirstName(Id portfolioId){
        String clientFirstName = '';
        String objectName = feAnalyticMappings.Fe_FundInfo__Client_First_Name_Table__c;
        String fieldName = feAnalyticMappings.Fe_FundInfo__Client_First_Name_Field__c;

        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName)){
            String query = 'SELECT Id, '+ fieldName + ' FROM ' + objectName +' WHERE Id =: portfolioId WITH SECURITY_ENFORCED';
            List<SObject> sobjectList = new List<SObject>();
            sobjectList = Database.query(query);
            if(!sobjectList.isEmpty()){
                if(sobjectList[0].get(fieldName) != null){
                    clientFirstName = String.valueOf(sobjectList[0].get(fieldName));   
                }
            }
        }
        return clientFirstName;
    }

    global static List<SObject> getPortfolioHoldings(Id portfolioId) {
        String parentObjectName = feAnalyticMappings.Fe_FundInfo__Portfolio_Name_Table__c;

        String objectName1 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Holding_Amount_Table__c) ? feAnalyticMappings.Fe_FundInfo__Holding_Amount_Table__c : Null;
        String objectName2 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Holding_Identifier_Table__c) ? feAnalyticMappings.Fe_FundInfo__Holding_Identifier_Table__c : Null;
        String objectName3 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Holding_Instrument_Type_Table__c) ? feAnalyticMappings.Fe_FundInfo__Holding_Instrument_Type_Table__c : Null;
        String objectName4 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Portfolio_Currency_Table__c) ? feAnalyticMappings.Fe_FundInfo__Portfolio_Currency_Table__c : Null;

        Set<String> objectNamesSet = new Set<String>();
        if (objectName1 != Null) objectNamesSet.add(objectName1);
        if (objectName2 != Null) objectNamesSet.add(objectName2);
        if (objectName3 != Null) objectNamesSet.add(objectName3);
        if (objectName4 != Null) objectNamesSet.add(objectName4);

        Set<String> fieldsList = new Set<String>();
        
        String fieldName1 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Holding_Amount_Field__c) ? feAnalyticMappings.Fe_FundInfo__Holding_Amount_Field__c : Null;
        String fieldName2 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Holding_Identifier_Field__c) ? feAnalyticMappings.Fe_FundInfo__Holding_Identifier_Field__c : Null;
        String fieldName3 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Holding_Instrument_Type_Field__c) ? feAnalyticMappings.Fe_FundInfo__Holding_Instrument_Type_Field__c : Null;
        String fieldName4 = String.isNotBlank(feAnalyticMappings.Fe_FundInfo__Portfolio_Currency_Field__c) ? feAnalyticMappings.Fe_FundInfo__Portfolio_Currency_Field__c : Null;
       
        if (fieldName1 != Null) fieldsList.add(fieldName1);
        if (fieldName2 != Null) fieldsList.add(fieldName2);
        if (fieldName3 != Null) fieldsList.add(fieldName3);
        if (fieldName4 != Null) fieldsList.add(fieldName4);

        String parentFieldName = feAnalyticMappings.Fe_FundInfo__Parent_Field_Name__c;

        List<SObject> portfolioHolding = new List<SObject>();
        if(!fieldsList.isEmpty() && !objectNamesSet.isEmpty()){
            portfolioHolding = new List<SObject>();
            String sObjectQuery = 'SELECT Id';
                for(String fieldName : fieldsList) {
                    sObjectQuery += ', '+ fieldName;
                }
                sObjectQuery += ' FROM '+ new List<String>(objectNamesSet)[0];
            if(String.isNotBlank(parentFieldName)){
                sObjectQuery += ' WHERE '+ parentFieldName  + ' =: portfolioId WITH SECURITY_ENFORCED';
                portfolioHolding = Database.query(sObjectQuery);
            }else{
                sObjectQuery += ' WHERE Id =: portfolioId WITH SECURITY_ENFORCED';
                portfolioHolding = Database.query(sObjectQuery);
            }
        }
        return portfolioHolding;
    }

    global class ImportPortfolioServiceUtilityWrapper {
        global String portfolioNameFieldValue;
        global String initialChargeFieldValue;
        global String annualChargeFieldValue;
        global String portfolioStartDate;
        global String clientFirstName;
        global String clientLastName;
        global List<SObject> portfolioHoldings;
    }
    
}