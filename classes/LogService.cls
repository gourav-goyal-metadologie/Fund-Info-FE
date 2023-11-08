public class LogService {

	/**
	 * 	@return Log__c
	 * 	This method is used for the get Error log.
	 */
	public static Fe_FundInfo__Log__c getErrorLog(String className, Integer statusCode, Exception error, String jsonBody) {
		Fe_FundInfo__Log__c errorLog = new Fe_FundInfo__Log__c();

		errorLog.Fe_FundInfo__APEX_Class__c = className;
		errorLog.Fe_FundInfo__Status_Code__c = statusCode;
		if (error != null) {
			errorLog.Fe_FundInfo__Error_Type__c = error.getTypeName();
			errorLog.Fe_FundInfo__Message__c = error.getMessage();
			errorLog.Fe_FundInfo__Stack_Trace__c = error.getStackTraceString();
		}
		if (jsonBody != null) { errorLog.Fe_FundInfo__JSON_Body__c = jsonBody.stripHtmlTags(); }

		return errorLog;
	}


	/**
	 * 	@return Null
	 * 	This method is used for the create Error log.
	 */
	public static void createErrorLog(String className, Integer statusCode, Exception error, String jsonBody) {
		Fe_FundInfo__Log__c errorLog = getErrorLog(className, statusCode, error, jsonBody);
		createErrorLog(errorLog);
	}

	/**
	 * @return Null
	 * This method is used for the create Error log only with one parameter.
	 */
	public static void createErrorLog(Fe_FundInfo__Log__c errorLog) {
		List<Fe_FundInfo__Log__c> listErrorLogs = new List<Fe_FundInfo__Log__c>();
		listErrorLogs.add(errorLog);
		createErrorLog(listErrorLogs);
	}

	/**
	 * @return Null
	 * This method is used for the create error log with bulkifiy way.
	 */
	public static void createErrorLog(List<Fe_FundInfo__Log__c> listErrorLogs) {
		if (System.isFuture() || System.isBatch()) {
			Database.DMLOptions dml = new Database.DMLOptions();
			dml.allowFieldTruncation = true;
			dml.optAllOrNone = true;
			Database.insert(listErrorLogs, dml);
		}
		else {
			createErrorLogAsync(JSON.serialize(listErrorLogs));
		}
	}

	/**
	 * 	@return Null
	 * 	This method is used for the create error log for asynchronous.
	 */
	@future
	public static void createErrorLogAsync(String jsonErrorLogs) {
		List<Fe_FundInfo__Log__c> listErrorLog = (List<Fe_FundInfo__Log__c>)JSON.deserialize(jsonErrorLogs, List<Fe_FundInfo__Log__c>.class);
		Database.DMLOptions dml = new Database.DMLOptions();
		dml.allowFieldTruncation = true;
		dml.optAllOrNone = true;
		Database.insert(listErrorLog, dml);
	}

	/**
	 * 	@return List<LogDatabaseError>
	 * 	This method is used for the create log when upsert is failed.
	 */
	public static List<LogDatabaseError> logUpsertFailures(String className, List<sObject> upsertRecords, List<Database.UpsertResult> upsertResults)
	{	
		List<LogDatabaseError> errorList = new List<LogDatabaseError>();
		List<Fe_FundInfo__Log__c> logList = new List<Fe_FundInfo__Log__c>();

		for(Integer i = 0; i < upsertResults.size(); i++)
		{
			Database.UpsertResult ur = upsertResults[i];
			sObject sObj = upsertRecords[i];

			if (! ur.isSuccess())
            {
				LogDatabaseError ldbe = new LogDatabaseError(ur, sObj);
				logList.add(getErrorLog(className, 0, null, JSON.serialize(ldbe)));
				errorList.add(ldbe);
			}
		}
		
		createErrorLog(logList);

		return errorList; 
	}

	/**
	 * 	@return List<LogDatabaseError>
	 * 	This method is used for the create log for when Insert and Update is failed.
	 */
	public static List<LogDatabaseError> logInsertUpdateFailures(String className, List<sObject> objRecords, List<Database.SaveResult> saveResults)
	{
		List<LogDatabaseError> errorList = new List<LogDatabaseError>();
		List<Fe_FundInfo__Log__c> logList = new List<Fe_FundInfo__Log__c>();

		for(Integer i = 0; i < saveResults.size(); i++)
		{
			Database.SaveResult sr = saveResults[i];
			sObject sObj = objRecords[i];

			if (! sr.isSuccess())
            {
                LogDatabaseError ldbe = new LogDatabaseError(sr, sObj);
				logList.add(getErrorLog(className, 0, null, JSON.serialize(ldbe)));
				errorList.add(ldbe);
            }
		}
		
		createErrorLog(logList);

		return errorList;
	}

	/**
	 * 	@return List<Log__c>
	 * 	This method is used for the create no log when Insert and Update is failed 
	 */
	public static List<Fe_FundInfo__Log__c> logNoWriteInsertUpdateFailures(String className, List<sObject> objRecords, List<Database.SaveResult> saveResults)
	{
		List<Fe_FundInfo__Log__c> logList = new List<Fe_FundInfo__Log__c>();
		
		for(Integer i = 0; i < saveResults.size(); i++)
		{
			Database.SaveResult sr = saveResults[i];
			sObject sObj = objRecords[i];

			if (! sr.isSuccess())
            {
                LogDatabaseError ldbe = new LogDatabaseError(sr, sObj);
				Fe_FundInfo__Log__c logToAdd = LogService.getErrorLog(className, 0, null, JSON.serialize(ldbe));
				logList.add(logToAdd);
            }
		}
		
		return logList;
	}

	/**
	 * 	@return List<LogDatabaseError> 
	 * 	This method is used for the delete failures log.
	 */
	public static List<LogDatabaseError> logDeleteFailures(String className, List<sObject> delRecords, List<Database.DeleteResult> deleteResults)
	{
		List<LogDatabaseError> errorList = new List<LogDatabaseError>();
		List<Fe_FundInfo__Log__c> logList = new List<Fe_FundInfo__Log__c>();

		for(Integer i = 0; i < deleteResults.size(); i++)
		{
			Database.DeleteResult dr = deleteResults[i];
			sObject sObj = delRecords[i];

			if (! dr.isSuccess())
            {
                LogDatabaseError ldbe = new LogDatabaseError(dr, sObj);
				logList.add(getErrorLog(className, 0, null, JSON.serialize(ldbe)));
				errorList.add(ldbe);
            }
		}

		createErrorLog(logList);

		return errorList; 
	}

	/**
	 * 	@return Null
	 *  This method is used for the create log when send Email is not successfull
	 */
	public static void logSendEmailFailures(String className, List<Messaging.SendEmailResult> sendEmailResults){
		List<Fe_FundInfo__Log__c> logList = new List<Fe_FundInfo__Log__c>();
		for(Integer i = 0; i < sendEmailResults.size(); i++)
		{
			Messaging.SendEmailResult se = sendEmailResults[i];
			system.debug('EMail '+ se);
			//sObject sObj = delRecords[i];
			if (!se.isSuccess()) {
				logList.add(getErrorLog(className, 0, null, JSON.serialize(se.getErrors())));
            }
		}

		createErrorLog(logList);
	}

	/**
	 * 	@wrapper Class
	 */
	public class LogDatabaseError 
	{
		public Database.UpsertResult upsertResult;
		public Database.SaveResult saveResult;
		public Database.DeleteResult deleteResult;
		public sObject record;

		public LogDatabaseError(Database.DeleteResult dr, sObject rec)
		{
			this.deleteResult = dr;
			this.record = rec;
		}
		public LogDatabaseError(Database.UpsertResult ur, sObject rec)
		{
			this.upsertResult = ur;
			this.record = rec;
		}
		public LogDatabaseError(Database.SaveResult sr, sObject rec)
		{
			this.saveResult = sr;
			this.record = rec;
		}
	}
}