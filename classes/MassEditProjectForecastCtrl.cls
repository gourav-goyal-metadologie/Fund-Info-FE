public with sharing class MassEditProjectForecastCtrl {
    public List<Procurement_Savings_Project_Forecast__c> forecastRecords {get; set;}

    public MassEditProjectForecastCtrl(ApexPages.StandardController standardController) {
        if(!ApexPages.currentPage().getParameters().containsKey('id')) return;

        Id projectRecordId = Id.valueOf(ApexPages.currentPage().getParameters().get('id'));
        initProjectForecasts(projectRecordId);
    }

    private void initProjectForecasts(Id projectRecordId) {
        forecastRecords = [SELECT Id, Name,
                                    January_Actual__c, February_Actual__c, March_Actual__c, April_Actual__c,
                                    May_Actual__c, June_Actual__c, July_Actual__c, August_Actual__c,
                                    September_Actual__c, October_Actual__c, November_Actual__c, December_Actual__c,
                                    January_Forecast__c, February_Forecast__c, March_Forecast__c, April_Forecast__c,
                                    May_Forecast__c, June_Forecast__c, July_Forecast__c, August_Forecast__c,
                                    September_Forecast__c, October_Forecast__c, November_Forecast__c, December_Forecast__c
                                    FROM Procurement_Savings_Project_Forecast__c
                                    WHERE Procurement_Savings_Project__c =: projectRecordId
                                ];
    }

    public PageReference saveForecasts() {
        if(forecastRecords.isEmpty()) return null;
        update forecastRecords;

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Successfully updated forecast records.'));
        return null;
    }
}