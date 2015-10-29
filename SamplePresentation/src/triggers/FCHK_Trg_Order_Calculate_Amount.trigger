trigger FCHK_Trg_Order_Calculate_Amount on OrderItem (after insert, before update,before delete,after update) {

    Set<Id> OrderId = new Set<Id>();
    List<Order> orderLst = new List<Order>();
    Map<Id,Order> OrderMap;
    Set<Id> OrdItm = new Set<Id>();
    List<OrderItem> OrdItmLst = new List<OrderItem>();
    //RecordType RecName = [select id,name from RecordType where SObjectType='Order' and Name='Sample Request'];  
    Map<id,RecordType> recordTypeMapOrd = new Map<id,RecordType>();
    recordTypeMapOrd.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
    
    if(Trigger.isInsert){
    	if(trigger.isAfter){
    		//FOR calculating the optimel diamond ,optimel gold and optimel silver values 
    		////on order from order item added  for phase 2b
    		FCHK_Cls_OrderLineItemActions.calculateQuanityfromLitemtoOrder(trigger.new);
    		//end of calculation
    	}
	    for(OrderItem oritm : Trigger.new){
	        
	        OrderId.add(oritm.OrderId);
	    }
	    
	    system.debug('--OrderId--');
	    if(OrderId != null){
	    OrderMap = new Map<Id,Order>([select id,FCHK_Total_Cost__c,RecordTypeId,(select id,UnitPrice,Quantity from OrderItems) from Order where Id in :OrderId]);
	    
	    for(Order Ord : OrderMap.values()){
	    if(recordTypeMapOrd.get(Ord.RecordTypeId).DeveloperName!='FCHK_RT_Sample_Request'){
	        Decimal num=0;    
	        for(OrderItem Otm : Ord.OrderItems){
	            Ord.FCHK_Total_Cost__c = num + (Otm.UnitPrice * Otm.Quantity);
	            num = Ord.FCHK_Total_Cost__c;
	        }               
	        orderLst.add(Ord); 
	    }
	    }
	    if(orderLst.size()>0)
	        update orderLst;
	    }    
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
            for(OrderItem oritm : Trigger.new){
                if(oritm.Quantity != Trigger.oldMap.get(oritm.id).Quantity){
                    OrderId.add(oritm.OrderId);
                }
            }
            if(OrderId != null){
                 system.debug('--OrderId--');
            OrderMap = new Map<Id,Order>([select id,FCHK_Total_Cost__c,(select id,UnitPrice,Quantity from OrderItems) from Order where Id in :OrderId]);
            
            for(Order Ord : OrderMap.values()){
                Decimal num=0;
                
                for(OrderItem Otm : Ord.OrderItems){
                    Ord.FCHK_Total_Cost__c = num + (Otm.UnitPrice * Otm.Quantity);
                    num = Ord.FCHK_Total_Cost__c;
                }   
                    orderLst.add(Ord); 
            }
            if(orderLst.size()>0)
                update orderLst;
            }          
            
    }
    else if(trigger.isAfter && trigger.isUpdate){
    	//FOR calculating the optimel diamond ,optimel goald and optimel silver values 
    	////on order from order item added  for phase 2b
    		List<OrderItem> orderItemList = new List<OrderItem>();
    		for(OrderItem orderItemObj:trigger.new){
    			if(orderItemObj.orderId!=null && trigger.newMap.get(orderItemObj.id).Quantity!=trigger.oldMap.get(orderItemObj.id).quantity){
    				orderItemList.add(orderItemObj);
    			}
    		}
    		if(orderItemList!=null && orderItemList.size()>0){
    				FCHK_Cls_OrderLineItemActions.calculateQuanityfromLitemtoOrder(orderItemList);
    		}
    	//end of calculation
    }
    else if(Trigger.isBefore && Trigger.isDelete){
    	//FOR calculating the optimel diamond ,optimel goald and optimel silver values 
    	//on order from order item added  for phase 2b
    	FCHK_Cls_OrderLineItemActions.calculateQuanityfromLitemtoOrder(trigger.old);
    	//end of calcuation
        for(OrderItem oritm : Trigger.old){             
                OrdItm.add(oritm.Id);      
                OrderId.add(oritm.OrderId); 
                           
        }
        if(OrderId != null){
             system.debug('--OrderId--');
        OrderMap = new Map<Id,Order>([select id,RecordType.Name,FCHK_Total_Cost__c,(select id,UnitPrice,Quantity from OrderItems) from Order where Id in :OrderId]);
        OrdItmLst = [select id,UnitPrice,Quantity,OrderId from OrderItem where Id in : OrdItm];
       
        for(Order Ord : OrderMap.values()){            
            system.debug('--'+Ord.RecordType.Name);
            //system.debug('--'+RecName.Name);
            if(recordTypeMapOrd.get(Ord.RecordTypeId).DeveloperName!='FCHK_RT_Sample_Request'){
                for(OrderItem Otm : OrdItmLst){
                    if(Ord.Id == Otm.OrderId){
                        Ord.FCHK_Total_Cost__c = Ord.FCHK_Total_Cost__c - (Otm.UnitPrice * Otm.Quantity);
                        
                    }
                }
            }   
                orderLst.add(Ord); 
        }
        if(orderLst.size()>0)
            update orderLst;
        }          
            
    }
    
}