trigger FCHK_Trg_Order_Update_AnnualRev on Order (after update,before delete,after insert) {
    
  
  	set<id> accountIdSet = new Set<Id>();
  	Map<Id,Account> accountMap = new Map<Id,Account>();
  	Map<Id,RecordType> orderRecordTypeMap = new Map<Id,RecordType>();  	
  	Map<Id,List<Order>> actIdOrderListMap = new Map<Id,List<Order>>();
  	Map<Id,decimal> actIdTotalCostMap = new Map<Id,decimal>();
  	orderRecordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
  	Map<id,List<Order>> actOrderListMap = new Map<id,List<Order>>();
  	if(trigger.isUpdate && trigger.isAfter){
	  	for(Order orderObj:trigger.new){
	  			if((trigger.newMap.get(orderObj.id).status!=trigger.oldMap.get(orderObj.id).status || orderObj.status=='Confirmed')  	  				
	  				&& (orderRecordTypeMap.get(orderObj.recordTypeId).developerName=='FCHK_RT_Order' 
	  					|| orderRecordTypeMap.get(orderObj.recordTypeId).developerName=='FCHK_Promotional_Orders') 
	  				&& orderObj.AccountId!=null){
	  					accountIdSet.add(orderObj.AccountId);
	  				}	
	  	}
	  	System.debug('accountIdSet@@:'+accountIdSet);
	  	if(accountIdSet!=null && accountIdSet.size()>0){
  			for(Order orderObj:[select id,FCHK_Total_Cost__c,AccountId,Status from Order 
  				where AccountId in:accountIdSet and FCHK_Total_Cost__c!=null and (status='Order Confirmed' or status='Confirmed')
  				and (RecordType.DeveloperName='FCHK_RT_Order' or RecordType.DeveloperName='FCHK_Promotional_Orders')]){
  				if(actIdTotalCostMap.get(orderObj.AccountId)!=null){
  					actIdTotalCostMap.put(orderObj.AccountId,actIdTotalCostMap.get(orderObj.AccountId)+orderObj.FCHK_Total_Cost__c);
  				}
  				else{
  					actIdTotalCostMap.put(orderObj.AccountId,orderObj.FCHK_Total_Cost__c);
  				}
  				
  				if(actOrderListMap.get(orderObj.AccountId)!=null){
  					actOrderListMap.get(orderObj.AccountId).add(orderObj);	
  				}
  				else{
  					actOrderListMap.put(orderObj.AccountId,new List<Order>{orderObj});	
  				}
  				
  			}
  			System.debug('actIdTotalCostMap@@:'+actIdTotalCostMap);
  			if(accountIdSet!=null && accountIdSet.size()>0){
  					for(Id accountId:accountIdSet){
  						if(actOrderListMap.get(accountId)==null){
  							actOrderListMap.put(accountId,new List<Order>{});
  						}
  					}
  					for(Id accountId:accountIdSet){
  							Account actObj = new Account(id=accountId,FCHK_Total_Expenses__c=actIdTotalCostMap.get(accountId),
  							FCHK_Order_Count__c=actOrderListMap.get(accountId).size());
  							accountMap.put(actObj.id,actObj);
  					}
  			}
  			if(accountMap!=null && accountMap.size()>0){
  					update accountMap.values();
  			}
  		}
  	
  	}
  	
  	if(trigger.isDelete && trigger.isBefore){
  		for(Order orderObj:trigger.old){
	  			if((orderObj.status=='In Progress' ||  orderObj.status=='Confirmed')
	  				&& (orderRecordTypeMap.get(orderObj.recordTypeId).developerName=='FCHK_RT_Order' 
	  					|| orderRecordTypeMap.get(orderObj.recordTypeId).developerName=='FCHK_Promotional_Orders')
	  				&& orderObj.AccountId!=null){
	  					accountIdSet.add(orderObj.AccountId);
	  				}	
	  	}
	  	if(accountIdSet!=null && accountIdSet.size()>0){
  			for(Order orderObj:[select id,FCHK_Total_Cost__c,AccountId,Status from Order 
  				where AccountId in:accountIdSet and FCHK_Total_Cost__c!=null and (status='Order Confirmed' or status='Confirmed') 
  				and (RecordType.DeveloperName='FCHK_RT_Order' or RecordType.DeveloperName='FCHK_Promotional_Orders') and id not in:trigger.oldmap.keyset()]){
  				if(actIdTotalCostMap.get(orderObj.AccountId)!=null){
  					actIdTotalCostMap.put(orderObj.AccountId,actIdTotalCostMap.get(orderObj.AccountId)+orderObj.FCHK_Total_Cost__c);
  				}
  				else{
  					actIdTotalCostMap.put(orderObj.AccountId,orderObj.FCHK_Total_Cost__c);
  				}
  				if(actOrderListMap.get(orderObj.AccountId)!=null){
  					actOrderListMap.get(orderObj.AccountId).add(orderObj);	
  				}
  				else{
  					actOrderListMap.put(orderObj.AccountId,new List<Order>{orderObj});	
  				}
  			}
  			if(accountIdSet!=null && accountIdSet.size()>0){
  					for(Id accountId:accountIdSet){
  						if(actOrderListMap.get(accountId)==null){
  							actOrderListMap.put(accountId,new List<Order>{});
  						}
  					}
  					System.debug('actOrderListMap@@@:'+actOrderListMap);
  					for(Id accountId:accountIdSet){
  						System.debug('actOrderListMap.get(accountId).size()@@@:'+actOrderListMap.get(accountId).size());
  							Account actObj = new Account(id=accountId,FCHK_Total_Expenses__c=actIdTotalCostMap.get(accountId)
  							,FCHK_Order_Count__c=actOrderListMap.get(accountId).size());
  							accountMap.put(actObj.id,actObj);
  					}
  			}
  			if(accountMap!=null && accountMap.size()>0){
  					update accountMap.values();
  			}
  		}
  	}
  	
  	if(trigger.isInsert && trigger.isAfter){
  			List<Order> orderList = new List<Order>();
  			for(Order orderObj:[select id,FCHK_Product__c,Account.RecordType.DeveloperName,RecordType.DeveloperName 
  					from Order where AccountID!=null and Account.RecordType.DeveloperName='FCHK_MR_RT_Optimel'
  					 and RecordType.DeveloperName='FCHK_RT_Sample_Request' and id in:trigger.newMap.keyset()]){
  					orderList.add(orderObj);
  			}
  			if(orderList!=null && orderList.size()>0){
  					FCHK_Cls_OutboundCallActionscls.updateMemberfrmOrder(orderList);
  			}
  	}
    /*Set<Id> AccId = new Set<Id>();
    Set<Id> OrderId = new Set<Id>();
    List<Account> AccLst = new List<Account>();
    List<Order> OrderLst = new List<Order>();
    Map<Id,Account> AccMap;
    Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
    Map<id,RecordType> recordTypeMapOrdr = new Map<id,RecordType>();
    recordTypeMapOrdr.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
    if(Trigger.isUpdate){
        for(Order O : Trigger.new){
            system.debug('--TotalAmt--'+O.TotalAmount);
                if(O.TotalAmount!=null &&  recordTypeMapOrdr.get(O.RecordTypeId).DeveloperName=='FCHK_RT_Order' )
                    AccId.add(O.AccountId);
                //OrderId.add(O.Id);        
           
        }
    }
    else if(Trigger.isDelete){    
        for(Order O : Trigger.old){
            system.debug('--TotalAmt--'+O.TotalAmount);
                //AccId.add(O.AccountId);
                if(O.TotalAmount!=null &&  recordTypeMapOrdr.get(O.RecordTypeId).DeveloperName=='FCHK_RT_Order' )
                    OrderId.add(O.Id);        
        }
    }
    system.debug('---AccID--'+AccId);
    
    Decimal Sum=0;
    Decimal FinalSum=0;
    Integer OrderCount = 0;
    //RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
    //public static RecordType OrderRecName = [select id,name from RecordType where SObjectType='Order' and Name='Order'];
    if(AccId!=null)    
        AccMap = new Map<Id,Account>([select id,FCHK_Order_Count__c,FCHK_Total_Expenses__c, (select FCHK_Total_Cost__c,RecordTypeId ,Status,FCHK_Offer_Type__c,TotalAmount,Id 
                                    from Orders ) from Account where Id in : AccId]);
                                
    if(Trigger.isUpdate){       
    system.debug('--AccMap--'+AccMap);
        if(AccMap!=null && AccMap.size()>0){
            for(Account Acc : AccMap.values()){
                Account A = Acc;
                Decimal num=0;
               
                for(Order ord : A.Orders){
                    system.debug('--ordAmount--'+ord.FCHK_Total_Cost__c);
                    if(ord.FCHK_Total_Cost__c != null && ord.Status == 'Order Confirmed'){
                        A.FCHK_Total_Expenses__c = num + ord.FCHK_Total_Cost__c;
                        num = A.FCHK_Total_Expenses__c;
                    }
                    if(ord.Status!='Order Cancelled' && recordTypeMapOrdr.get(Ord.RecordTypeId).DeveloperName=='FCHK_RT_Order')
                        OrderCount = OrderCount + 1;
                                        
                }
                A.FCHK_Order_Count__c = OrderCount;
                system.debug('-A.FCHK_Total_Expenses__c-'+A.FCHK_Total_Expenses__c);
                AccLst.add(A); 
            }
            if(AccLst.size()>0)
                Update AccLst;
        }
    }
    else if(Trigger.isBefore && Trigger.isDelete){
        OrderLst = [select id, RecordTypeId,FCHK_Total_Cost__c,AccountId,Account.FCHK_Total_Expenses__c
                     from Order where Id in :OrderId];
        for(Account Acc : AccMap.values()){            
            for(Order ord : OrderLst){
                system.debug('--ordAmount--'+ord.FCHK_Total_Cost__c);
                if(Acc.Id == ord.AccountId && ord.FCHK_Total_Cost__c != null && Acc.FCHK_Total_Expenses__c>0){
                    Acc.FCHK_Total_Expenses__c = Acc.FCHK_Total_Expenses__c - ord.FCHK_Total_Cost__c;
                    
                }
                
            }
            
            AccLst.add(Acc);
        }
        if(AccLst.size()>0)
            Update AccLst;
    }*/
  System.debug('1.Number of Queries used in this apex code so far: AnnRev' + Limits.getQueries());
}