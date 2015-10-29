public with sharing class FCHK_Cls_OrderLineItemActions {
	public static void calculateQuanityfromLitemtoOrder(List<OrderItem> orderitemList){
		Set<Id> orderIdSet = new Set<Id>();//To hold order ids associated with orderitems
		Map<Id,Order> orderMap = new Map<Id,Order>();
		Map<Id,decimal> optimeldimondCountMap = new Map<Id,decimal>();
		Map<Id,decimal> optimelgoldCountMap = new Map<id,decimal>();
		Map<id,decimal> optimelsilverCountMap = new Map<Id,decimal>();
		if(trigger.isInsert){
			for(OrderItem  oliObj:orderitemList){
				if(oliObj.orderId!=null && oliObj.FCHK_RectypeDeveloperName__c=='FCHK_RT_Order'){
					orderIdSet.add(oliObj.orderId);
				}
			}
		}
		if(trigger.isUpdate){
			for(OrderItem oliObj:orderitemList){
				if(oliObj.orderId!=null && oliObj.FCHK_RectypeDeveloperName__c=='FCHK_RT_Order'){
					orderIdSet.add(oliObj.orderId);
				}
			}
		}
		if(trigger.isDelete){
			for(OrderItem oliObj:orderitemList){
				if(oliObj.orderId!=null && oliObj.FCHK_RectypeDeveloperName__c=='FCHK_RT_Order'){
					orderIdSet.add(oliObj.orderId);
				}
			}
		}
		
		if(orderIdSet!=null && orderIdSet.size()>0){
				if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
					for(OrderItem orderItemObj:[select id,quantity,pricebookentry.Product2.Name,orderId 
						from OrderItem where orderid in:orderIdSet]){
						 if(orderItemObj.pricebookentry.Product2.Name=='Optimel Diamond'){
						 		if(optimeldimondCountMap.get(orderItemObj.orderId)!=null){
						 			optimeldimondCountMap.put(orderItemObj.orderId,orderItemObj.quantity+optimeldimondCountMap.get(orderItemObj.orderId));
						 		}
						 		else{
						 			optimeldimondCountMap.put(orderItemObj.orderId,orderItemObj.quantity);
						 		}
						 		
						 }
						 else if(orderItemObj.pricebookentry.Product2.Name=='Optimel Gold'){
						 	 if(optimelgoldCountMap.get(orderItemObj.orderId)!=null){
						 	 	optimelgoldCountMap.put(orderItemObj.orderId,orderItemObj.quantity+optimelgoldCountMap.get(orderItemObj.orderId));
						 	 }
						 	 else{
						 	 	optimelgoldCountMap.put(orderItemObj.orderId,orderItemObj.quantity);
						 	 	
						 	 }
						 }
						 else if(orderItemObj.pricebookentry.Product2.Name=='Optimel Silver'){
						 	if(optimelsilverCountMap.get(orderItemObj.orderId)!=null){
						 		optimelsilverCountMap.put(orderItemObj.orderId,orderItemObj.quantity+optimelsilverCountMap.get(orderItemObj.orderId));
						 	}
						 	else{
						 		optimelsilverCountMap.put(orderItemObj.orderId,orderItemObj.quantity);
						 	}
						 }
					}
				}
				else if(trigger.isDelete && trigger.isBefore){
					for(OrderItem orderItemObj:[select id,quantity,pricebookentry.Product2.Name,orderId 
						from OrderItem where orderid in:orderIdSet and id not in:orderitemList]){
						 if(orderItemObj.pricebookentry.Product2.Name=='Optimel Diamond'){
						 		if(optimeldimondCountMap.get(orderItemObj.orderId)!=null){
						 			optimeldimondCountMap.put(orderItemObj.orderId,orderItemObj.quantity+optimeldimondCountMap.get(orderItemObj.orderId));
						 		}
						 		else{
						 			optimeldimondCountMap.put(orderItemObj.orderId,orderItemObj.quantity);
						 		}
						 		
						 }
						 else if(orderItemObj.pricebookentry.Product2.Name=='Optimel Gold'){
						 	 if(optimelgoldCountMap.get(orderItemObj.orderId)!=null){
						 	 	optimelgoldCountMap.put(orderItemObj.orderId,orderItemObj.quantity+optimelgoldCountMap.get(orderItemObj.orderId));
						 	 }
						 	 else{
						 	 	optimelgoldCountMap.put(orderItemObj.orderId,orderItemObj.quantity);
						 	 	
						 	 }
						 }
						 else if(orderItemObj.pricebookentry.Product2.Name=='Optimel Silver'){
						 	if(optimelsilverCountMap.get(orderItemObj.orderId)!=null){
						 		optimelsilverCountMap.put(orderItemObj.orderId,orderItemObj.quantity+optimelsilverCountMap.get(orderItemObj.orderId));
						 	}
						 	else{
						 		optimelsilverCountMap.put(orderItemObj.orderId,orderItemObj.quantity);
						 	}
						 }
					}
				}
				for(Id orderId:orderIdSet){
					Order orderObj = new Order(id=orderId);
					if(optimeldimondCountMap.get(orderId)!=null){
						orderObj.FCHK_OptimelDiamond__c = optimeldimondCountMap.get(orderId);
					}
					else {
						orderObj.FCHK_OptimelDiamond__c = 0;
					}
					if(optimelgoldCountMap.get(orderId)!=null){
						orderObj.FCHK_OptimelGold__c = optimelgoldCountMap.get(orderId);
					}
					else{
						orderObj.FCHK_OptimelGold__c = 0;
					}
					if(optimelsilverCountMap.get(orderId)!=null){
						orderObj.FCHK_OptimelSilver__c = optimelsilverCountMap.get(orderId);
					}
					else{
						orderObj.FCHK_OptimelSilver__c=0;
					}
					orderMap.put(orderObj.id,orderObj);					
				}
			if(orderMap!=null && orderMap.size()>0){
				 update orderMap.values();
			} 
		}
		
	}
				
}