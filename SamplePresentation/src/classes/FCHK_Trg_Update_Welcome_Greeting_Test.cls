@isTest(SeeAllData=true)
public class FCHK_Trg_Update_Welcome_Greeting_Test {

    static testmethod void updateWelcomeGreetingForSMS(){
    
       
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        
    
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11552000';
        actobj.PersonEmail = 'abcsdss@gmail.com';
        actobj.PersonMobilePhone = '56801068';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        System.debug('contobj@@:'+contobj.id);
        Campaign campobj = new Campaign();
        campobj.type='SMS';
        campobj.name='Test1';
        Insert campobj;
        
        
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj.id;
       cmember.contactid = contobj.id;
       
       cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'No Response';
        Insert cmember;
        System.debug('cmember@@:'+cmember);
        cmember.status ='Sent';
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
        update cmember;
        System.debug('cmember@@:'+cmember);
       
}

static testmethod void updateWelcomeGreetingForEmail(){
    
     Test.startTest();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11552000';
        actobj.PersonEmail = 'abcsdss@gmail.com';
        actobj.PersonMobilePhone = '56801068';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        Campaign campobj1 = new Campaign();
        campobj1.type='Email';
        campobj1.name='Test2';
        Insert campobj1;
        
       
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj1.id;
       cmember.contactid = contobj.id;
      
       cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'No Response';
        Insert cmember;
        cmember.status ='Sent';
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
        
        update cmember;
     Test.stopTest(); 
}
}