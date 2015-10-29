trigger FCHK_Update_Brand_Fields on Task (after insert, after update) {
    if(trigger.isInsert && trigger.isAfter){
        List<Task> taskList  = new List<Task>();
        for(Task taskObj:trigger.new){
            if(taskObj.FCHK_Consume_Remark__c!=null || taskObj.FCHK_Try_Remark__c!=null 
            || taskObj.FCHK_Sample_Request_Remark__c!=null || taskObj.FCHK_2nd_Purchase_Remark__c!=null 
            || taskObj.FCHK_Will_you_make_a_2nd_Purchase__c=='Yes'){
                taskList.add(taskObj);
            }
        }
        if(taskList!=null && taskList.size()>0){
        		System.debug('taskList@@:'+taskList);
                FCHK_Cls_OutboundCallActionscls.updateBrandonMember(taskList);
        }
    }
    if(trigger.isUpdate && trigger.isAfter){
        List<Task> taskList  = new List<Task>();
        for(Task taskObj:trigger.new){
            if((trigger.newMap.get(taskObj.id).FCHK_Consume_Remark__c!=trigger.oldMap.get(taskObj.id).FCHK_Consume_Remark__c 
            	&& trigger.newMap.get(taskObj.id).FCHK_Consume_Remark__c!=null)
             || (trigger.newMap.get(taskObj.id).FCHK_Try_Remark__c!=trigger.oldMap.get(taskObj.id).FCHK_Try_Remark__c 
             	&& trigger.newMap.get(taskObj.id).FCHK_Try_Remark__c!=null) || (trigger.newMap.get(taskObj.id).FCHK_Sample_Request_Remark__c!=trigger.oldMap.get(taskObj.id).FCHK_Sample_Request_Remark__c 
             	&& trigger.newMap.get(taskObj.id).FCHK_Sample_Request_Remark__c!=null) 
             	|| (trigger.newMap.get(taskObj.id).FCHK_2nd_Purchase_Remark__c!=trigger.oldMap.get(taskObj.id).FCHK_2nd_Purchase_Remark__c 
             	&& trigger.newMap.get(taskObj.id).FCHK_2nd_Purchase_Remark__c!=null) 
             	|| (trigger.newMap.get(taskObj.id).FCHK_Will_you_make_a_2nd_Purchase__c!=trigger.oldMap.get(taskObj.id).FCHK_Will_you_make_a_2nd_Purchase__c 
             		&& trigger.newMap.get(taskObj.id).FCHK_Will_you_make_a_2nd_Purchase__c=='Yes')){
                taskList.add(taskObj);
            }
        }
        if(taskList!=null && taskList.size()>0){
        	System.debug('taskList@@:'+taskList);
                FCHK_Cls_OutboundCallActionscls.updateBrandonMember(taskList);
        }
    }
    

}