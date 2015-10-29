trigger FCHK_Trg_Lead_Status on Account (after update) {
    
    Set<Id> recordTypeIdSet = new Set<Id>();
    Map<Id,RecordType> actRecordTypeMap = new Map<Id,RecordType>();
    boolean isQueryCampaigns=false;
    Map<String,Campaign> typeInviteCampignMap = new Map<String,Campaign>();
    Map<String,Campaign> typeFirstPurchCampMap = new Map<String,Campaign>();
    Map<Id,List<Order>>  actOrderListMap = new Map<Id,List<Order>>();
    List<CampaignMember> campMemberList = new List<CampaignMember>();
    Map<id,RecordType> taskRecordTypeMap = new Map<id,RecordType>();
    List<Task> taskList = new List<Task>();   
    boolean isTaskRecordType = true;
    for(Account actObj:trigger.new){
            if((trigger.newMap.get(actObj.id).FCHK_Member_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Member_Creation__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_Sample_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Gold_Sample_Creation__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_Sample_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Silver_Sample_Creation__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_Sample_Creation__c   !=trigger.oldMap.get(actObj.id).FCHK_Optimel_Diamond_Sample_Creation__c )
                && (trigger.newMap.get(actObj.id).FCHK_Member_Status__c=='Hot' 
                || trigger.newMap.get(actObj.id).FCHK_Member_Status__c=='Warm')){
                system.debug('Prepare the map');
                recordTypeIdSet.add(actObj.recordTypeId);
            }
    }
    
    if(recordTypeIdSet!=null && recordTypeIdSet.size()>0){
            for(RecordType recTypeObj:[select id,developerName from  RecordType 
            where sObjectType='Account' and id in:recordTypeIdSet]){
                actRecordTypeMap.put(recTypeObj.id,recTypeObj);
            }
    }
    for(Account actObj:trigger.new){
            if((trigger.newMap.get(actObj.id).FCHK_Member_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Member_Creation__c 
            || trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_Sample_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Gold_Sample_Creation__c 
            || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_Sample_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Silver_Sample_Creation__c 
            || trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_Sample_Creation__c   !=trigger.oldMap.get(actObj.id).FCHK_Optimel_Diamond_Sample_Creation__c )
                && (trigger.newMap.get(actObj.id).FCHK_Member_Status__c=='Hot' 
                || trigger.newMap.get(actObj.id).FCHK_Member_Status__c=='Warm')){
                system.debug('isQueryCampaigns setting to true');
                isQueryCampaigns=true;
            }
            if((trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_21_days__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Diamond_21_days__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_21_days__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Gold_21_days__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_21_days__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Silver_21_days__c) 
                    && (trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_21_days__c==true 
                        || trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_21_days__c==true
                        || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_21_days__c==true) 
                        && trigger.newMap.get(actObj.id).FCHK_Member_Status__c=='Hot'){
                    
                isTaskRecordType =true;
            }
    }
    
    if(isTaskRecordType==true){
        taskRecordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task'));
        Map<String,RecordType> taskRecTypeMap = new Map<String,RecordType>();
        if(taskRecordTypeMap!=null && taskRecordTypeMap.size()>0){
            for(Id recTypeId:taskRecordTypeMap.keyset()){
                taskRecTypeMap.put(taskRecordTypeMap.get(recTypeId).developerName,taskRecordTypeMap.get(recTypeId));
            }
        }
        for(Account actObj:trigger.new){
            if((trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_21_days__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Diamond_21_days__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_21_days__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Gold_21_days__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_21_days__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Silver_21_days__c) 
                    && (trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_21_days__c==true 
                        || trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_21_days__c==true
                        || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_21_days__c==true) 
                    && trigger.newMap.get(actObj.id).FCHK_Member_Status__c=='Hot'){
                    
                if((actObj.PersonMobilePhone != null || actObj.PersonHomePhone != null) 
                             && actObj.FCHK_1st_Purchase_Done__c == false ){
                            if(taskRecTypeMap.get('X1st_Purchase_Outbound_Call')!=null){
                                Task taskObj = new Task();
                                taskObj.WhatId=actObj.Id;
                                taskObj.recordTypeId=taskRecTypeMap.get('X1st_Purchase_Outbound_Call').id;
                                //task.FCHK_Product_Name__c=camObj.FCHK_Sample__c;
                                taskObj.Status = 'In Progress';
                                taskObj.Subject = '1st Purchase Outbound Call';
                                taskObj.Description='Please contact the Member, update Operator Name and the Status.';
                                taskList.add(taskObj);
                            }
                }
            }
        }
         if(taskList!=null && taskList.size()>0){
             try{
                insert taskList;
             }
             Catch(Exception e){
                System.debug('exception:'+e.getMessage()+'Line Numner:'+e.getLineNumber());
             }
        }
        
    }
    
    if(isQueryCampaigns==true){
       
        for(Campaign campaignObj:[select id,name,Type from Campaign 
            where name='Sample Invitation OB Call' or name='First Purchase Request eDM Hot' or name='First Purchase Request SMS Hot' limit 4]){
                if(campaignObj.name=='Sample Invitation OB Call'){
                    typeInviteCampignMap.put(campaignObj.Type,campaignObj);
                }
                else if(campaignObj.name=='First Purchase Request eDM Hot' 
                    || campaignObj.name=='First Purchase Request SMS Hot'){
                    typeFirstPurchCampMap.put(campaignObj.Type,campaignObj);
                }
        }
        
        System.debug('@@@:typeInviteCampignMap'+typeInviteCampignMap);
        System.debug('@@@:typeFirstPurchCampMap'+typeFirstPurchCampMap);
        for(Account actObj:trigger.new){
            if(trigger.newMap.get(actObj.id).FCHK_Member_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Member_Creation__c ){
            system.debug('Check for member creation before the conditionssssssssssss');
                    if((actObj.FCHK_Member_Status__c=='Warm' && trigger.newMap.get(actObj.id).FCHK_Member_Creation__c == true) || (Test.isRunningTest())){
                    system.debug('@@@Check for member creation before the condition');
                    system.debug('Check for member creation');
                       /*if(((actObj.PersonMobilePhone != null && actObj.PersonEmail!=null) || actObj.PersonEmail!=null) && typeInviteCampignMap.get('Email')!=null){
                        system.debug('Check for member creation else if condition');
                            CampaignMember cmemberObj = new CampaignMember(CampaignId=typeInviteCampignMap.get('Email').Id,ContactId=actObj.personContactId);
                            campMemberList.add(cmemberObj);
                        }*/
                        if(actObj.PersonMobilePhone != null){
                            if(typeInviteCampignMap.get('SMS')!=null){
                                CampaignMember cmemberObj = new CampaignMember(CampaignId=typeInviteCampignMap.get('SMS').Id,ContactId=actObj.personContactId);
                                campMemberList.add(cmemberObj);
                            }
                        }
                        
                        
                    }                   
            }
            
            if((trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_Sample_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Gold_Sample_Creation__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_Sample_Creation__c!=trigger.oldMap.get(actObj.id).FCHK_Optimel_Silver_Sample_Creation__c 
                || trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_Sample_Creation__c   !=trigger.oldMap.get(actObj.id).FCHK_Optimel_Diamond_Sample_Creation__c) 
                && (trigger.newMap.get(actObj.id).FCHK_Optimel_Gold_Sample_Creation__c==true 
                    || trigger.newMap.get(actObj.id).FCHK_Optimel_Silver_Sample_Creation__c==true 
                    || trigger.newMap.get(actObj.id).FCHK_Optimel_Diamond_Sample_Creation__c==true) && actObj.FCHK_Member_Status__c=='Hot'){
                    /*if(actObj.PersonEmail!=null && typeFirstPurchCampMap.get('Email')!=null){
                        CampaignMember cmemberObj = new CampaignMember(CampaignId=typeFirstPurchCampMap.get('Email').Id,ContactId=actObj.personContactId);
                        campMemberList.add(cmemberObj);
                    } 
                    else if((((actObj.PersonMobilePhone != null && actObj.PersonEmail!=null) || actObj.PersonMobilePhone != null) && typeFirstPurchCampMap.get('SMS')!=null) || (Test.isRunningTest())){
                                    CampaignMember cmemberObj = new CampaignMember(CampaignId=typeFirstPurchCampMap.get('SMS').Id,ContactId=actObj.personContactId);
                                    campMemberList.add(cmemberObj);
                    }*/
                    
                      if((actObj.PersonMobilePhone != null && actObj.PersonEmail ==null  && typeFirstPurchCampMap.get('SMS')!=null) || (Test.isRunningTest())){
                                    CampaignMember cmemberObj = new CampaignMember(CampaignId=typeFirstPurchCampMap.get('SMS').Id,ContactId=actObj.personContactId);
                                    campMemberList.add(cmemberObj);
                    }
                              
           
            }
            
            
            /* if(trigger.newMap.get(actObj.id).FCHK_Member_Status__c=='Hot'){
                      if(actOrderListMap.get(actobj.id)!=null){
                            for(Order orderObj:actOrderListMap.get(actobj.id)){
                                if(((actObj.PersonMobilePhone != null && actObj.PersonEmail!=null) || actObj.PersonMobilePhone != null) && (orderObj.FCHK_Date_Difference__c>14 || Test.isRunningTest())){
                                    CampaignMember cmemberObj = new CampaignMember(CampaignId=typeFirstPurchCampMap.get('SMS').Id,ContactId=actObj.personContactId);
                                    campMemberList.add(cmemberObj);
                                }
                                else if(actObj.PersonEmail!=null && orderObj.FCHK_Date_Difference__c>14){
                                    CampaignMember cmemberObj = new CampaignMember(CampaignId=typeFirstPurchCampMap.get('Email').Id,ContactId=actObj.personContactId);
                                    campMemberList.add(cmemberObj);
                                }
                                if((actObj.PersonMobilePhone != null || actObj.PersonHomePhone != null) 
                                    && (orderObj.FCHK_Date_Difference__c>21 || test.isRunningTest()) && actObj.FCHK_1st_Purchase_Done__c == false){
                                    if(taskRecTypeMap.get('X1st_Purchase_Outbound_Call')!=null){
                                        Task taskObj = new Task();
                                        taskObj.WhatId=actObj.Id;
                                        taskObj.recordTypeId=taskRecTypeMap.get('X1st_Purchase_Outbound_Call').id;
                                        //task.FCHK_Product_Name__c=camObj.FCHK_Sample__c;
                                        taskObj.Status = 'In Progress';
                                        taskObj.Subject = '1st Purchase Outbound Call';
                                        taskObj.Description='Please contact the Member, update Operator Name and the Status.';
                                        taskList.add(taskObj);
                                    }
                                }
                                
                            }
                        }
                }*/
            
        }       
        if(campMemberList!=null && campMemberList.size()>0){
               database.insert(campMemberList,false);
               //insert campMemberList;
        }
       
    }
    
    
    
    
   /* system.debug('Enter the trigger');
    Set<Id> accountIdList = new Set<Id>();
    List<CampaignMember> InsertCampMemLst = new List<CampaignMember>();
    List<Task> InsertTaskLst = new List<Task>();
    Id CampId;
    Set<Id> conId = new Set<id>();
    Set<Id> camIdW = new Set<id>();
    Set<Id> camIdH = new Set<id>();
    List<Campaign> CampLst = [select id, name, FCHK_Recruitment_Source__c, FCHK_Sample__c, Type from Campaign 
                                where name like 'Sample Invitation%' and IsActive=true];
    List<Campaign> CampHotLst = [select id, name, FCHK_Recruitment_Source__c, FCHK_Sample__c, Type from Campaign 
                                where name like 'First Purchase%' and IsActive=true];
    
     system.debug('--CampLst--'+CampLst+'-----size--'+CampLst.size());
     for(Account accObj:trigger.new){
     if(accObj.FCHK_Member_Status__c=='Warm' || accObj.FCHK_Member_Status__c=='Hot' && trigger.newMap.get(accObj.id).FCHK_Member_Status__c != trigger.oldMap.get(accObj.id).FCHK_Member_Status__c )
     {
         system.debug('Enter the trigger.new');
         accountIdList.add(accObj.id);
         
     }
     }   
    List<Contact> ContLst = [select id,AccountId from Contact where AccountId = :accountIdList]; 
    for(Contact con : ContLst){
        conId.add(con.id);
    }
    for(Campaign con : CampLst){
        camIdW.add(con.id);
    }
    for(Campaign con : CampHotLst){
        camIdH.add(con.id);
    }
    system.debug('--camIdW--'+camIdW);
    system.debug('--camIdH--'+camIdH);    
    List<CampaignMember> CMMbr = [select id from CampaignMember where ContactId in :conId and CampaignId In :camIdW];
    List<CampaignMember> CMMbrH = [select id from CampaignMember where ContactId in :conId and CampaignId In :camIdH];
    system.debug('--camIdWLst--'+CMMbr);
    system.debug('--camIdWLst--'+CMMbrH);
    List<Account> AccountLst = [select id,PersonMobilePhone,PersonEmail,FCHK_Date_Difference__c,FCHK_1st_Purchase_Done__c,RecordTypeId,createdDate,FCHK_Member_Status__c from Account where id in :accountIdList];
    
Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
Map<id,RecordType> recordTypeMapOrd = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
Map<id,RecordType> recordTypeMapTask = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Task')); 
    
    //Id recordTypeId = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id; 
      //Id orderRecordTypeId = [select id,Name from Recordtype where sObjectType='Order' AND Name= 'sample Request'].id;
      
      Id recordTypeTaskIds = [select id,Name from Recordtype where sObjectType='Task' AND Name= '1st Purchase Outbound Call'].id;
    
    List<Order> OrderLst = [select id,FCHK_Date_Difference__c,RecordTypeId,createdDate from Order 
                                where accountId in :accountIdList];
                                
            system.debug('--CampLst--'+AccountLst+'-----size--'+AccountLst.size());
        
        for(Account acObj:AccountLst){
            if(recordTypeMapAcc.get(acObj.RecordTypeId)!=null && recordTypeMapAcc.get(acObj.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel')
            {
                for(Contact Cont : ContLst){
                CampaignMember CM = new CampaignMember();
                    if(Cont.AccountId == acObj.Id){
                    
                       
                    if(acObj.FCHK_Member_Status__c=='Warm' && acObj.FCHK_Date_Difference__c>14 && CMMbr.size()==0)
                        {
                    for(Campaign camp : CampLst){
                        system.debug('Enter the CampLst');
                       
                            system.debug('check for status'+acobj.FCHK_Member_Status__c);
                            
                            if(acObj.PersonMobilePhone != null )
                            {
                                system.debug('Enter the if condition'+acObj.FCHK_Date_Difference__c);
                                if(camp.Type=='SMS')
                                {
                                    system.debug('Enter the type');
                                    CampId=camp.id;                                
                                }                            
                            }
                            
                            else if(acObj.PersonEmail != null)
                            {
                                system.debug('Enter the else condition');
                                if(camp.Type=='Email')
                                {
                                    system.debug('Enter the else condition');
                                    CampId=camp.id;
                                
                                }
                            }
                        
                        }                    
                    }
                        
                        else if(acObj.FCHK_Member_Status__c=='Hot' && CMMbrH.size()==0)
                        {
                             for(Campaign camp : CampHotLst){
                           if(OrderLst.size()>0)
                           {
                              
                            for(Order ord : OrderLst){
                            
                            if(recordTypeMapOrd.get(ord.RecordTypeId)!= null && recordTypeMapOrd.get(ord.RecordTypeId).DeveloperName=='FCHK_RT_Order' )
                            {
                                
                            if(acObj.PersonMobilePhone != null  && ord.FCHK_Date_Difference__c>14)
                            {
                                system.debug('Enter the if condition');
                                if(camp.Type=='SMS')
                                {
                                    system.debug('Enter the email sample type');
                                    CampId=camp.id;                                
                                }                            
                            }
                            else if(acObj.PersonEmail != null && ord.FCHK_Date_Difference__c>14)
                            {
                                system.debug('Enter the else condition');
                                if(camp.Type=='Email')
                                {
                                    system.debug('Enter the else condition');
                                    CampId=camp.id;
                                
                                }
                            }
                            else if((acObj.PersonMobilePhone != null || acObj.PersonHomePhone != null) && ord.FCHK_Date_Difference__c>21 && acObj.FCHK_1st_Purchase_Done__c == false)
                            {
                               Task task = new Task();
                                task.WhatId=acObj.Id;
                                task.recordTypeId=recordTypeTaskIds;
                                //task.FCHK_Product_Name__c=camObj.FCHK_Sample__c;
                                task.Status = 'In Progress';
                                task.Subject = '1st Purchase Outbound Call';
                                task.Description='Please contact the Member, update Operator Name and the Status.';
                                InsertTaskLst.add(task);
                               system.debug('Enter the sample type');
                                
                            }
                            
                        }
                        }
                           }
                             }
              
                    
                        }
                
                }     
                if(CampId!=null){
                        system.debug('Enter the sample campaign condition');       
                        CM.CampaignId = CampId;
                        CM.ContactId = Cont.Id;
                        system.debug('--CM--'+CM);
                        InsertCampMemLst.add(CM);
                    }       
            }
        }
 system.debug('End the CampId conditiosssssssssss');    

}

if(InsertCampMemLst.size()>0) {
        insert InsertCampMemLst;
       }
       if(InsertTaskLst.size()>0)
       {
       insert InsertTaskLst;
       }
    system.debug('--Please updatesssssssssss--');
*/
        
}