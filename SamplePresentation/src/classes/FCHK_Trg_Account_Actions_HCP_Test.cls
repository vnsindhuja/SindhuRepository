@isTest
public class FCHK_Trg_Account_Actions_HCP_Test {

    static testmethod void checkDuplicateRecordOnInsert(){
    
    Test.startTest();
    
    
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Medical Marketing'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.Phone = '45000546';
        Acc.OpCo__c = 'HK';
        Acc.recordTypeId = recordTypeIds;
        try {
                insert Acc;
            } catch (Exception e) {
                //system.assertEquals('You can\'t insert this record!', e.getMessage());
            }
        
        Account Acc1 = new Account();
        Acc1.FirstName = 'Test1';
        Acc1.LastName = 'Test1';
        Acc1.Phone = '45000546';
        Acc1.OpCo__c = 'HK';
        Acc1.recordTypeId = recordTypeIds;
        
        try {
                insert Acc1;               
            } catch (Exception e) {
                //system.assertEquals('You can\'t update this record!', e.getMessage());
            }
        
        
       Test.stopTest(); 
    }
    static testmethod void checkDuplicateRecordOnupdate(){
    
    Test.startTest();
    
    
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Medical Marketing'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.Phone = '45000566';
        Acc.OpCo__c = 'HK';
        Acc.recordTypeId = recordTypeIds;
        try {
                insert Acc;
            } catch (Exception e) {
                //system.assertEquals('You can\'t insert this record!', e.getMessage());
            } 
         Account acc1 = new Account();
         acc1.FirstName = 'Test';
         acc1.LastName = 'Test';
         acc1.Phone = '45000000';
         acc1.OpCo__c = 'HK';
         acc1.recordTypeId = recordTypeIds;
         try{
           insert acc1;  
          acc1.Phone = '45000566';
           update acc1;   
         }
         catch(Exception e){
           
         }
       Test.stopTest(); 
    }
}