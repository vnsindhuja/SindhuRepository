@isTest(SeeAllData=true)
public class FCHK_Trg_Lead_Status_Test {
	
	static testmethod void leadStatusUnitTest(){
        List<Campaign> campaignList = new List<Campaign>();
        Campaign campaignObj = new Campaign();
        campaignObj.Name = 'Sample Invitation OB Call eDM Warm';
        campaignObj.Type = 'Email';
        campaignList.add(campaignObj);
        Campaign campaignObj1 = new Campaign();
        campaignObj1.Name = 'Sample Invitation OB Call SMS Warm';
        campaignObj1.Type = 'SMS';
        campaignList.add(campaignObj1);
        Campaign campaignObj2 = new Campaign();
        campaignObj2.Name = 'First Purchase Request eDM Hot';
        campaignObj2.Type = 'Email';
        campaignList.add(campaignObj2);
        Campaign campaignObj3 = new Campaign();
        campaignObj3.Name = 'First Purchase Request SMS Hot';
        campaignObj3.Type = 'SMS';
        campaignList.add(campaignObj3);
        insert campaignList;
        
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Cold';
        actobj.FCHK_Optimel_Gold_Sample_Creation__c=false;
        actobj.FCHK_Optimel_Silver_Sample_Creation__c=false;
        actobj.FCHK_Optimel_Diamond_Sample_Creation__c=false;
        actobj.FCHK_Member_Creation__c=false;
        actobj.FCHK_Optimel_Diamond_21_days__c=false;
        actobj.FCHK_Optimel_Gold_21_days__c=false;
        actobj.FCHK_Optimel_Silver_21_days__c=false;
        
        insert actobj;
        Test.startTest();
        actobj.FCHK_Optimel_Gold_Sample_Creation__c=true;
        actobj.FCHK_Optimel_Silver_Sample_Creation__c=true;
        actobj.FCHK_Optimel_Diamond_Sample_Creation__c=true;
        actobj.FCHK_Member_Creation__c=true;
        actobj.FCHK_Optimel_Diamond_21_days__c=true;
        actobj.FCHK_Optimel_Gold_21_days__c=true;
        actobj.FCHK_Optimel_Silver_21_days__c=true;
        actobj.FCHK_Member_Status__c='Hot';
        update actObj;
        Test.stopTest();
    }
	
	static testmethod void leadStatusUnitTest1(){
		FCHK_Cls_CheckRecursive.flag=false;
        List<Campaign> campaignList = new List<Campaign>();
        Campaign campaignObj = new Campaign();
        campaignObj.Name = 'Sample Invitation OB Call eDM Warm';
        campaignObj.Type = 'Email';
        campaignList.add(campaignObj);
        Campaign campaignObj1 = new Campaign();
        campaignObj1.Name = 'Sample Invitation OB Call SMS Warm';
        campaignObj1.Type = 'SMS';
        campaignList.add(campaignObj1);
        Campaign campaignObj2 = new Campaign();
        campaignObj2.Name = 'First Purchase Request eDM Hot';
        campaignObj2.Type = 'Email';
        campaignList.add(campaignObj2);
        Campaign campaignObj3 = new Campaign();
        campaignObj3.Name = 'First Purchase Request SMS Hot';
        campaignObj3.Type = 'SMS';
        campaignList.add(campaignObj3);
        insert campaignList;
        
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Cold';
        actObj.FCHK_1st_Purchase_Done__c = false;
        insert actobj;
         Product2 Prod = new Product2();
        Prod.Name = 'Optimel Gold';
        Prod.ProductCode = 'OP- GL';
        Prod.IsActive = true;            
        insert Prod;           
        PriceBookEntry pbk = new PriceBookEntry();        
        pbk.Pricebook2Id = Test.getStandardPricebookId();
        pbk.Product2Id = Prod.Id;
        pbk.UnitPrice = 1.0;            
        insert pbk;
        List<RecordType> Rec = [select id,name from RecordType where DeveloperName='FCHK_RT_Sample_Request' and SOBjectType='Order'];            
        Order ord = new Order();
        if(Rec!=null && Rec.size()>0)
        ord.RecordTypeId = Rec[0].Id;
        ord.AccountId = actobj.Id; 
        ord.Type = 'Hotline';
        ord.Status = 'In Progress';
        ord.EffectiveDate = Date.Today();              
        Ord.Pricebook2Id = Test.getStandardPricebookId();   
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong'; 
        ord.FCHK_Total_Cost__c = 100;   
        ord.FCHK_Product__c  = 'Optimel Gold';
        insert ord;
        OrderItem OrdItem = new OrderItem();
        OrdItem.OrderId = ord.Id;            
        OrdItem.PricebookentryId = Pbk.Id;
        //OrdItem.Pricebookentry.Product2.id = Prod.Id;
        OrdItem.Quantity = 5;
        OrdItem.UnitPrice = 180;
        insert OrdItem;
        Test.startTest();
        actobj.FCHK_Member_Status__c='Hot';
        actobj.FCHK_Optimel_Gold_Sample_Creation__c=true;
        actobj.FCHK_Optimel_Silver_Sample_Creation__c=true;
        actobj.FCHK_Optimel_Diamond_Sample_Creation__c=true;
        actobj.FCHK_Member_Creation__c=true;
        update actObj;
        Test.stopTest();
    }
    /* 
  static testmethod void leadStatusWarmEmail(){
  	 List<Campaign> campaignList = new List<Campaign>();
  		 Campaign campaignObj = new Campaign();
        campaignObj.Name = 'Sample Invitation OB Call eDM Warm';
        campaignObj.Type = 'Email';
        campaignList.add(campaignObj);
        Campaign campaignObj1 = new Campaign();
        campaignObj1.Name = 'Sample Invitation OB Call SMS Warm';
        campaignObj1.Type = 'SMS';
        campaignList.add(campaignObj1);
        Campaign campaignObj2 = new Campaign();
        campaignObj2.Name = 'First Purchase Request eDM Hot';
        campaignObj2.Type = 'Email';
        campaignList.add(campaignObj2);
        Campaign campaignObj3 = new Campaign();
        campaignObj3.Name = 'First Purchase Request SMS Hot';
        campaignObj3.Type = 'SMS';
        campaignList.add(campaignObj3);
        insert campaignList;
        
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        actobj.PersonEmail = 'abcssssss@gmail.com';
        //actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Warm';
        insert actobj;
    }
     
    static testmethod void leadStatusWarmMobile(){
        
         Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        //actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Warm';
        insert actobj;
    }
    static testmethod void leadStatusWarmMobileEmail(){
        
         Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
       actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Warm';
        insert actobj;
    }
        
    
    static testmethod void leadStatusHotEmail(){
         Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        actobj.PersonEmail = 'abcssssss@gmail.com';
        //actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Hot';
        insert actobj;
        
    }
    static testmethod void leadStatusHotMobile(){
         Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
        //actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Hot';
        insert actobj;
        
    }
    static testmethod void leadStatusHotMobileEmail(){
         Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Account actobj = new Account();
        actobj.LastName = 'testwsd';
        actobj.firstname = 'sdfsd';
        actobj.PersonHomePhone = '11112222';
       	actobj.PersonEmail = 'abcssssss@gmail.com';
        actobj.PersonMobilePhone = '56897998';
        actobj.recordTypeId = recordTypeIds;
        actobj.FCHK_Member_Status__c='Hot';
        insert actobj;
        
    }
    */
    
}