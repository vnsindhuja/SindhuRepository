@isTest
private class FCHK_class_MemberSearchctrl_Test {

    static testMethod void insertMembersearch() {
        // TO DO: implement unit test
         Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
           FCHK_class_MemberSearchctrl memberSearch= new FCHK_class_MemberSearchctrl();
            Account actObj= new Account();
            actObj.FirstName = 'Test';
            actObj.LastName = 'Test';
            actObj.FCHK_Active__c=true;
            actObj.PersonMobilePhone = '59952043';
            actObj.PersonHomePhone = '45500541';
            actObj.Recruitment_Source__c ='Hotline';
            actObj.PersonEmail = 'test@test105.com';
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-42);
            Test.startTest();
            memberSearch.conObj.LastName='Test104';
            memberSearch.actObj.PersonEmail='test106@test.com';
            memberSearch.actObj.PersonMobilePhone = '59952046';
            memberSearch.actObj.PersonHomePhone = '45500547';
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail='test106@test.com';
            memberSearch.actObj.PersonMobilePhone = '59952046';
            memberSearch.actObj.PersonHomePhone = null;
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail='test106@test.com';
            memberSearch.actObj.PersonMobilePhone = null;
            memberSearch.actObj.PersonHomePhone = '45500547';
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail='test106@test.com';
            memberSearch.actObj.PersonMobilePhone = null;
            memberSearch.actObj.PersonHomePhone = null;
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail='test106@test.com';
            memberSearch.actObj.PersonMobilePhone = null;
            memberSearch.actObj.PersonHomePhone = null;
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail=null;
            memberSearch.actObj.PersonMobilePhone = '59952046';
            memberSearch.actObj.PersonHomePhone = '45500547';
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail=null;
            memberSearch.actObj.PersonMobilePhone = null;
            memberSearch.actObj.PersonHomePhone = '45500547';
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail=null;
            memberSearch.actObj.PersonMobilePhone = '59952046';
            memberSearch.actObj.PersonHomePhone = null;
            memberSearch.searchRecords();
            memberSearch.actObj.PersonEmail=null;
            memberSearch.actObj.PersonMobilePhone = null;
            memberSearch.actObj.PersonHomePhone = null;
            memberSearch.searchRecords();
            //insert actObj; 
            
            Test.stopTest();
    }
    
    static testMethod void updateMembersearch() {
        // TO DO: implement unit test
         Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
      
         Account actObj= new Account();
            actObj.FirstName = 'Test';
            actObj.LastName = 'Test';
            actObj.FCHK_Active__c = true;
            actObj.personEmail = 'test@test.com';
            actObj.PersonMobilePhone = '59952043';
            actObj.PersonHomePhone = '45500541';
            actObj.Recruitment_Source__c ='Hotline';
            actObj.OpCo__c='HK';
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-42);
            insert actObj;
            
            List<Account> actObjectList = [Select Name,FirstName,LastName,PersonEmail,PersonHomePhone,PersonMobilePhone,
                                PersonBirthdate,Recruitment_Source__c,FCHK_Referred_By__c from Account where id 
                                =:actObj.id and personMobilePhone =:actobj.personMobilePhone];
            
            if(actObjectList !=null){
               actObj.lastName='Uttam';
               actObj.personEmail = 'test@test.com';
               update actObj;
            }
            
           Test.startTest();
           
            FCHK_class_MemberSearchctrl memberSearch= new FCHK_class_MemberSearchctrl();
            memberSearch.conObj.LastName='Test';
            memberSearch.actObj.PersonEmail='test@test.com';
            memberSearch.actObj.PersonMobilePhone = '59952043';
            memberSearch.actObj.PersonHomePhone = '45500541';
            
            memberSearch.searchRecords();
          
            Test.stopTest();
            
    }
    
}