@isTest
private class FCHK_Cls_AddCampMemberAutomation_Test {
    public Set<String> offlineRecruitSourceSet = new Set<String>{'Frisomum' ,'Hotline','Event','Mall Event'};
     static testMethod void addNewMemberWelcomeOfflineMsgS40() {
       
       
       List<Campaign> cmpLst = new List<Campaign>();  
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message-Offline w/o email S-40'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
         
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
      
         Account actObj= new Account();
            actObj.FirstName = 'Test';
            actObj.LastName = 'Test';
            actObj.FCHK_Active__c=true;
            actObj.PersonMobilePhone = '59952043';
            actObj.PersonHomePhone = '45500541';
            actObj.Recruitment_Source__c ='Hotline';
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-42);
           insert actObj; 
           accList.add(actObj);
        
           
       List<Account> accQuery=[SELECT Id,Name,PersonContactId FROM Account where PersonMobilePhone='59952043'];     
                      
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
       
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
     }
     
     
      static testmethod void addNewMemberWelcomeOfflineMsgS50(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message-Offline w/o email S-50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
            
         Account actObj = new Account();
            actObj.FirstName = 'Test';
            actObj.LastName = 'Test';
            actObj.PersonMobilePhone = '57852045';
            actObj.PersonHomePhone = '45000596';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.Recruitment_Source__c ='Hotline';
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-52); 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
          Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }

    static testmethod void addNewMemberWelcomeOfflineMsgS60(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message-Offline w/o email S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
           
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '57852345';
            actObj.PersonHomePhone = '49000546';
             actObj.Recruitment_Source__c ='Hotline';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
    static testmethod void addNewMemberWelcomeOfflineMsgSAll(){
              
      Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message-Offline w/o email for ALL'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       insert cmpObj;               
        
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
           Account Acc2 = new Account();
            Acc2.FirstName = 'Test1';
            Acc2.LastName = 'Test1';
            Acc2.PersonMobilePhone = '57852345';
            Acc2.PersonHomePhone = '49000546';
            Acc2.FCHK_Active__c=true;
            Acc2.OpCo__c='HK';
            Acc2.FCHK_Reject_SMS__c=false;
            Acc2.Recruitment_Source__c ='Hotline';
            Acc2.recordTypeId = recordTypeIds;
            Acc2.PersonBirthdate = System.today().addYears(-62);
            accList.add(Acc2);
            insert accList;
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
    
    static testmethod void addNewMemberWelcomeOfflineMsgE40(){
   
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message - Offline with email S-40'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
          
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Hotline';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-42);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
     static testmethod void addNewMemberWelcomeOfflineMsgE50(){
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
      Campaign cmpObj = new Campaign();  
      cmpObj.Name = 'New Member welcome message - Offline with email S-50'; 
      cmpObj.Status = 'In Progress';
      cmpObj.IsActive = true;
      cmpObj.Type = 'Email';
      cmpLst.add(cmpObj);
      insert cmpLst;               
                     
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Hotline';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-52);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
    static testmethod void addNewMemberWelcomeMsgOfflineE60(){
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message - Offline with email S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
                  
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Hotline';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      
      static testmethod void addNewMemberWelcomeMsgOfflineEAll(){
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message - Offline with email for ALL'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Hotline';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      static testmethod void addNewMemberWelcomeMsgOnlineE40(){
       
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message - Online with email S-40'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Website';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-42);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void addNewMemberWelcomeMsgOnlineE50(){
       
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message - Online with email S-50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Website';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-52);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void addNewMemberWelcomeMsgOnlineE60(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message - Online with email S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Website';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void addNewMemberWelcomeMsgOnlineEAll(){
       
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'New Member welcome message - Online with email for ALL'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
      
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.Recruitment_Source__c ='Website';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);  
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void birthdayGreetingSMS40(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Birthday-SMS-S-40'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1972, 9, 9);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '56908745';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void birthdayGreetingSMS50(){
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Birthday-SMS-S-50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
      
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1960, 9, 9);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '56908745';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
             Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      
       static testmethod void birthdayGreetingSMS60(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Birthday-SMS-S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1952, 9, 9);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '56908745';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      static testmethod void birthdayGreetingeDM40(){
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Birthday-eDM-S-40'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1972, 9, 9);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      
      static testmethod void birthdayGreetingeDM50(){
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Birthday-eDM-S-50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1960, 9, 9);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void birthdayGreetingeDM60(){
        
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Birthday-eDM-S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1952, 9, 9);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void birthdayGreetingOfferTransitionSMS50(){
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Transition-SMS-Turning 50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1965, 9, 1);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '56756756';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void birthdayGreetingOfferTransitioneDM50(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Transition-eDM-Turning 50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1965, 9, 1);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void birthdayGreetingOfferTransitioneDM60(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Transition-eDM-Turning 60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1955, 9, 1);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       
       static testmethod void birthdayGreetingOfferTransitionSMS60(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Birthday Greeting and Offer-Transition-SMS-Turning 60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
        Date BDate = date.newinstance(1955, 9, 1);
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '57675677';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = BDate; 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void memberRegularCommunicationS50(){
        List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Member Regular Communication S-50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
                   
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-52); 
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void memberRegularCommunicationS60(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'Member Regular Communication S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
       
            
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
        static testmethod void firstPurchaseOfferSMS40(){
           // Create an instance of query locator
        Database.QueryLocator QL;
        // Create an instance of batchable context
        Database.BatchableContext BC;
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'First Purchase Offer-SMS-S-40'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
                    
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '57675677';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-42);
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      
       static testmethod void firstPurchaseOfferSMS50(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'First Purchase Offer-SMS-S-50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
       
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
                    
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '57675677';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-52);
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
       static testmethod void firstPurchaseOfferSMS60(){
      
      
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'First Purchase Offer-SMS-S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'SMS';
       cmpLst.add(cmpObj);
       insert cmpLst;               
      
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
                    
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonMobilePhone = '57675677';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.FCHK_Reject_SMS__c=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      
      static testmethod void firstPurchaseOffereDM40(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
        Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'First Purchase Offer-eDM-S-40'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
            
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
                    
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-42);
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      static testmethod void firstPurchaseOffereDM50(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'First Purchase Offer-eDM-S-50'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
        
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
                    
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-52);
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      
      static testmethod void firstPurchaseOffereDM60(){
       List<Campaign> cmpLst = new List<Campaign>();  
       
       
       Campaign cmpObj = new Campaign();  
       cmpObj.Name = 'First Purchase Offer-eDM-S-60'; 
       cmpObj.Status = 'In Progress';
       cmpObj.IsActive = true;
       cmpObj.Type = 'Email';
       cmpLst.add(cmpObj);
       insert cmpLst;               
      
        List<Account> accList = new List<Account>();
        Schema.DescribeSObjectResult resSchema = Account.sObjectType.getDescribe();
        //getting all Recordtype  Account
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        //Getting Business Record Type Id
        Id recordTypeIds = recordTypeInfo.get('Optimel Record').getRecordTypeId();
        
                    
          Account actObj = new Account();
            actObj.FirstName = 'Test1';
            actObj.LastName = 'Test1';
            actObj.PersonEmail = 'Testemail3@method.com';
            actObj.PersonHomePhone = '49000546';
            actObj.FCHK_Active__c=true;
            actObj.OpCo__c='HK';
            actObj.PersonHasOptedOutOfEmail=false;
            actObj.recordTypeId = recordTypeIds;
            actObj.PersonBirthdate = System.today().addYears(-62);
            accList.add(actObj);
            insert accList; 
                  
        FCHK_Cls_AddCampaignMemberAutomationcls addCmp=new FCHK_Cls_AddCampaignMemberAutomationcls();
            Test.startTest();
         // initiate execute method
            Id batchprocessid = Database.executeBatch(addCmp, 1);
            Test.stopTest();
        
      }
      
      
      
      

   
}