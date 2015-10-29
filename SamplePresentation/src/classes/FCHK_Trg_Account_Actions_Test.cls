@isTest
public class FCHK_Trg_Account_Actions_Test {

    static testmethod void checkDuplicateRecordOnInsert(){
    
    Test.startTest();
    
    
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail3@method.com';
        Acc.PersonMobilePhone = '57852045';
        Acc.PersonHomePhone = '45000546';
        Acc.recordTypeId = recordTypeIds;
        acc.PersonBirthdate = System.today().addYears(-10);
        try {
                insert Acc;
            } catch (Exception e) {
                //system.assertEquals('You can\'t insert this record!', e.getMessage());
            }
        
        Account Acc1 = new Account();
        Acc1.FirstName = 'Test1';
        Acc1.LastName = 'Test1';
        Acc1.PersonEmail = 'Testemail3@method.com';
        Acc1.PersonMobilePhone = '57852045';
        Acc1.PersonHomePhone = '45000546';
        Acc1.recordTypeId = recordTypeIds;
        Acc1.PersonBirthdate = System.today().addYears(-10);
        
        try {
                insert Acc1;               
            } catch (Exception e) {
                //system.assertEquals('You can\'t update this record!', e.getMessage());
            }
        
        /*Account Acc2 = new Account();
         
        Acc2.FirstName = 'Test2';
        Acc2.LastName = 'Test2';
        Acc2.PersonEmail = 'Testemail1@method.com';
        Acc2.PersonMobilePhone = '57807422';
        Acc2.PersonHomePhone = '47854000';
        Acc2.recordTypeId = recordTypeIds;
        try {
                insert Acc2;
                update Acc2;
            } catch (Exception e) {
                system.assertEquals('You can\'t update this record!', e.getMessage());
            }*/
        
        /*Account Acc3 = new Account();
        Acc3.FirstName = 'Test3';
        Acc3.LastName = 'Test3';
        Acc3.PersonEmail = 'Testemail12@method.com';
        Acc3.PersonMobilePhone = '57000245';
        Acc3.PersonHomePhone = '42222206';
        Acc3.recordTypeId = recordTypeIds;
        try {
                insert Acc3;
                update Acc3;
            } catch (Exception e) {
                system.assertEquals('You can\'t update this record!', e.getMessage());
            }
        
        Account Acc4 = new Account();
        Acc4.FirstName = 'Test4';
        Acc4.LastName = 'Test4';
        Acc4.PersonEmail = 'Testemail100@method.com';
        Acc4.PersonMobilePhone = '57852205';
        Acc4.PersonHomePhone = '45700546';
        Acc4.recordTypeId = recordTypeIds;
        try {
                insert Acc4;
                update Acc4;
            } catch (Exception e) {
                system.assertEquals('You can\'t update this record!', e.getMessage());
            }
            */
            
         
        
       Test.stopTest(); 
    }
    static testmethod void checkDuplicateRecordOnupdate(){
    
    Test.startTest();
    
    
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail13@method.com';
        Acc.PersonMobilePhone = '57852066';
        Acc.PersonHomePhone = '45000566';
        Acc.recordTypeId = recordTypeIds;
        Acc.PersonBirthdate = System.today().addYears(-10);
        try {
                insert Acc;
            } catch (Exception e) {
                //system.assertEquals('You can\'t insert this record!', e.getMessage());
            } 
         Account acc1 = new Account();
         acc1.FirstName = 'Test';
         acc1.LastName = 'Test';
         acc1.PersonEmail = 'Testemail1056@method.com';
         acc1.PersonMobilePhone = '57852000';
         acc1.PersonHomePhone = '45000000';
         acc1.recordTypeId = recordTypeIds;
         acc1.PersonBirthdate = System.today().addYears(-10);
         try{
	         insert acc1;  
	         acc1.PersonEmail = 'Testemail13@method.com';
	         acc1.PersonMobilePhone = '57852066';
	         acc1.PersonHomePhone = '45000566';
             acc1.PersonBirthdate = System.today().addYears(-9);
	         update acc1;	       
         }
         catch(Exception e){
         	
         }
       Test.stopTest(); 
    }
}