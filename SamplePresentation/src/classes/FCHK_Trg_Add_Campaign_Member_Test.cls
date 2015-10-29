@isTest
public class FCHK_Trg_Add_Campaign_Member_Test{

    static testmethod void insertToCampaign(){
    
    
    
         List<Campaign> CmpLst = new List<Campaign>();  
       Campaign Cmp = new Campaign();  
       Cmp.Name = 'Referral eDM'; 
       Cmp.Status = 'In Progress';
       Cmp.IsActive = true;
       CmpLst.add(Cmp);
       Campaign Cmp1 = new Campaign();  
       Cmp1.Name = 'Referral SMS'; 
       Cmp1.Status = 'In Progress';
       Cmp1.IsActive = true;
       CmpLst.add(Cmp1);
       try {
                insert CmpLst;               
            } catch (Exception e) {
                //system.assertEquals('You can\'t update this record!', e.getMessage());
            }
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actObj=new Account();
        actObj.FirstName = 'Test22';
        actObj.LastName = 'Test22';
        actObj.PersonEmail = 'Testempail3@method.com';
        actObj.PersonMobilePhone = '59452045';
        actObj.Recruitment_Source__c = 'Hotline';
        actObj.recordTypeId = recordTypeIds;
        
        insert actObj;
        
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.FCHK_Referral_Count__c=1;
        Acc.PersonEmail = 'Testemail3@method.com';
        Acc.PersonMobilePhone = '59952045';
        Acc.PersonHomePhone = '45500546';
        Acc.Recruitment_Source__c = 'Staff Referral';
        Acc.PersonHasOptedOutOfEmail=false;
        Acc.FCHK_Referred_By__c = actObj.Id;
        Acc.recordTypeId = recordTypeIds;
        Test.startTest();
        insert Acc;
        Test.stopTest();      
        
      /*  Account Acc1 = new Account();
        Acc1.FirstName = 'Test1';
        Acc1.LastName = 'Test1';
        Acc1.PersonEmail = 'Testemail3@method.com';
        Acc1.PersonMobilePhone = '59952045';
        Acc1.PersonHomePhone = '45500546';
        Acc1.Recruitment_Source__c = 'Member Referral';
        Acc1.recordTypeId = recordTypeIds;
        acc1.FCHK_Referred_By__c = Acc.Id;
        insert Acc1;   */            
      
      
    }
    static testmethod void updateToCampaign(){
    
   
    
         List<Campaign> CmpLst = new List<Campaign>();  
       Campaign Cmp = new Campaign();  
       Cmp.Name = 'Referral eDM'; 
       Cmp.Status = 'In Progress';
       Cmp.IsActive = true;
       Cmp.Type = 'Email';
       CmpLst.add(Cmp);
       
       Campaign Cmp1 = new Campaign();  
       Cmp1.Name = 'Referral SMS'; 
       Cmp1.Status = 'In Progress';
       Cmp1.IsActive = true;
       Cmp.Type = 'SMS';
       CmpLst.add(Cmp1);
       try {
                insert CmpLst;               
            } catch (Exception e) {
                //system.assertEquals('You can\'t update this record!', e.getMessage());
            }   
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail13@method.com';
        Acc.PersonMobilePhone = '59952045';
        Acc.PersonHomePhone = '45500546';
        Acc.Recruitment_Source__c = 'Hotline';
        Acc.recordTypeId = recordTypeIds;
        insert Acc;
          
         Account acc1 = new Account();
         acc1.FirstName = 'Test';
         acc1.LastName = 'Test';
         acc1.FCHK_Referred_By__c = Acc.Id;
         acc1.PersonMobilePhone = '57852000';
         acc1.PersonHomePhone = '45000000';
         acc1.Recruitment_Source__c = 'Staff Referral';
         acc1.recordTypeId = recordTypeIds;
         
           insert acc1;  
           
           acc1.PersonMobilePhone = '57852066';
           acc1.PersonHomePhone = '45000566';
           Test.startTest();
           update acc1;   
        
           Test.stopTest(); 
    }
}