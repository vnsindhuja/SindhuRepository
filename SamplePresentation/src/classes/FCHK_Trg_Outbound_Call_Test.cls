@isTest(SeeAllData=true)
public class FCHK_Trg_Outbound_Call_Test{

    static testmethod void createOrderOptimelGold(){
    
    
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        
        Campaign campobj = new Campaign();
        campobj.type='SMS';
        campobj.name='Test1';
        campobj.FCHK_Sample__c = 'Optimel Gold';
        
        Insert campobj;
        
        Test.startTest();
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj.id;
        cmember.contactid = contobj.id;
        cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'No Response';
        cmember.FCHK_Sample_Product__c='Optimel Gold';
       
        Insert cmember;
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
        update cmember;
        Test.stopTest(); 
}
    
    static testmethod void createOrderOptimelSilver(){
    
    
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        
        Campaign campobj = new Campaign();
        campobj.type='SMS';
        campobj.name='Test1';
         campobj.FCHK_Sample__c = 'Optimel Silver';
        
        Insert campobj;
        
       Test.startTest();
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj.id;
        cmember.contactid = contobj.id;
        cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'No Response';
        cmember.FCHK_Sample_Product__c='Optimel Silver';
       
        Insert cmember;
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
        update cmember;
        Test.stopTest(); 
}
    
    static testmethod void createOrderOptimelDiamond(){
    
    
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        
        Campaign campobj = new Campaign();
        campobj.type='SMS';
        campobj.name='Test1';
        campobj.FCHK_Sample__c = 'Optimel Diamond';
        
        Insert campobj;
        
        
        Test.startTest();
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj.id;
        cmember.contactid = contobj.id;
        cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'No Response';
        cmember.FCHK_Sample_Product__c='Optimel Diamond';
        Insert cmember;
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
        update cmember;
        Test.stopTest();
}
    
     static testmethod void createOutBoundCallOptimelGold(){
    
    
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11118888';
        actobj.PersonEmail = 'abceeeee@gmail.com';
        actobj.PersonMobilePhone = '56897999';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        
        Campaign campobj = new Campaign();
        campobj.type='SMS';
        campobj.name='Test1';
         campobj.FCHK_Sample__c = 'Optimel Gold';
        
        Insert campobj;
        
        
        Test.startTest();
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj.id;
        cmember.contactid = contobj.id;
        cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
       cmember.FCHK_Sample_Product__c='Optimel Gold';
        Insert cmember;
        cmember.FCHK_CM_Status__c = 'No Response';
        update cmember;
        Test.stopTest(); 
}
    
     static testmethod void createOutBoundCallOptimelSilver(){
    
    
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11118888';
        actobj.PersonEmail = 'abceeeee@gmail.com';
        actobj.PersonMobilePhone = '56897999';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        
        Campaign campobj = new Campaign();
        campobj.type='SMS';
        campobj.name='Test1';
         campobj.FCHK_Sample__c = 'Optimel Silver';
        
        Insert campobj;
        
        
        Test.startTest();
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj.id;
        cmember.contactid = contobj.id;
        cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
       cmember.FCHK_Sample_Product__c='Optimel Silver';
        Insert cmember;
        cmember.FCHK_CM_Status__c = 'No Response';
        update cmember;
        Test.stopTest(); 
}

    
     static testmethod void createOutBoundCallOptimelDiamond(){
    

        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();

        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11118888';
        actobj.PersonEmail = 'abceeeee@gmail.com';
        actobj.PersonMobilePhone = '56897999';
        actobj.recordTypeId = recordTypeIds;
        Insert actobj;
        
        Contact contobj=[Select id from Contact where accountid=:actobj.id];
        
        
        Campaign campobj = new Campaign();
        campobj.type='SMS';
        campobj.name='Test1';
         campobj.FCHK_Sample__c = 'Optimel Diamond';
        
        Insert campobj;
        
        
        Test.startTest();
        CampaignMember cmember = new CampaignMember();
        
        cmember.campaignid = campobj.id;
        cmember.contactid = contobj.id;
        cmember.status ='Selected';
        cmember.FCHK_CM_Status__c = 'Sample Accepted';
       cmember.FCHK_Sample_Product__c='Optimel Diamond';
        Insert cmember;
        cmember.FCHK_CM_Status__c = 'No Response';
        update cmember;
        Test.stopTest(); 
}

    

}