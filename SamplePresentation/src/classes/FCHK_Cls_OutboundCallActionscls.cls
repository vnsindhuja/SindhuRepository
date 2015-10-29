public with sharing class FCHK_Cls_OutboundCallActionscls {
		public static void updateMemberfrmOutboundCall(List<Task> taskList){			
			Map<id,Account> accountMap = new Map<id,Account>();
			Set<Id> recordTypeIdSet = new Set<Id>();
			Map<Id,RecordType> recordTypeMap = new Map<Id,RecordType>();	
			boolean isRecordTypeNeeded=false;		
			for(Task taskObj:taskList){
				if(taskObj.whatId!=null && String.valueOf(taskObj.whatId).startsWith('001')
					&& taskObj.FCHK_First_Purchase__c=='Claimed Purchase'){
						isRecordTypeNeeded=true;
				}
			}
			if(isRecordTypeNeeded==true){
				recordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task'));
			}
			for(Task taskObj:taskList){
				if(taskObj.whatId!=null 
				 	&& String.valueof(taskObj.WhatId).startsWith('001') 
				 	&& taskObj.RecordTypeId!=null 
					&& recordTypeMap.get(taskObj.RecordTypeId)!=null 
					&& recordTypeMap.get(taskObj.RecordTypeId).developerName=='X1st_Purchase_Outbound_Call' 
					&& taskObj.FCHK_First_Purchase__c=='Claimed Purchase'){
					Account actObj = new Account(id=taskObj.whatId,FCHK_Claimed_Purchase__c=true);
					accountMap.put(actObj.id,actobj);
				}
			}
			if(accountMap!=null  && accountMap.size()>0){
					try{
						update accountMap.values();
					}
					Catch(Exception e){
						System.debug('e.getMessage():'+e.getMessage()+' LineNumber:'+e.getLineNumber());
					}
			}
			
		}
		//here we are creating the activity (task) with task record type when FCHK_1st_Purchase_Done__c or FCHK_Claimed_Purchase__c 
		//is checked
		public static void createOutboundcalls(List<Account> accountList){
			Map<id,RecordType> recordTypeMap = new Map<id,RecordType>();
			Map<String,Id> recTypeNameIdMap = new Map<String,Id>();
			List<Task> taskList = new List<Task>();//to hold collection of task
			recordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task'));
			if(recordTypeMap!=null && recordTypeMap.size()>0){
				for(Id recTypeId:recordTypeMap.keyset()){					
					recTypeNameIdMap.put(recordTypeMap.get(recTypeId).DeveloperName,recordTypeMap.get(recTypeId).id);
				}
			}
			for(Account actObj:accountList){
				if(actObj.PersonMobilePhone!=null || actObj.PersonHomePhone!=null){
					System.debug('Account if entering...');
					Task taskObj = new Task();
					taskObj.whatId=actObj.id;
					if(actObj.FCHK_is60DaysCompleted__c==true){
						taskobj.subject='Third Purchase Outbound Call';	
						if(recTypeNameIdMap.get('X3rd_Purchase_Outbound_Call')!=null){
							taskObj.RecordTypeId = recTypeNameIdMap.get('X3rd_Purchase_Outbound_Call');
						}	
										
					}
					else if(actObj.FCHK_is30DaysCompleted__c==true){
						taskobj.subject='Second Purchase Outbound Call';
						if(recTypeNameIdMap.get('X2nd_Purchase_Outbound_Call')!=null){
							taskObj.RecordTypeId = recTypeNameIdMap.get('X2nd_Purchase_Outbound_Call');
						}						
					}
					taskObj.Description ='Please contact the Member, update Operator Name and the Status.';
					taskObj.Priority = 'Normal';
					taskObj.Status = 'In Progress';
					taskObj.ActivityDate = System.Today();
					taskList.add(taskObj);
				}
				
			}
			//inserting task
			if(taskList!=null && taskList.size()>0){
					try{
						System.debug('try block entering...');
						AppLiteralscls.stopOutboundcalls2ndtime=true;
						insert taskList;
					}
					Catch(Exception e){
						System.debug('Exception:e.getMessage():'+e.getMessage()+' LineNumber:'+e.getLineNumber());
					}
			}
			
		}
		//Update brand Field names
		public static Void updateBrandonMember(List<Task> taskList){
			Map<Id,Account> accountMap = new Map<Id,Account>();
			Map<id,RecordType> recordTypeMap = new Map<id,RecordType>();
			recordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task'));
			for(Task taskObj:taskList){
				if(taskObj.RecordTypeId!=null 					
					&& String.valueOf(taskObj.whatId).startsWith('001')){
					if(recordTypeMap.get(taskObj.RecordTypeId).DeveloperName=='Sample_Invitation_Outbound_Call'
						&& taskObj.FCHK_Sample_Request_Remark__c!=null){
						Account actObj = new Account(id=taskObj.whatId,FCHK_Brand_Name_Outbound_1__c=taskObj.FCHK_Sample_Request_Remark__c,
						FCHK_Brand_Name_Outbound_Date_1__c = System.today());
						accountMap.put(actObj.id,actObj);
					} 	
					else if(recordTypeMap.get(taskObj.RecordTypeId).DeveloperName=='X1st_Purchase_Outbound_Call'){
						if(taskObj.FCHK_Try_Remark__c!=null){
							Account actObj = new Account(id=taskObj.whatId,FCHK_Brand_Name_Outbound_2__c=taskObj.FCHK_Try_Remark__c,
							FCHK_Brand_Name_Outbound_Date_2__c = System.today());
							accountMap.put(actObj.id,actObj);
						}
						else if(taskObj.FCHK_Consume_Remark__c!=null){
							Account actObj = new Account(id=taskObj.whatId,FCHK_Brand_Name_Outbound_2__c=taskObj.FCHK_Consume_Remark__c,
							FCHK_Brand_Name_Outbound_Date_2__c = System.today());
							accountMap.put(actObj.id,actObj);
						}
					}	
					else if(recordTypeMap.get(taskObj.RecordTypeId).DeveloperName=='X2nd_Purchase_Outbound_Call' 
						&& taskObj.FCHK_2nd_Purchase_Remark__c!=null){
							Account actObj = new Account(id=taskObj.whatId,FCHK_Brand_Name_Outbound_3__c=taskObj.FCHK_2nd_Purchase_Remark__c,
							FCHK_Brand_Name_Outbound_Date_3__c = System.today());
							accountMap.put(actObj.id,actObj);
					}	
					else if(recordTypeMap.get(taskObj.RecordTypeId).DeveloperName=='X2nd_Purchase_Outbound_Call' 
						&& taskObj.FCHK_Will_you_make_a_2nd_Purchase__c=='Yes'){
							Account actObj = new Account(id=taskObj.whatId,FCHK_Brand_Name_Outbound_3__c='Optimel',
							FCHK_Brand_Name_Outbound_Date_3__c = System.today());
							accountMap.put(actObj.id,actObj);
					}			
				}
			}
			if(accountMap!=null && accountMap.size()>0){
				try{
					update accountMap.values();
				}
				catch(Exception e){
						System.debug('Exception:e.getMessage():'+e.getMessage()+' LineNumber:'+e.getLineNumber());
				}
					
			}
		}
		
		
		//End of  update brand Field Names
		//Starting of creating the Sample Request
		public static void createSampleRequestfromOutboundcall(List<Task> taskList){
			List<Order> orderList = new List<Order>();
			Map<String,RecordType> orderRecTypeMap = new Map<String,RecordType>();
			Map<Id,RecordType> orderRecordTypeMap = new Map<Id,RecordType>();
			Map<Id,RecordType> taskRecordTypeMap = new Map<Id,RecordType>();
			orderRecordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
			taskRecordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task'));
			//FCHK_RT_Sample_Request\
			if(orderRecordTypeMap!=null && orderRecordTypeMap.size()>0){
				for(Id rectypeId:orderRecordTypeMap.keyset()){
					orderRecTypeMap.put(orderRecordTypeMap.get(rectypeId).developerName,orderRecordTypeMap.get(rectypeId));
				}
			}
			for(Task taskObj:taskList){
				if(taskObj.FCHK_Sample_Request__c=='Yes' && taskObj.whatId!=null 
				&& taskRecordTypeMap.get(taskObj.RecordTypeId).DeveloperName=='Sample_Invitation_Outbound_Call' 
				&& String.valueOf(taskObj.whatId).startsWith('001')){
					if(taskObj.FCHK_Product_Name__c=='Optimel Silver' || taskObj.FCHK_Product_Name__c=='Optimel Gold' 
						|| taskObj.FCHK_Product_Name__c=='Optimel Diamond'){
						Order orderObj = new Order();
                        orderObj.AccountId= taskObj.whatId;
                        orderObj.recordTypeId=orderRecTypeMap.get('FCHK_RT_Sample_Request').id;
                        orderObj.FCHK_Product__c=taskObj.FCHK_Product_Name__c;
                        orderObj.EffectiveDate = Date.Today();
                        orderObj.FCHK_Operator_Name__c=taskObj.FCHK_Operator_Name__c;
                        orderObj.Status='Confirmed';
                        orderObj.FCHK_Same_as_BillingAddress__c=taskObj.FCHK_Same_as_BillingAddress__c;
                        orderList.add(orderObj);
					}
				
				}
			}
			if(orderList!=null && orderList.size()>0){
				 System.debug('order if entering....');
					insert orderList;
			}
			
		}		
		//End of creating the sample Request
		public static void updateOutboundCall(List<Task> taskList){
			Map<Id,RecordType> taskRecordTypeMap = new Map<Id,RecordType>();
			taskRecordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task'));
			Set<Id> accountIdSet = new Set<Id>();
			Map<Id,Account> accountMap = new Map<Id,Account>();
			for(Task taskObj:taskList){
				if(taskObj.whatId!=null && taskobj.recordTypeId!=null 
					&& taskRecordTypeMap.get(taskObj.recordTypeId).DeveloperName=='Sample_Invitation_Outbound_Call'
					&& String.valueOf(taskObj.whatId).startsWith('001')){
					accountIdSet.add(taskObj.whatId);
				}
				
			}
			if(accountIdSet!=null && accountIdSet.size()>0){
				for(Account actObj:[select id,name,FCHK_Flat__c,FCHK_Floor__c,FCHK_Block__c
					,FCHK_Building__c,FCHK_Estate__c,FCHK_Street__c,FCHK_Territory__c,FCHK_District__c 
					from Account where id in:accountIdSet]){
						accountMap.put(actObj.Id,actObj);
					}
			}
			for(Task taskObj:taskList){
				if(taskObj.whatId!=null && taskobj.recordTypeId!=null 
					&& taskRecordTypeMap.get(taskObj.recordTypeId).DeveloperName=='Sample_Invitation_Outbound_Call'
					&& String.valueOf(taskObj.whatId).startsWith('001')){
					if(accountMap.get(taskObj.whatId).FCHK_Flat__c!=null || 
						accountMap.get(taskObj.whatId).FCHK_Floor__c!=null || 
						accountMap.get(taskObj.whatId).FCHK_Block__c!=null || 
						accountMap.get(taskObj.whatId).FCHK_Building__c!=null ||
						accountMap.get(taskObj.whatId).FCHK_Estate__c!=null || 
						accountMap.get(taskObj.whatId).FCHK_Street__c!=null || 
						accountMap.get(taskObj.whatId).FCHK_Territory__c!=null || 
						accountMap.get(taskObj.whatId).FCHK_District__c!=null){
							taskObj.FCHK_BillingAddress__c = true;
						
					}
				}
				
			}
		}
		
		//for updating member from order when sample request created
		public static void updateMemberfrmOrder(List<Order> orderList){
			Map<Id,Account> accountMap = new Map<Id,Account>();
			for(Order orderObj:orderList){
				 if(orderObj.accountId!=null && orderObj.RecordType.DeveloperName=='FCHK_RT_Sample_Request' 
				 	&& orderObj.Account.RecordType.DeveloperName=='FCHK_MR_RT_Optimel'){
					if(orderObj.FCHK_Product__c=='Optimel Silver'){
						Account actObj = new Account(id=orderObj.AccountId,FCHK_OptimelSilverCreatedDate__c=System.today());
						accountMap.put(actObj.id,actObj);
					}
					else if(orderObj.FCHK_Product__c=='Optimel Gold'){
						Account actObj = new Account(id=orderObj.AccountId,FCHK_OptimelGoldCreatedDate__c=System.today());
						accountMap.put(actObj.id,actObj);
					}
					else if(orderObj.FCHK_Product__c=='Optimel Diamond'){
						Account actObj = new Account(id=orderObj.AccountId,FCHK_OptimelDiamondCreatedDate__c=System.today());
						accountMap.put(actObj.id,actObj);
					}
				 }
			} 
			if(accountMap!=null && accountMap.size()>0){
					update accountMap.values();
			}
		}
		
		
		
}