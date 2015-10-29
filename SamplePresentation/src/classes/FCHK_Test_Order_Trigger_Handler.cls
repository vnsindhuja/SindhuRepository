@isTest(seealldata=true)
public class FCHK_Test_Order_Trigger_Handler{
    @IsTest
    static void  CopyShippingAddressTest()
    {
      RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];        
       RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order'];      
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account(RecordTypeId=RecId.Id, 
                                  FirstName='Test Account',
                                  LastName = 'Test', 
                                  PersonMobilePhone = '52589546',
                                  OpCo__c = 'HK');
        try
        {
        insert Acc;
        }
        catch(DMLException aex)
        {
            System.debug(aex.getMessage());
        }
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
        ord.EffectiveDate = Date.Today();
        ord.FCHK_Product__c = 'Optimel Gold';      
        ord.PriceBook2Id = Test.getStandardPricebookId();  
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';
        //Ord.Status='confirmed';
        //Ord.FCHK_Shipping_Address__c ='MyHome';
        ord.FCHK_Same_as_BillingAddress__c=true;
        try
        {
        insert ord;
        }
         catch(DMLException oex)
        {
            System.debug(oex.getMessage());
        }
        List<Order> ordlist = new List<Order> ();
        ordlist.add(ord);
        //moving all tests to end.
        
       
         Order ord1 = new Order();
        ord1.RecordTypeId = Rec.Id;
        ord1.AccountId = Acc.Id;
        ord1.Type = 'Hotline';
        ord1.Status = 'Confirmed';
        ord1.EffectiveDate = Date.Today();
        ord1.FCHK_Product__c = 'Optimel Gold';      
        ord1.PriceBook2Id = Test.getStandardPricebookId();  
        ord1.FCHK_Street__c = 'XYZ';
        ord1.FCHK_District__c = 'ABC City';
        ord1.FCHK_Territory__c = 'Hong Kong';
        Ord1.Status='Confirmed';
        //Ord.FCHK_Shipping_Address__c ='MyHome';
        try
        {
        insert ord1;
        }
         catch(DMLException oex1)
        {
            System.debug(oex1.getMessage());
        }
        List<Order> ordlist1 = new List<Order> ();
        ordlist1.add(ord1);
        //FCHK_Cls_Order_Trigger_Handler.CopyShippingAddress(ordlist1,true);
        
