public class SupplierService {
    public static void updateSuppliers(Set<Id> supplierIds){
        List<Supplier__c> suppliers = new List<Supplier__c>();
        List<AggregateResult> aggregateResults = [SELECT SUM(Total_Actuals__c)totalAct, SUM(Total_Forecast__c)totalFor,
                                                  COUNT(Id)ids, Supplier__c
                                                  FROM Procurement_Savings_Project__c 
                                                  WHERE Supplier__c IN : supplierIds GROUP BY Supplier__c];
        for(AggregateResult aggregateResult : aggregateResults){
            Supplier__c supplier = new Supplier__c();
            supplier.Total_Actual__c = (Decimal)aggregateResult.get('totalAct');
            supplier.Total_Forecast__c = (Decimal)aggregateResult.get('totalFor');
            supplier.No_of_Projects__c = (Integer)aggregateResult.get('ids');
            supplier.Id = (Id)aggregateResult.get('Supplier__c');
            suppliers.add(supplier);
        }

        if(!suppliers.isEmpty()){
            update suppliers;
        }
    }
}