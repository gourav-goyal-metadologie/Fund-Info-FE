public class ProjectTriggerHandler {
    
    public static void checkSupplierOnProcurementSavingsProject(Map<Id, Procurement_Savings_Project__c> newMap, Map<Id, Procurement_Savings_Project__c> oldMap){
        
        // Insert and Update.
        List<Procurement_Savings_Project__c> procurementSavingsProjects = new List<Procurement_Savings_Project__c>();
        Set<Id> supplierIds = new Set<Id>();
        
        if(Trigger.isInsert){
            procurementSavingsProjects = newMap.values();
        }if(Trigger.isDelete){
            procurementSavingsProjects = oldMap.values();
        }if(Trigger.isUpdate){
            procurementSavingsProjects = newMap.values();
        }
        
        for(Procurement_Savings_Project__c procurementSavingsProject : procurementSavingsProjects){
            if(procurementSavingsProject.Supplier__c != null){
                supplierIds.add(procurementSavingsProject.Supplier__c);
            }
            
            // Udpate
            if(Trigger.isUpdate){
                if((oldMap.get(procurementSavingsProject.Id).Supplier__c != procurementSavingsProject.Supplier__c)){                    
                    supplierIds.add(procurementSavingsProject.Supplier__c);
                    supplierIds.add(oldMap.get(procurementSavingsProject.Id).Supplier__c);
                }
                
                if(((oldMap.get(procurementSavingsProject.Id).Total_Actuals__c != procurementSavingsProject.Total_Actuals__c) || 
                   (oldMap.get(procurementSavingsProject.Id).Total_Forecast__c != procurementSavingsProject.Total_Forecast__c) ) &&
                   procurementSavingsProject.Supplier__c != null
                  ){

                      supplierIds.add(procurementSavingsProject.Supplier__c);
                  }
            }
        }

        if(!supplierIds.isEmpty()){
            SupplierService.updateSuppliers(supplierIds);            
        }

    }
}