        /*FCHK_Cls_Order_Trigger_Handler.Update_SO_Number(ordlist);
        FCHK_Cls_Order_Trigger_Handler.UpdateAcc_OrderDelete(ordlist);
        FCHK_Cls_Order_Trigger_Handler.CopyBillingToShipping(ordlist);
        FCHK_Cls_Order_Trigger_Handler.ChangeOrderPriceBook(ordlist);
            
        FCHK_Cls_Order_Trigger_Handler.AddSampleProducts(ordlist);
         User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        Holiday hol = new Holiday();
        System.runAs ( thisUser ) {
        
        hol.Name='Test holiday';
        hol.activitydate = System.Today().adddays(1);
            try{
            insert hol;
            }
            catch (DMLException ex1)
            {
                
            }
        system.debug('--Holiday--'+hol);
            Holiday hold = [select id,activitydate from Holiday where id=:hol.id];
        }
        
        FCHK_Cls_Order_Trigger_Handler.Calculate_Next_Holiday(ordlist);*/
    }
    static testmethod void CreateOrderProductGL(){    
        
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];        
        RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order'];      
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account(RecordTypeId=RecId.Id, FirstName='Test Account', LastName = 'Test', PersonMobilePhone = '52589546', OpCo__c = 'SG');
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
        
        Order ord = new Order();
        ord.RecordTypeId = Rec.Id;
        ord.AccountId = Acc.Id;
        ord.Type = 'Hotline';
        ord.Status = 'Confirmed';
        ord.EffectiveDate = Date.Today();
        ord.FCHK_Product__c = 'Optimel Gold';      
        ord.PriceBook2Id = Test.getStandardPricebookId();  
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';      
        insert ord;
        List<Order> ordlist = new List<Order> ();
        ordlist.add(ord);
        //FCHK_Cls_Order_Trigger_Handler.Update_SO_Number(ordlist);
          
        try {
                update ord;
            
                //FCHK_Cls_CheckRecursive.flag = true;
        } catch (Exception e) {
            system.assertEquals('You can\'t update this record!', e.getMessage());
        }  
        
        system.debug('--ord.id--'+ord.id);
    }
    static testmethod void CreateOrderProductGL_Else(){    
        
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];        
        RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order'];      
        //Account Acc = [SELECT Id FROM Account LIMIT 1];   
        Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
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
              
        Order ord = new Order();
        ord.RecordTypeId = Rec.Id;
        ord.AccountId = Acc.Id;
        ord.Type = 'Hotline';
        ord.Status = 'Confirmed';
        ord.EffectiveDate = Date.Today();
        ord.FCHK_Product__c = 'Optimel Gold';
        ord.PriceBook2Id = Test.getStandardPricebookId(); 
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';
        insert ord;
        
         
        try {
                update ord;
                FCHK_Cls_CheckRecursive.flag = false;
        } catch (Exception e) {
            system.assertEquals('You can\'t update this record!', e.getMessage());
        }  
        
        try {
                Order ord1 = [select id from Order where Id=:ord.id];
                delete ord1;
            } catch (Exception e) {
                system.assertEquals('You can\'t delete this record!', e.getMessage());
            }  
        system.debug('--ord.id--'+ord.id);
    }
    
    
    static testmethod void CreateOrderProductSL(){
    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];    
        //Account Acc = [SELECT Id FROM Account LIMIT 1];
        Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;
        
        RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order'];      
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Silver';
        Prod.ProductCode = 'OP- SL';
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
        ord.Status = 'Confirmed';
        ord.EffectiveDate = Date.Today();
        ord.FCHK_Product__c = 'Optimel Silver';
        ord.PriceBook2Id = Test.getStandardPricebookId();   
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';   
        insert ord;
        
          
        try {
                
                update ord;
               
        } catch (Exception e) {
            system.assertEquals('You can\'t update this record!', e.getMessage());
        }  
        
        system.debug('--ord.id--'+ord.id);
    }
     static testmethod void CreateOrderProductSL_Else(){
    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        //Account Acc = [SELECT Id FROM Account LIMIT 1];
        Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_Optimel_Silver_Sample__c = null;
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;       
        
        
        RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order'];      
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Silver';
        Prod.ProductCode = 'OP- SL';
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
        ord.Status = 'Confirmed';
        ord.EffectiveDate = Date.Today();
        ord.FCHK_Product__c = 'Optimel Silver';
        ord.PriceBook2Id = Test.getStandardPricebookId();
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';
        insert ord;
        
        
        try {
            Order updOrd = [select id from order where FCHK_Street__c = 'XYZ' limit 1];
                updOrd.FCHK_District__c = 'ABC City1';
                update updOrd;
                
        } catch (Exception e) {
            system.assertEquals('You can\'t update this record!', e.getMessage());
        }  
        
        try {
                Order ord1 = [select id from Order where Id=:ord.id];
                delete ord1;
            } catch (Exception e) {
                system.assertEquals('You can\'t delete this record!', e.getMessage());
            }  
        
        system.debug('--ord.id--'+ord.id);
    }
    static testmethod void CreateOrderProductDM(){
    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        //Account Acc = [SELECT Id FROM Account LIMIT 1];
         Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_Optimel_Diamond_Sample__c = null;
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;       
               
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Diamond';
        Prod.ProductCode = 'OP- DM';
        Prod.IsActive = true;
        insert Prod;
        
        PriceBookEntry pbk = new PriceBookEntry();        
        pbk.Pricebook2Id = Test.getStandardPricebookId();
        pbk.Product2Id = Prod.Id;
        pbk.UnitPrice = 1.0;
        insert pbk;
        
        RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order'];      
                           
        Order ord = new Order();
        ord.RecordTypeId = Rec.Id;
        ord.AccountId = Acc.Id;
        ord.Type = 'Hotline';
        ord.Status = 'Confirmed';
        ord.EffectiveDate = Date.Today();        
        ord.FCHK_Product__c = 'Optimel Diamond';
        ord.PriceBook2Id = Test.getStandardPricebookId();
        ord.FCHK_Billing_Address1__c = 'Address Line 1';
        ord.FCHK_Same_as_BillingAddress__c = true;        
        insert ord;
        
         
        try {
                update ord;
                //FCHK_Cls_CheckRecursive.flag = true;
        } catch (Exception e) {
            system.assertEquals('You can\'t update this record!', e.getMessage());
        }  
        
        try {
                Order ord1 = [select id from Order where Id=:ord.id];
                delete ord1;
            } catch (Exception e) {
                system.assertEquals('You can\'t delete this record!', e.getMessage());
            }  
    }
     static testmethod void CreateOrderProductDM_Else(){
    
        //Account Acc = [SELECT Id FROM Account LIMIT 1];
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_Optimel_Diamond_Sample__c = null;
        Acc.RecordTypeId = RecId.Id;
        Acc.OpCo__c = 'SG';
        insert Acc;       
        
        
        RecordType Rec = [select id,name from RecordType where name='Sample Request' and SOBjectType='Order'];      
         
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Diamond';
        Prod.ProductCode = 'OP- DM';
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
        ord.Status = 'Confirmed';
        ord.EffectiveDate = Date.Today();
        ord.PriceBook2Id = Test.getStandardPricebookId();
        ord.FCHK_Product__c = 'Optimel Diamond';
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';        
        ord.FCHK_Same_as_BillingAddress__c = true;        
        insert ord;
        
        
        try {
                update ord;
               
                //FCHK_Cls_CheckRecursive.flag = true;
        } catch (Exception e) {
            system.assertEquals('You can\'t update this record!', e.getMessage());
        }  
       
         try {
                
                delete ord;
                //FCHK_Cls_CheckRecursive.flag = true;
        } catch (Exception e) {
            system.assertEquals('You can\'t update this record!', e.getMessage());
        }   
        
        system.debug('--ord.id--'+ord.id);
    }
    
    
      static testmethod void Update_1PurchaseOrder(){
           
        //Account Acc = [SELECT Id FROM Account LIMIT 1];
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_1st_Purchase_Done__c=false;
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;       
        
        
        RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];      
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Silver';
        Prod.ProductCode = 'OP- SL';
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
        ord.FCHK_Offer_Type__c = 'First Purchase';
        ord.FCHK_Coupon_Type__c = 'Maxims';    
        ord.PriceBook2Id = Test.getStandardPricebookId();    
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';
        insert ord;
        
        OrderItem OrdItem = new OrderItem();
        OrdItem.OrderId = ord.Id;
        OrdItem.PricebookentryId = pbk.Id;
        //OrdItem.Pricebookentry.Product2.id = Prod.Id;
        OrdItem.Quantity = 5;
        OrdItem.UnitPrice = 180;
        insert OrdItem;
            
        //FCHK_Cls_CheckRecursive.flag = true;
        Order ord1 = [select id from Order where Id=:ord.id];
        try {
                ord.Status = 'Order Confirmed';
                update ord;
                
                //FCHK_Cls_CheckRecursive.flag = true;
            } catch (Exception e) {
                system.assertEquals('You can\'t delete this record!', e.getMessage());
            }         
        
        system.debug('--ord.id--'+ord.id);       
       
    }
    static testmethod void Update_BirthdaySurprise(){
           
        //Account Acc = [SELECT Id FROM Account LIMIT 1];
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_BirthDay_Offer_Taken__c=false;
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;       
        
        
        RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];      
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Silver';
        Prod.ProductCode = 'OP- SL';
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
        ord.FCHK_Offer_Type__c = 'Birthday Surprise';
        ord.FCHK_Coupon_Type__c = 'Maxims';    
        ord.PriceBook2Id = Test.getStandardPricebookId();    
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';
        insert ord;
        
        system.debug('--ord.id--'+ord.id);  
         
        OrderItem OrdItem = new OrderItem();
        OrdItem.OrderId = ord.Id;
        OrdItem.PricebookentryId = pbk.Id;
        //OrdItem.Pricebookentry.Product2.id = Prod.Id;
        OrdItem.Quantity = 5;
        OrdItem.UnitPrice = 180;
        insert OrdItem;
            
        //FCHK_Cls_CheckRecursive.flag = true;
        Order ord1 = [select id from Order where Id=:ord.id];
        try {
                ord.Status = 'Order Confirmed';
                update ord;
                
            } catch (Exception e) {
                system.assertEquals('You can\'t delete this record!', e.getMessage());
            }             
       
    }
    
     
     static testmethod void Update_ShippingAddress(){
           
        //Account Acc = [SELECT Id FROM Account where FCHK_Billing_Address__c != null LIMIT 1];
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        //Account Acc = [SELECT Id FROM Account LIMIT 1];
        Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_Block__c = '2';
        Acc.FCHK_Building__c = 'A';
        Acc.FCHK_Estate__c = 'Mah';
        Acc.FCHK_Flat__c = '204';
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;       
        
        
        RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];    
             
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Silver';
        Prod.ProductCode = 'OP- SL';
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
        ord.FCHK_Same_as_BillingAddress__c = true;  
        ord.FCHK_Billing_Address1__c = 'Address Line 1';
        ord.PriceBook2Id = Test.getStandardPricebookId();           
        insert ord;
        
        OrderItem OrdItem = new OrderItem();
        OrdItem.OrderId = ord.Id;
        OrdItem.PricebookentryId = pbk.Id;
        //OrdItem.Pricebookentry.Product2.id = Prod.Id;
        OrdItem.Quantity = 5;
        OrdItem.UnitPrice = 180;
        insert OrdItem;
            
        //FCHK_Cls_CheckRecursive.flag = true;
        Order ord1 = [select id from Order where Id=:ord.id];
        try {
                ord.Status = 'Order Confirmed';
                update ord;
        }
        catch (Exception e) {
                system.assertEquals('You can\'t delete this record!', e.getMessage());
            }   
        system.debug('--ord.id--'+ord.id);       
       
    }
     static testmethod void Update_ChineseAddress(){
     
         RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];  
        //Account Acc = [SELECT Id FROM Account where FCHK_Billing_Address__c != null LIMIT 1];
         Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_Block__c = '2';
        Acc.FCHK_Building__c = 'A';
        Acc.FCHK_Estate__c = 'Mah';
        Acc.FCHK_Flat__c = '204';
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;     
        
        RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];     
        Product2 Prod = new Product2();
        Prod.Name = 'Optimel Silver';
        Prod.ProductCode = 'OP- SL';
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
        ord.FCHK_Same_as_BillingAddress__c = true;     
        ord.FCHK_Chinese_Address__c = true;       
        ord.FCHK_Billing_Address1__c = 'Address Line 1';
        ord.PriceBook2Id = Test.getStandardPricebookId(); 
        insert ord;
        
        List<Order> ordlst = new List<order>();
        ordlst.add(ord);
        OrderItem OrdItem = new OrderItem();
        OrdItem.OrderId = ord.Id;
        OrdItem.PricebookentryId = pbk.Id;
        //OrdItem.Pricebookentry.Product2.id = Prod.Id;
        OrdItem.Quantity = 5;
        OrdItem.UnitPrice = 180;
        insert OrdItem;
            
        //FCHK_Cls_CheckRecursive.flag = true;
        Order ord1 = [select id from Order where Id=:ord.id];
        try {
                ord.Status = 'Order Confirmed';
                update ord;
        }
        catch (Exception e) {
                system.assertEquals('You can\'t delete this record!', e.getMessage());
            }   
        //FCHK_Cls_Order_Trigger_Handler.UpdateAcc_OrderDelete(ordlst);
        //FCHK_Cls_CheckRecursive.flag = false;
        system.debug('--ord.id--'+ord.id);       
       
    }
     static testmethod void Calculate_NextHoliday(){
           
        //Account Acc = [SELECT Id FROM Account where FCHK_Billing_Address__c != null LIMIT 1];
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
         Account Acc = new Account();
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.FCHK_Block__c = '2';
        Acc.FCHK_Building__c = 'A';
        Acc.FCHK_Estate__c = 'Mah';
        Acc.FCHK_Flat__c = '204';        
        Acc.OpCo__c = 'SG';
        Acc.RecordTypeId=RecId.Id;
        insert Acc;     
        User u;
        RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];      
        
        
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        List<Holiday> holLst = new List<Holiday>();
        Holiday hol = new Holiday();
        Holiday hol1 = new Holiday();
        System.runAs ( thisUser ) {
        
        hol.Name='Test holiday';
        hol.activitydate = System.Today()+1;
        holLst.add(hol);
        
        hol1.Name='Test holiday';
        hol1.activitydate = System.Today()+2;
        holLst.add(hol1);
        
        insert holLst;
        system.debug('--Holiday--'+hol);  
        }
        Holiday hold = [select id,activitydate from Holiday where id=:hol.id];
        
        Order ord = new Order();
        ord.RecordTypeId = Rec.Id;
        ord.AccountId = Acc.Id;
        ord.Type = 'Hotline';
        ord.Status = 'In Progress';
        ord.EffectiveDate = Date.Today(); 
        ord.FCHK_Billing_Address1__c = 'Address Line 1';
        ord.FCHK_Same_as_BillingAddress__c = true;     
        ord.FCHK_Chinese_Address__c = true;        
        
        try{
        insert ord;
        }
        catch(Exception e){
            system.assertEquals('You can\'t delete this record!', e.getMessage());
        }
        try{
        delete ord;
        }
        catch(Exception e){
            system.assertEquals('You can\'t delete this record!', e.getMessage());
        }
        system.debug('--ord.id--'+ord.id);       
       
    }
    
   
   
  
}