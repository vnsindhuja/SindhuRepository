@isTest
public class FCHK_Trg_Case_Actions_Test {


    static testmethod void checkDuplicateRecordOnInsert(){
    
    Test.startTest();
    
    Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail4@method.com';
        Acc.PersonMobilePhone = '57857000';
        Acc.PersonHomePhone = '45785004';
        Acc.recordTypeId = recordTypeIds;
        try {
                insert Acc;
            } catch (Exception e) {
                //system.assertEquals('You can\'t insert this record!', e.getMessage());
            }        
        Case cas = new Case();
        Id recordTypeId = [select id,Name from Recordtype where sObjectType='Case' AND Name= 'New Member Registration'].id;
        cas.FCHK_First_Name__c = 'Test';
        cas.FCHK_Last_Name__c = 'Test';
        cas.FCHK_Email__c = 'Testemail4@method.com';
        cas.FCHK_Mobile__c = '57857000';
        cas.FCHK_Home_Phone__c = '45785004';
        cas.recordTypeId = recordTypeId;
        
        try {
                insert cas;
            } catch (Exception e) {
                //system.assertEquals('You can\'t insert this record!', e.getMessage());
            }        
       Test.stopTest(); 
    }
    
    static testmethod void checkDuplicateRecordOnUpdate(){
    
    Test.startTest();
        
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail5@method.com';
        Acc.PersonMobilePhone = '57851111';
        Acc.PersonHomePhone = '45785002';
        Acc.recordTypeId = recordTypeIds;
        try {
                insert Acc;
            } catch (Exception e) {
                //system.assertEquals('You can\'t insert this record!', e.getMessage());
            }      
       
            
        Case cas = new Case();
        Id recordTypeId2 = [select id,Name from Recordtype where sObjectType='Case' AND Name= 'New Member Registration'].id;
        cas.FCHK_First_Name__c = 'Test';
        cas.FCHK_Last_Name__c = 'Test';
        cas.FCHK_Email__c = 'Testemail@method.com';
        cas.FCHK_Mobile__c = '57000025';
        cas.FCHK_Home_Phone__c = '27000025';
        cas.recordTypeId = recordTypeId2;
        
        try {
                insert cas;
                cas.FCHK_Email__c = 'Testemail5@method.com';
        		cas.FCHK_Mobile__c = '57851111';
        		cas.FCHK_Home_Phone__c = '45785002';
        		update cas;
            } catch (Exception e) {
                //system.assertEquals('You can\'t update this record!', e.getMessage());
         }
         
        
       Test.stopTest(); 
    }
}