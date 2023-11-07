trigger ProjectTrigger on Procurement_Savings_Project__c (after insert,after update,after delete){
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ProjectTriggerHandler.checkSupplierOnProcurementSavingsProject(Trigger.newMap, Trigger.oldMap);            
        }else if(Trigger.isUpdate){
            ProjectTriggerHandler.checkSupplierOnProcurementSavingsProject(Trigger.newMap, Trigger.oldMap);
        }else if(Trigger.isDelete){
            ProjectTriggerHandler.checkSupplierOnProcurementSavingsProject(null, Trigger.oldMap);
        }
    }
}