trigger FCHK_Trg_Update_Account_Welcome_Greeting on CampaignMember (after update) {
    
    Set<Id> contactIdSet = new Set<Id>();
    Set<Id> campaigIdSet = new Set<Id>();
    Map<Id,Id> contIdActIdMap = new Map<Id,Id>();
    Map<Id,Campaign> campaignMap = new Map<Id,Campaign>();
    Map<Id,Account> accountMap = new Map<Id,Account>();
    if(trigger.isUpdate && trigger.isAfter){
        for(CampaignMember cmemberObj:trigger.new){
            if(trigger.newMap.get(cmemberObj.id).Status!=trigger.oldMap.get(cmemberObj.id).Status 
                && trigger.newMap.get(cmemberObj.id).Status == 'Sent' 
                && cmemberObj.contactId!=null){
                contactIdSet.add(cmemberObj.contactId);
                campaigIdSet.add(cmemberObj.CampaignId);
            }
        }
    }
    
    if(contactIdSet!=null && contactIdSet.size()>0){
        for(Contact contObj:[select id,AccountId from Contact where id in:contactIdSet]){
            if(contObj.AccountID!=null){
                contIdActIdMap.put(contObj.id,contObj.AccountId);
            }
        }
    }
    if(campaigIdSet!=null && campaigIdSet.size()>0){
        for(Campaign campaignObj:[select id,type from Campaign where id in:campaigIdSet]){
            campaignMap.put(campaignObj.id,campaignObj);
        }
        
    }
    
    if(trigger.isUpdate && trigger.isAfter){
        for(CampaignMember cmemberObj:trigger.new){
            if(trigger.newMap.get(cmemberObj.id).Status!=trigger.oldMap.get(cmemberObj.id).Status 
                && trigger.newMap.get(cmemberObj.id).Status == 'Sent' 
                && cmemberObj.contactId!=null && contIdActIdMap.get(cmemberObj.contactId)!=null){
                if(campaignMap.get(cmemberObj.CampaignId)!=null 
                    && campaignMap.get(cmemberObj.CampaignId).Type=='Email'){
                    Account actObj = new Account(id=contIdActIdMap.get(cmemberObj.contactId),FCHK_Welcome_Greeting_eDM__c=true);
                    accountMap.put(actObj.id,actObj);
                }
                else if(campaignMap.get(cmemberObj.CampaignId)!=null 
                    && campaignMap.get(cmemberObj.CampaignId).Type=='SMS'){
                    Account actObj = new Account(id=contIdActIdMap.get(cmemberObj.contactId),FCHK_Welcome_Greeting_SMS__c=true);
                    accountMap.put(actObj.id,actObj);
                }
            }
        }
    }
    
    if(accountMap!=null && accountMap.size()>0){
            AppLiteralscls.stopAccountAction=true;
            update accountMap.values();
        
    }
  
  
  
    
  /*  Set<Id> ConId = new Set<Id>();
    Set<String> AccId = new Set<String>();
    List<Account> accountLst = new List<Account>();
    List<Account> UpdateaccountLst = new List<Account>(); 
    List<CampaignMember> campMemLst = new List<CampaignMember>();
    
    
    for(CampaignMember Con : Trigger.new){
        ConId.add(Con.Id);                
        
    }
    
    campMemLst = [select Id,FCHK_CM_Status__c,Status,FCHK_Member_Id__c,Campaign.Type  from CampaignMember where Id In : ConId]; 
    
    for(CampaignMember CM : campMemLst){
        AccId.add(CM.FCHK_Member_Id__c);
    }
    
    accountLst = [select Id,Member_Id__c,FCHK_Welcome_Greeting_eDM__c,RecordTypeId from Account where Member_Id__c In : AccId];
    //Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
    
    Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
    
    for(CampaignMember CM : campMemLst){
            
            for(Account acc : accountLst){
            
            system.debug('--List--'+accountLst);
                if(CM.Status=='Sent' && recordTypeMapAcc.get(acc.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel' && CM.Campaign.Type == 'Email' && CM.FCHK_Member_Id__c == Acc.Member_Id__c  )
                {
                system.debug('Email greeting');
                    acc.FCHK_Welcome_Greeting_eDM__c=true;
                    UpdateaccountLst.add(acc);
                }
            
            
                if(CM.Status=='Sent' && recordTypeMapAcc.get(acc.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel' && CM.Campaign.Type == 'SMS' && CM.FCHK_Member_Id__c == Acc.Member_Id__c )
                {
                system.debug('SMS greeting');
                    acc.FCHK_Welcome_Greeting_SMS__c=true;
                    UpdateaccountLst.add(acc);
                }
            
             
}           
            
        }
    
    if(UpdateaccountLst.size()>0)
    {
    update UpdateaccountLst;
     }   */

}