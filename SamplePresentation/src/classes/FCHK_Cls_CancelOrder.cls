global class FCHK_Cls_CancelOrder{

    public Id OrderId;

    /*public FCHK_Cls_CancelOrder(ApexPages.StandardController controller) {
        OrderId = ApexPages.CurrentPage().getParameters().get('id');
        
    }*/

    //public FCHK_Cls_CancelOrder(){}
    
    webservice static void CancelOrder(Id OrderId){
        Account UpdateAcc = new Account();
        Order ord = [select AccountId,Status,FCHK_Total_Cost__c,FCHK_1st_Purchase_Done__c,FCHK_Remarks__c,FCHK_Delivery_Status__c ,
                    FCHK_BirthDay_Offer_Taken__c from Order where Id=:OrderId];    
                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        system.debug('--ord--'+ord);
        
        Account Acc = [select FCHK_Total_Expenses__c,FCHK_1st_Purchase_Done__c,FCHK_BirthDay_Offer_Taken__c from Account where RecordTypeId=:RecId.Id and Id=:ord.AccountId];
        system.debug('--Acc--'+Acc);
        
        if(Acc!=null){
        Acc.FCHK_Total_Expenses__c = Acc.FCHK_Total_Expenses__c - ord.FCHK_Total_Cost__c;
        
        //UpdateAcc = Acc;
        
        
        
        if(ord.FCHK_1st_Purchase_Done__c == true)
            Acc.FCHK_1st_Purchase_Done__c = false;
        if(ord.FCHK_BirthDay_Offer_Taken__c == true)
            Acc.FCHK_BirthDay_Offer_Taken__c = false;
            
        update Acc;
        }    
        
        
        //if(ApexPages.hasMessages(ApexPages.Severity.ERROR)){
        if(ord!=null){
            ord.Status = 'Order Cancelled';
            ord.FCHK_Delivery_Status__c = 'Cancelled';
            ord.FCHK_Total_Cost__c = 0;
            ord.FCHK_1st_Purchase_Done__c = false;
            ord.FCHK_BirthDay_Offer_Taken__c = false;
            update ord;
        
        
        //update Acc;
        system.debug('--Update done--'+ord.Status);
        }
        //return new PageReference('https://cs5.salesforce.com/' + ord.Id); 
        //}
        //else
        //return null;
    }
    
   
    
}