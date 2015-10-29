@isTest(SeeAllData=true)
private class FCHK_Cls_OrderLineItemActions_test {

	
    static testMethod void insertOrderItemTest() {
        // TO DO: implement unit test
       RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];      
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail0@method.com';
        Acc.PersonMobilePhone = '50852045';
        Acc.PersonHomePhone = '45000544';
        Acc.recordTypeId = recordTypeIds;
        acc.PersonBirthdate = System.today().addYears(-20);
       
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
        //Ord.Status='confirmed';
        //Ord.FCHK_Shipping_Address__c ='MyHome';
        ord.FCHK_Same_as_BillingAddress__c=true;
        
        insert ord;
       
        List<Order> ordlist = new List<Order> ();
        ordlist.add(ord);
     
        List<OrderItem> ordItmLst = new List<OrderItem>();
        OrderItem ordItem = new OrderItem();
        ordItem.OrderId = ord.Id;
        ordItem.PricebookentryId = pbk.Id;
       // ordItem.Pricebookentry.Product2.name ='Optimel Gold';
        ordItem.Quantity = 1;
        ordItem.UnitPrice = 180;
        ordItmLst.add(ordItem);
        //insert ordItem;
         OrderItem ordItem1 = new OrderItem();
        ordItem1.OrderId = ord.Id;
        ordItem1.PricebookentryId = pbk.Id;
       // ordItem.Pricebookentry.Product2.name ='Optimel Gold';
        ordItem1.Quantity = 1;
        ordItem1.UnitPrice = 180;
         ordItmLst.add(ordItem1);
       //insert ordItem1;
       Test.startTest();
       	insert ordItmLst;
       Test.stopTest();
        //ordItmLst.add(ordItem);
          
      //update ord;
                //FCHK_Cls_OrderLineItemActions.calculateQuanityfromLitemtoOrder(ordItmLst);
                
            
                //FCHK_Cls_CheckRecursive.flag = true;
      
    }
  
    static testMethod void updateOrderItemTest() {
        // TO DO: implement unit test
       RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];      
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail4@method.com';
        Acc.PersonMobilePhone = '53852045';
        Acc.PersonHomePhone = '45009546';
        Acc.recordTypeId = recordTypeIds;
        acc.PersonBirthdate = System.today().addYears(-20);
        insert Acc;
        
       
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
        ord.FCHK_Product__c = 'Optimel Silver';      
        ord.PriceBook2Id = Test.getStandardPricebookId();  
        ord.FCHK_Street__c = 'XYZ';
        ord.FCHK_District__c = 'ABC City';
        ord.FCHK_Territory__c = 'Hong Kong';
        //Ord.Status='confirmed';
        //Ord.FCHK_Shipping_Address__c ='MyHome';
        ord.FCHK_Same_as_BillingAddress__c=true;
        
        insert ord;
       
        List<Order> ordlist = new List<Order> ();
        ordlist.add(ord);
     
        List<OrderItem> ordItmLst = new List<OrderItem>();
        OrderItem ordItem = new OrderItem();
        ordItem.OrderId = ord.Id;
        ordItem.PricebookentryId = pbk.Id;
       // ordItem.Pricebookentry.Product2.name ='Optimel Gold';
        ordItem.Quantity = 1;
        ordItem.UnitPrice = 180;
        
       insert ordItem;
       OrderItem ordItem1 = new OrderItem();
        ordItem1.OrderId = ord.Id;
        ordItem1.PricebookentryId = pbk.Id;
       // ordItem.Pricebookentry.Product2.name ='Optimel Gold';
        ordItem1.Quantity = 1;
        ordItem1.UnitPrice = 180;
        
       insert ordItem1;
       Test.startTest();
       ordItem.Quantity = 3;
       ordItem.UnitPrice = 380;   
       update ordItem;      
       Test.stopTest(); 
    
        //ordItmLst.add(ordItem);
          
      //update ord;
                //FCHK_Cls_OrderLineItemActions.calculateQuanityfromLitemtoOrder(ordItmLst);
                
            
                //FCHK_Cls_CheckRecursive.flag = true;
      
    }
    
   
     static testmethod void deleteOrderItemTest(){
              // TO DO: implement unit test
       RecordType Rec = [select id,name from RecordType where name='Order' and SOBjectType='Order'];      
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail5@method.com';
        Acc.PersonMobilePhone = '57852845';
        Acc.PersonHomePhone = '45000540';
        Acc.recordTypeId = recordTypeIds;
        acc.PersonBirthdate = System.today().addYears(-20);
       
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
        //Ord.Status='confirmed';
        //Ord.FCHK_Shipping_Address__c ='MyHome';
        ord.FCHK_Same_as_BillingAddress__c=true;
        
        insert ord;
       
        List<Order> ordlist = new List<Order> ();
        ordlist.add(ord);
     
        List<OrderItem> ordItmLst = new List<OrderItem>();
        OrderItem ordItem = new OrderItem();
        ordItem.OrderId = ord.Id;
        ordItem.PricebookentryId = pbk.Id;
       // ordItem.Pricebookentry.Product2.name ='Optimel Gold';
        ordItem.Quantity = 1;
        ordItem.UnitPrice = 180;
        
        insert ordItem;
         OrderItem ordItem1 = new OrderItem();
        ordItem1.OrderId = ord.Id;
        ordItem1.PricebookentryId = pbk.Id;
       // ordItem.Pricebookentry.Product2.name ='Optimel Gold';
        ordItem1.Quantity = 1;
        ordItem1.UnitPrice = 180;
        
       insert ordItem1;
       test.startTest();
       delete ordItem;
       test.stopTest();
    }
    
    
}