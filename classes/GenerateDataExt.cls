public Class GenerateDataExt{
    public Boolean dataGenerated{get;set;}
    public Boolean dataAlreadyGenerated{get;set;}
    
    public GenerateDataExt(){
        dataGenerated = false;
        
        List<Supplier__c> checkExistingSupplier = [select id from Supplier__c where Name = 'MintCRM'];
        
        if(checkExistingSupplier.size() > 0){
            dataAlreadyGenerated = true;
        }else{
            dataAlreadyGenerated = false;
        }
    }
    
    public void DeleteData(){
        delete [select id from Supplier__c];
        delete [select id from Procurement_Savings_Project__c];
        
        dataGenerated = false;
        dataAlreadyGenerated = false;
    }
    
    public void Generate(){
        Supplier__c sup = new Supplier__c();
        sup.Name = 'MintCRM';
        insert sup;
        
        List<Procurement_Savings_Project__c> projects = new List<Procurement_Savings_Project__c>();
        List<Procurement_Savings_Project_Forecast__c> forecasts = new List<Procurement_Savings_Project_Forecast__c>();
        
        Procurement_Savings_Project__c p1 = new Procurement_Savings_Project__c();
        p1.Supplier__c = sup.id;
        p1.Project_Start_Date__c = date.newInstance(date.today().year(),1,1);
        p1.Project_End_Date__c = date.newInstance(date.today().year(),12,31);
        p1.Sites__c = 'Bridgend';
        p1.Description__c = 'Project 1';
        p1.Division__c = 'Clinical';
        p1.Justification__c = 'For training purposes';
        p1.Name = 'Stationary';
        projects.add(p1);
        
        Procurement_Savings_Project__c p2 = new Procurement_Savings_Project__c();
        p2.Project_Start_Date__c = date.newInstance(date.today().year()+1,1,1);
        p2.Project_End_Date__c = date.newInstance(date.today().year()+1,12,31);
        p2.Sites__c = 'Dublin;Ohio';
        p2.Description__c = 'Project 2';
        p2.Division__c = 'Manufacturing';
        p2.Justification__c = 'For training purposes';
        p2.Name = 'Warehouse Equipment';
        projects.add(p2);
        
        Procurement_Savings_Project__c p3 = new Procurement_Savings_Project__c();
        p3.Project_Start_Date__c = date.newInstance(date.today().year(),1,1);
        p3.Project_End_Date__c = date.newInstance(date.today().year(),12,31);
        p3.Sites__c = 'Melbourne;Rockford;San Diego';
        p3.Description__c = 'Project 3';
        p3.Division__c = 'Corporate Other';
        p3.Justification__c = 'For training purposes';
        p3.Name = 'Customer Hosting Costs';
        projects.add(p3);
        
        insert projects;
        
        for(Procurement_Savings_Project__c p:projects){
            // split on sites - copy division
            
            List<String> sites = p.Sites__c.split(';');
            
            for(String s:sites){
                Procurement_Savings_Project_Forecast__c forecast = new Procurement_Savings_Project_Forecast__c();
                forecast.Procurement_Savings_Project__c = p.id;
                forecast.Name = p.Name + ' - ' + s;
                forecast.Site__c = s;
                forecast.Division__c = p.Division__c;
                
                forecast.January_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.February_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.March_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.April_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.May_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.June_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.July_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.August_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.September_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.October_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.November_Forecast__c = Integer.valueof((Math.random() * 10000));
                forecast.December_Forecast__c = Integer.valueof((Math.random() * 10000));
                
                forecast.January_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.February_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.March_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.April_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.May_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.June_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.July_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.August_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.September_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.October_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.November_Actual__c = Integer.valueof((Math.random() * 10000));
                forecast.December_Actual__c = Integer.valueof((Math.random() * 10000));
                
                forecasts.add(forecast);
            }
        }
        
        insert forecasts;
        
        dataGenerated = true;
    }
}