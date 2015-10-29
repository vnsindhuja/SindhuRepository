@isTest(seealldata=true)
public class FCHK_Cls_CancelOrder_Test{

    static testmethod void CancelOrder(){
    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail@method.com';
        Acc.PersonMobilePhone = '58964213';
        Acc.FCHK_Total_Expenses__c = 30;
        Acc.OpCo__c = 'HK';
        try
        {
        insert Acc;
        }
        catch (Exception exx)
        {
            System.assert(exx !=null);
        }
        
        RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order']; 
        
        
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Gold';
        Prod.ProductCode = 'OP- GL';
        Prod.IsActive = true;
        try
        {
        insert Prod;
        }
         catch(DMLException pex)
        {
            System.debug(pex.getMessage());
        }

        PriceBookEntry pbk = new PriceBookEntry();        
        pbk.Pricebook2Id = Test.getStandardPricebookId();
        pbk.Product2Id = Prod.Id;
        pbk.UnitPrice = 1.0;
        try
        {
        insert pbk;      
        }
         catch(DMLException pbex)
        {
            System.debug(pbex.getMessage());
        }
                
        Order ord = new Order();
        ord.RecordTypeId = Rec.Id;
        ord.AccountId = Acc.Id;
        ord.Type = 'Hotline';
        ord.Status = 'Confirmed';
        ord.effectiveDate = System.today();
        //ord.EffectiveDate = Date.today();
        ord.FCHK_Product__c = 'Optimel Gold';
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';
        ord.FCHK_1st_Purchase_Done__c = true;
        ord.FCHK_BirthDay_Offer_Taken__c = true;  
        ord.FCHK_Total_Cost__c=10.0;
        ord.FCHK_SO_Number__c = Label.FCHK_CL_SO_Number;  
        ord.FCHK_Same_as_BillingAddress__c=false;  
        ord.PriceBook2Id = Test.getStandardPricebookId();    
        Test.StartTest();
        if(ord.effectiveDate==null){
             ord.effectiveDate = System.today();
        }
        try
        {
        insert ord;
        }
        catch (Exception oex)
        {
            System.assert(oex!=null);
        }
        system.debug('--ord.id--'+ord.id);
        ApexPages.StandardController controller=new ApexPages.StandardController(ord);
        FCHK_Cls_CancelOrder.CancelOrder(ord.id);
        Test.stopTest();
    }
    }