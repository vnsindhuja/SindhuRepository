@istest
public class FCHK_Test_Order_Update_AnnualRev{
   
    static testmethod void Update_AnnualRev_Update(){
    	FCHK_Cls_CheckRecursive.flag=false;
       	 RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
         Account Acc = new Account(RecordTypeId=RecId.Id, 
                                      FirstName='Test Account',
                                      LastName = 'Test', 
                                      PersonMobilePhone = '52589546',
                                      OpCo__c = 'HK');           
            insert Acc;
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
            List<RecordType> Rec = [select id,name from RecordType where DeveloperName='FCHK_RT_Order' and SOBjectType='Order'];            
            Order ord = new Order();
            if(Rec!=null && Rec.size()>0)
            ord.RecordTypeId = Rec[0].Id;
            ord.AccountId = Acc.Id;
            ord.Type = 'Hotline';
            ord.Status = 'In Progress';
            ord.EffectiveDate = Date.Today();              
            Ord.Pricebook2Id = Test.getStandardPricebookId();   
            ord.FCHK_Street__c = 'XYZ';
            ord.FCHK_District__c = 'ABC City';
            ord.FCHK_Territory__c = 'Hong Kong'; 
            ord.FCHK_Total_Cost__c = 100;   
            insert ord;
            system.debug('--ord.id--'+ord.id);
            OrderItem OrdItem = new OrderItem();
            OrdItem.OrderId = ord.Id;            
            OrdItem.PricebookentryId = Pbk.Id;
            //OrdItem.Pricebookentry.Product2.id = Prod.Id;
            OrdItem.Quantity = 5;
            OrdItem.UnitPrice = 180;
            insert OrdItem;
            Test.startTest();
            ord.Status='Order Confirmed';     
            update ord;      
            Test.stopTest();       
           
    }
      static testmethod void Update_AnnualRev_Delete(){
       		FCHK_Cls_CheckRecursive.flag=false;
            RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
            //Account Acc = [SELECT Id FROM Account LIMIT 1];             
            Account Acc = new Account();
            Acc.RecordTypeId = RecId.Id;
            Acc.FirstName = 'Test Account';
            Acc.LastName = 'Test';
            Acc.PersonMobilePhone = '55224555';
            Acc.FCHK_Total_Expenses__c= 131;
            Acc.OpCo__c = 'HK';
            insert Acc;
            
            RecordType Rec = [select id,name from RecordType where developername='FCHK_RT_Order' and SOBjectType='Order'];      
            
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
            Order ord = new Order();
            ord.RecordTypeId = Rec.Id;
            ord.AccountId = Acc.Id;
            ord.Type = 'Hotline';
            ord.Status = 'In Progress';
            ord.EffectiveDate = Date.Today(); 
            Ord.Pricebook2Id = Test.getStandardPricebookId();   
            ord.FCHK_Street__c = 'XYZ';
            ord.FCHK_District__c = 'ABC City';
            ord.FCHK_Territory__c = 'Hong Kong';    
            insert ord;
            Order ord1 = new Order();
            ord1.RecordTypeId = Rec.Id;
            ord1.AccountId = Acc.Id;
            ord1.Type = 'Hotline';
            ord1.Status = 'In Progress';
            ord1.EffectiveDate = Date.Today(); 
            ord1.Pricebook2Id = Test.getStandardPricebookId();   
            ord1.FCHK_Street__c = 'XYZ';
            ord1.FCHK_District__c = 'ABC City';
            ord1.FCHK_Territory__c = 'Hong Kong';    
            insert ord1;
            OrderItem OrdItem1 = new OrderItem(OrderId = ord1.Id,
                                              PricebookentryId =pbk.Id,
                                             Quantity = 5,
                                             UnitPrice = 180);
            insert OrdItem1;
            ord1.status = 'Order Confirmed';
            update ord1;
            system.debug('--ord.id--'+ord.id);
            OrderItem OrdItem = new OrderItem(OrderId = ord.Id,
                                              PricebookentryId =pbk.Id,
                                             Quantity = 5,
                                             UnitPrice = 180);
            insert OrdItem;
            Test.startTest();
            delete ord;
            Test.stopTest();
    }
}