trigger FCHK_Trg_Outbound_Call on CampaignMember (after update) {
    
  Set<Id> contIdSet = new Set<Id>();
  Map<Id,Id> contIdActIdMap = new Map<Id,Id>();
  Map<String,RecordType> actRecordTypeMap = new Map<String,RecordType>();
  Map<Id,RecordType> actRecTypeMap = new Map<Id,RecordType>();
  Map<String,RecordType> orderRecordTypeMap = new Map<String,RecordType>();
  Map<String,RecordType> taskRecordTypeMap = new Map<String,RecordType>();
  Map<Id,Contact> contactMap = new Map<id,Contact>();
  List<Task> taskList = new List<Task>();
  List<Order> orderList  = new List<Order>();
  List<Account> accountList  = new List<Account>();
  boolean isRecordType = false;
  for(CampaignMember cmemberObj:trigger.new){
        if((trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c!=trigger.oldMap.get(cmemberObj.id).FCHK_CM_Status__c 
            && cmemberObj.ContactId!=null)){
            isRecordType = true;
            contIdSet.add(cmemberObj.ContactId);
        }
        
  }
  
  if(isRecordType==true){
    Map<id,RecordType> orderrectypeMap = new Map<id,RecordType>();
    Map<id,RecordType> taskrectypeMap = new Map<id,RecordType>();
    actRecTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
    orderrectypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
    taskrectypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task'));   
    for(Id recordTypeId:orderrectypeMap.keyset()){
        orderRecordTypeMap.put(orderrectypeMap.get(recordTypeId).developerName,orderrectypeMap.get(recordTypeId));
    }
    for(Id recordTypeId:taskrectypeMap.keyset()){
        taskRecordTypeMap.put(taskrectypeMap.get(recordTypeId).developerName,taskrectypeMap.get(recordTypeId));
    }
    for(Id recordTypeId:actRecTypeMap.keyset()){
        actRecordTypeMap.put(actRecTypeMap.get(recordTypeId).developerName,actRecTypeMap.get(recordTypeId));
    }
    
  }
  //modified on 15 October 2015 for billing address population when sample request is created from Campaing Member
  if(contIdSet!=null && contIdSet.size()>0){
        for(Contact contObj:[select id,AccountId,Account.RecordType.DeveloperName,Account.FCHK_Flat__c
        		,Account.FCHK_Floor__c,Account.FCHK_Block__c,Account.FCHK_Building__c,Account.FCHK_Estate__c
        		,Account.FCHK_Street__c,Account.FCHK_Territory__c,Account.FCHK_District__c         		
        	 from Contact where id in:contIdSet]){
            contIdActIdMap.put(contObj.id,contObj.AccountId);
            contactMap.put(contObj.id,contObj);
        }
  }
  
  for(CampaignMember cmemberObj:trigger.new){
    if(!cmemberObj.FCHK_Billing_Address__c && (cmemberObj.FCHK_Flat__c != null || cmemberObj.FCHK_Floor__c!=null || 
                        cmemberObj.FCHK_Block__c!=null || cmemberObj.FCHK_Building__c!=null || cmemberObj.FCHK_Estate__c!=null || cmemberObj.FCHK_Street__c!=null || cmemberObj.FCHK_Territory__c!=null || cmemberObj.FCHK_District__c!=null))
                        {   Account acc = new Account();
                            acc.Id=contactMap.get(cmemberObj.ContactId).AccountId;
                            acc.recordTypeId = actRecordTypeMap.get('FCHK_MR_RT_Optimel').id;
                            acc.FCHK_Flat__c = cmemberObj.FCHK_Flat__c;
                            acc.FCHK_Floor__c =  cmemberObj.FCHK_Floor__c;
                            acc.FCHK_Block__c = cmemberObj.FCHK_Block__c;
                            acc.FCHK_Building__c = cmemberObj.FCHK_Building__c;
                            acc.FCHK_Estate__c = cmemberObj.FCHK_Estate__c;
                            acc.FCHK_Street__c = cmemberObj.FCHK_Street__c;
                            acc.FCHK_Territory__c = cmemberObj.FCHK_Territory__c;
                            acc.FCHK_District__c = cmemberObj.FCHK_District__c;
                            accountList.add(acc);
                        }
    if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c!=trigger.oldMap.get(cmemberObj.id).FCHK_CM_Status__c 
            && cmemberObj.ContactId!=null && contactMap.get(cmemberObj.contactId)!=null 
                && contactMap.get(cmemberObj.contactId).Account.RecordType.DeveloperName=='FCHK_MR_RT_Optimel'){
	                    if(cmemberObj.FCHK_Flat__c==null && cmemberObj.FCHK_Floor__c==null 
	                    	&& cmemberObj.FCHK_Block__c==null 
	                    	&& cmemberObj.FCHK_Building__c==null 
	                    	&& cmemberObj.FCHK_Estate__c==null 
	                    	&& cmemberObj.FCHK_Street__c==null 
	                    	&& cmemberObj.FCHK_Territory__c==null 
	                    	&& cmemberObj.FCHK_District__c==null && cmemberObj.FCHK_Billing_Address__c==true){
	                    		
	                    	String billingAddress = (contactMap.get(cmemberObj.ContactId).Account.FCHK_Flat__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_Flat__c:'')+' '+
							+(contactMap.get(cmemberObj.ContactId).Account.FCHK_Floor__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_Floor__c:'')+' '+
							+(contactMap.get(cmemberObj.ContactId).Account.FCHK_Block__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_Block__c:'')+
							+'\n'+(contactMap.get(cmemberObj.ContactId).Account.FCHK_Building__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_Building__c:'') +'\n'+
							+(contactMap.get(cmemberObj.ContactId).Account.FCHK_Estate__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_Estate__c:'')+' '+
							+(contactMap.get(cmemberObj.ContactId).Account.FCHK_Street__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_Street__c:'')+
							+'\n'+(contactMap.get(cmemberObj.ContactId).Account.FCHK_District__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_District__c:'')+
							+'\n'+(contactMap.get(cmemberObj.ContactId).Account.FCHK_Territory__c!=null?contactMap.get(cmemberObj.ContactId).Account.FCHK_Territory__c:'');
	                    	if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'Sample Accepted' &&  cmemberObj.FCHK_Sample_Product__c == 'Optimel Gold')
		                     {
		                        system.debug('Enter the condition for testing');
		                        Order ord = new Order();                        
		                        ord.AccountId=contactMap.get(cmemberObj.ContactId).AccountId;
		                        ord.recordTypeId=orderRecordTypeMap.get('FCHK_RT_Sample_Request').id;
		                        ord.FCHK_Product__c=cmemberObj.FCHK_Sample_Product__c;
		                        ord.FCHK_Same_as_BillingAddress__c=true;
		                        ord.EffectiveDate = Date.Today();
		                        ord.FCHK_Flat__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Flat__c;
		                        ord.FCHK_Floor__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Floor__c;
		                        ord.FCHK_Block__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Block__c;
		                        ord.FCHK_Building__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Building__c;
		                        ord.FCHK_Estate__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Estate__c;
		                        ord.FCHK_Street__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Street__c;
		                        ord.FCHK_Territory__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Territory__c;
		                        ord.FCHK_District__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_District__c;
		                        ord.Status = 'In Progress';        
		                        ord.FCHK_Billing_Address1__c=billingAddress;                
		                        orderList.add(ord);
		                    }                                                
		                    else if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'Sample Accepted' &&  cmemberObj.FCHK_Sample_Product__c == 'Optimel Silver')
		                    {
		                         system.debug('Enter the else if condition');
	                         	Order ord = new Order();
	                         	ord.AccountId=contactMap.get(cmemberObj.ContactId).AccountId;
	                         	ord.recordTypeId=orderRecordTypeMap.get('FCHK_RT_Sample_Request').id;
	                         	ord.FCHK_Product__c=cmemberObj.FCHK_Sample_Product__c;
	                         	ord.FCHK_Same_as_BillingAddress__c=true;
	                         	ord.EffectiveDate = Date.Today();
	                         	ord.FCHK_Flat__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Flat__c;
                        		ord.FCHK_Floor__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Floor__c;
	                        	ord.FCHK_Block__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Block__c;
	                        	ord.FCHK_Building__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Building__c;
	                        	ord.FCHK_Estate__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Estate__c;
	                        	ord.FCHK_Street__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Street__c;
	                        	ord.FCHK_Territory__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Territory__c;
	                        	ord.FCHK_District__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_District__c;
	                         	ord.Status = 'In Progress';
	                         	ord.FCHK_Billing_Address1__c=billingAddress;    
	                        	orderList.add(ord);                      
		                    }                                                   
		                    else if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'Sample Accepted' &&  cmemberObj.FCHK_Sample_Product__c == 'Optimel Diamond')
		                    {
		                         system.debug('Enter the else  condition');
		                         Order ord = new Order();
		                         ord.AccountId=contactMap.get(cmemberObj.ContactId).AccountId;
		                         ord.recordTypeId=orderRecordTypeMap.get('FCHK_RT_Sample_Request').id;
		                         ord.FCHK_Product__c=cmemberObj.FCHK_Sample_Product__c;
		                         ord.FCHK_Same_as_BillingAddress__c=true;
		                         ord.EffectiveDate = Date.Today();
		                         ord.FCHK_Flat__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Flat__c;
		                       	 ord.FCHK_Floor__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Floor__c;
	                        	 ord.FCHK_Block__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Block__c;
		                         ord.FCHK_Building__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Building__c;
		                         ord.FCHK_Estate__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Estate__c;
		                         ord.FCHK_Street__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Street__c;
		                         ord.FCHK_Territory__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_Territory__c;
		                         ord.FCHK_District__c = contactMap.get(cmemberObj.ContactId).Account.FCHK_District__c;
		                         ord.Status = 'In Progress';
		                         ord.FCHK_Billing_Address1__c=billingAddress;    
		                         
		                        orderList.add(ord);                           
		                    }
	                    }
	                    else{
	                    
		                    if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'Sample Accepted' &&  cmemberObj.FCHK_Sample_Product__c == 'Optimel Gold')
		                     {
		                        system.debug('Enter the condition for testing');
		                        Order ord = new Order();                        
		                        ord.AccountId=contactMap.get(cmemberObj.ContactId).AccountId;
		                        ord.recordTypeId=orderRecordTypeMap.get('FCHK_RT_Sample_Request').id;
		                        ord.FCHK_Product__c=cmemberObj.FCHK_Sample_Product__c;
		                        //ord.FCHK_Same_as_BillingAddress__c=true;
		                        ord.EffectiveDate = Date.Today();
		                        ord.FCHK_Flat__c = cmemberObj.FCHK_Flat__c;
		                        ord.FCHK_Floor__c = cmemberObj.FCHK_Floor__c;
		                        ord.FCHK_Block__c = cmemberObj.FCHK_Block__c;
		                        ord.FCHK_Building__c = cmemberObj.FCHK_Building__c;
		                        ord.FCHK_Estate__c = cmemberObj.FCHK_Estate__c;
		                        ord.FCHK_Street__c = cmemberObj.FCHK_Street__c;
		                        ord.FCHK_Territory__c = cmemberObj.FCHK_Territory__c;
		                        ord.FCHK_District__c = cmemberObj.FCHK_District__c;
		                        ord.Status = 'In Progress';   
		                        //ord.FCHK_Billing_Address1__c=billingAddress;                         
		                        orderList.add(ord);
		                    }                                                
		                    else if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'Sample Accepted' &&  cmemberObj.FCHK_Sample_Product__c == 'Optimel Silver')
		                    {
		                         system.debug('Enter the else if condition');
		                         Order ord = new Order();
		                       
		                         ord.AccountId=contactMap.get(cmemberObj.ContactId).AccountId;
		                         ord.recordTypeId=orderRecordTypeMap.get('FCHK_RT_Sample_Request').id;
		                         ord.FCHK_Product__c=cmemberObj.FCHK_Sample_Product__c;
		                         //ord.FCHK_Same_as_BillingAddress__c=true;
		                         ord.EffectiveDate = Date.Today();
		                         ord.FCHK_Flat__c = cmemberObj.FCHK_Flat__c;
		                        ord.FCHK_Floor__c = cmemberObj.FCHK_Floor__c;
		                        ord.FCHK_Block__c = cmemberObj.FCHK_Block__c;
		                        ord.FCHK_Building__c = cmemberObj.FCHK_Building__c;
		                        ord.FCHK_Estate__c = cmemberObj.FCHK_Estate__c;
		                        ord.FCHK_Street__c = cmemberObj.FCHK_Street__c;
		                        ord.FCHK_Territory__c = cmemberObj.FCHK_Territory__c;
		                        ord.FCHK_District__c = cmemberObj.FCHK_District__c;
		                         ord.Status = 'In Progress';
		                         //ord.FCHK_Billing_Address1__c=billingAddress;    
		                         
		                        orderList.add(ord);                      
		                    }                                                   
		                    else if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'Sample Accepted' &&  cmemberObj.FCHK_Sample_Product__c == 'Optimel Diamond')
		                    {
		                         system.debug('Enter the else  condition');
		                         Order ord = new Order();
		                        
		                         ord.AccountId=contactMap.get(cmemberObj.ContactId).AccountId;
		                         ord.recordTypeId=orderRecordTypeMap.get('FCHK_RT_Sample_Request').id;
		                         ord.FCHK_Product__c=cmemberObj.FCHK_Sample_Product__c;
		                         //ord.FCHK_Same_as_BillingAddress__c=true;
		                         ord.EffectiveDate = Date.Today();
		                         ord.FCHK_Flat__c = cmemberObj.FCHK_Flat__c;
		                        ord.FCHK_Floor__c = cmemberObj.FCHK_Floor__c;
		                        ord.FCHK_Block__c = cmemberObj.FCHK_Block__c;
		                        ord.FCHK_Building__c = cmemberObj.FCHK_Building__c;
		                        ord.FCHK_Estate__c = cmemberObj.FCHK_Estate__c;
		                        ord.FCHK_Street__c = cmemberObj.FCHK_Street__c;
		                        ord.FCHK_Territory__c = cmemberObj.FCHK_Territory__c;
		                        ord.FCHK_District__c = cmemberObj.FCHK_District__c;
		                         ord.Status = 'In Progress';
		                         //ord.FCHK_Billing_Address1__c=billingAddress;    
		                         
		                        orderList.add(ord);                           
		                    }
	                 }                              
                    if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'No Response')
                    {
                         system.debug('Enter the condition for testing');
                         Task task = new Task();
                         task.WhatId=contactMap.get(cmemberObj.ContactId).AccountId;
                         task.recordTypeId=taskRecordTypeMap.get('Sample_Invitation_Outbound_Call').id;
                         task.FCHK_Product_Name__c=cmemberObj.FCHK_Sample_Product__c;
                         task.Status = 'In Progress';
                         task.Subject = 'Sample invitation Outbound call';
                         task.Description='Please contact the Member, update Operator Name and the Status.';
                         taskList.add(task);
                    }
                                                
                    else if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'No Response')
                    {
                         system.debug('Enter the if condition');
                         Task task = new Task();
                         task.WhatId=contactMap.get(cmemberObj.ContactId).AccountId;
                         task.recordTypeId=taskRecordTypeMap.get('Sample_Invitation_Outbound_Call').id;
                         task.FCHK_Product_Name__c=cmemberObj.FCHK_Sample_Product__c;
                         task.Status = 'In Progress';
                         task.Subject = 'Sample invitation Outbound call';
                         task.Description='Please contact the Member, update Operator Name and the Status.';
                         taskList.add(task);
                                       
                    }                                                   
                    else if(trigger.newMap.get(cmemberObj.id).FCHK_CM_Status__c == 'No Response')
                    {
                         system.debug('Enter the if condition');
                         Task task = new Task();
                         task.WhatId=contactMap.get(cmemberObj.ContactId).AccountId;
                         task.recordTypeId=taskRecordTypeMap.get('Sample_Invitation_Outbound_Call').id;
                         task.FCHK_Product_Name__c=cmemberObj.FCHK_Sample_Product__c;
                         task.Status = 'In Progress';
                         task.Subject = 'Sample invitation Outbound call';
                         task.Description='Please contact the Member, update Operator Name and the Status.';
                         taskList.add(task);
                                       
                    }
                                                   
        }
  }
 
  if(orderList!=null && orderList.size()>0){
        insert orderList;
  }
  if(taskList!=null && taskList.size()>0){
        insert taskList;
  }
  if(accountList!=null && accountList.size()>0){
        update accountList;
  }
  
        }