global class ImportPortfolioServiceWrapper {
	public Data data;
	public boolean isSuccess;
	public Error error;
	public class Error {
		public Integer errorCode;
		public String message;	
		public String traceId;
	}
	public class Data {
		public ImportBasicPortfolioResult importBasicPortfolioResult;
	}
	public class ImportBasicPortfolioResult {
		public Integer id;
		public String name;
		public boolean hasImported;
		public Integer logReference;	
		public Integer analyticsPortfolioID;	
		public String analyticsUserID;
		public boolean isNewPortfolio;
		public String autoLoginURL;
		public ImportWarnings[] importWarnings;
		public ImportErrors[] importErrors;
		public ImportStatusInfo[] importStatusInfo;
	}
	public class ImportWarnings {
		public String warningItem;
		public String warningDescription;
	}
	public class ImportErrors {
	}
	public class ImportStatusInfo {
		public String name;
		public String value;
	}

	public static ImportPortfolioServiceWrapper parse(String json){
		return (ImportPortfolioServiceWrapper) System.JSON.deserialize(json, ImportPortfolioServiceWrapper.class);
    }
}