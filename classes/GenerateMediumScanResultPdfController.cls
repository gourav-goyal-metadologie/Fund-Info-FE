public class GenerateMediumScanResultPdfController {
    public String base64Data {get; set;}
    public Boolean showSpinner {get; set;}
    public GenerateMediumScanResultPdfController() {
        this.showSpinner = true;
        String requestId = ApexPages.currentPage().getParameters().get('data');
        RenderGetMediumScanResult.RenderGetMediumScanResultToastWrapper result = getMediumScanResult(requestId);
        System.debug('result '+ result);
        if(String.isNotBlank(result.data) && result.data != 'error'){
        System.debug('inside result '+ result);
            this.base64Data = 'data:application/pdf;base64,'+result.data;
            this.showSpinner = false;
        }
    }

    @AuraEnabled
    public static RenderGetMediumScanResult.RenderGetMediumScanResultToastWrapper getMediumScanResult(String requestId) {
        return RenderGetMediumScanResult.sendRequest(requestId);
    }

    @AuraEnabled(cacheable=false)
    public static Fe_FundInfo__FE_EndPoint__mdt fetchCustomMetaDataType() {
        return  [SELECT Id,
                    Fe_FundInfo__MediumScanResult_Success_Message__c,
                    Fe_FundInfo__Does_Not_Have_MSR_Code_Error_Message__c,
                    Fe_FundInfo__MediumScanResult_Error_Message__c,
                    Fe_FundInfo__Unauthorised_Message__c,
                    Fe_FundInfo__Unauthorised_Message_Hyperlink__c
                    FROM Fe_FundInfo__FE_EndPoint__mdt
                ];
    }

    @AuraEnabled
    public static void portfolioCompletedNotification(String data, Id recordId, Boolean isWarningTextHoldingIdentifier, Boolean isWarningTextHoldingDuplicate){
        try {
            CustomNotificationType notificationType = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Portfolio_Pdf_Notification' WITH SECURITY_ENFORCED LIMIT 1];
            MediumAsyncUtility.MediumAsyncUtilityWrapper mediumAsyncUtilityWrapper  = MediumAsyncUtility.getMediumAsyncUtilityWrapper(recordId);
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setTargetId(recordId);
            notification.setNotificationTypeId(notificationType.Id);
            Id userId = UserInfo.getUserId();
            
            if(String.isNotEmpty(data) && !isWarningTextHoldingIdentifier && !isWarningTextHoldingDuplicate){
                notification.setTitle('Medium Scan Generation Complete');
                string s = '{ ' +
                   ' type: \'standard__webPage\',' +
                   ' attributes: { ' +
                       ' url: \''+ URL.getSalesforceBaseUrl().toExternalForm() +'/apex/fe_fundinfo__GenerateMediumScanResultPdf?data=' +data+'\''+
                    '},' +
                '}';
                System.debug(s+'ssss');
                notification.setTargetPageRef(s);
                notification.setBody('Medium scan for ' +  mediumAsyncUtilityWrapper.portfolioNameFieldValue +' is now available, click on message to open. \n PDF available for 24 hours.');
            }
            else if(String.isNotEmpty(data) && isWarningTextHoldingIdentifier) {
                notification.setTitle('Medium Scan Generation Complete');
                string s = '{ ' +
                   ' type: \'standard__webPage\',' +
                   ' attributes: { ' +
                       ' url: \''+ URL.getSalesforceBaseUrl().toExternalForm() +'/apex/fe_fundinfo__GenerateMediumScanResultPdf?data=' +data+'\''+
                    '},' +
                '}';
                System.debug(s+'ssss');
                notification.setTargetPageRef(s);
                notification.setBody('Medium scan for ' +  mediumAsyncUtilityWrapper.portfolioNameFieldValue +'  is now available, click on message to open. \n Unrecognised holdings identified have been excluded. \n PDF available for 24 hours.');
            }
            else if (String.isNotEmpty(data) && isWarningTextHoldingDuplicate) {
                notification.setTitle('Medium Scan Generation Complete');
                string s = '{ ' +
                   ' type: \'standard__webPage\',' +
                   ' attributes: { ' +
                       ' url: \''+ URL.getSalesforceBaseUrl().toExternalForm() +'/apex/fe_fundinfo__GenerateMediumScanResultPdf?data=' +data+'\''+
                    '},' +
                '}';
                System.debug(s+'ssss');
                notification.setTargetPageRef(s);
                notification.setBody('Medium scan for ' +  mediumAsyncUtilityWrapper.portfolioNameFieldValue +'  is now available, click on message to open. \n Duplicated holdings identified have been aggregated into a single holding. \n PDF available for 24 hours.');
            } 
            else {
                notification.setTitle('Medium Scan Generation Failed');
                notification.setBody('Medium scan for ' +  mediumAsyncUtilityWrapper.portfolioNameFieldValue +' could not be generated, please try again.');
            }
            notification.send(new set<String>{userId});
        } catch (Exception e) {
          //  throw new AuraHandledException(e.getMessage());
        }
    }
}