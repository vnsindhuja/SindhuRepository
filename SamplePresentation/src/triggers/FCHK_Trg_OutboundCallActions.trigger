trigger FCHK_Trg_OutboundCallActions on Task (after insert,after update,before insert) {
	
	if(trigger.isInsert && trigger.isAfter){
				FCHK_Cls_OutboundCallActionscls.updateMemberfrmOutboundCall(trigger.new);
	}
	if(trigger.isInsert && trigger.isBefore){
		FCHK_Cls_OutboundCallActionscls.updateOutboundCall(trigger.new);
	}
	if(trigger.isUpdate && trigger.isAfter){
		List<Task> taskList = new List<Task>();
		List<Task> orderTaskList = new List<Task>();
		for(Task taskObj:trigger.new){
				if(trigger.newMap.get(taskObj.id).FCHK_First_Purchase__c!=trigger.oldMap.get(taskObj.id).FCHK_First_Purchase__c
					&& trigger.newMap.get(taskObj.id).whatId!=null 
					&& trigger.newMap.get(taskObj.id).FCHK_First_Purchase__c == 'Claimed Purchase' 
					&& String.valueOf(trigger.newMap.get(taskObj.id).whatId).startsWith('001')){
						System.debug('first if entering....');
						taskList.add(taskObj);
				}
				if((trigger.newMap.get(taskObj.id).FCHK_Sample_Request__c!=trigger.oldMap.get(taskObj.id).FCHK_Sample_Request__c 
					|| trigger.newMap.get(taskObj.id).FCHK_Product_Name__c!=trigger.oldMap.get(taskObj.id).FCHK_Product_Name__c)
					&& trigger.newMap.get(taskObj.id).FCHK_Sample_Request__c=='Yes' 
					&&  trigger.newMap.get(taskObj.id).whatId!=null 
					&& String.valueOf(trigger.newMap.get(taskObj.id).whatId).startsWith('001')){
						orderTaskList.add(taskObj);
				}
		}
		if(taskList!=null && taskList.size()>0){
			 System.debug('if entering....'+taskList);
				FCHK_Cls_OutboundCallActionscls.updateMemberfrmOutboundCall(taskList);
		}
		if(orderTaskList!=null && orderTaskList.size()>0){
				System.debug('order craetion entering...');
				FCHK_Cls_OutboundCallActionscls.createSampleRequestfromOutboundcall(orderTaskList);
		}
	}
	
		
}