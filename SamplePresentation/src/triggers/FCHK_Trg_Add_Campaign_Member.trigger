trigger FCHK_Trg_Add_Campaign_Member on Account (after insert,after update) {

    Set<Id> ConId = new Set<Id>();
    Set<Id> RefId = new Set<Id>();
    List<Account> ContactLst = new List<Account>();    
    //List<Account> UpdateAccLst = new List<Account>(); 
    List<CampaignMember> InsertCampMemLst = new List<CampaignMember>();
    Id CampId;
    integer count=0;
    RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
    Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
    Set<Id> referedByAccountIdSet = new Set<Id>();
    Map<id,List<Account>> referActAccountListMap = new Map<Id,List<Account>>();
    Map<id,Account> accountMap = new Map<id,Account>();
    
    for(Account Con : Trigger.new){
        if(trigger.isInsert && trigger.isAfter){
            if(recordTypeMapAcc.get(Con.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel'){
                ConId.add(Con.Id);
            }
            if(recordTypeMapAcc.get(Con.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel' && con.FCHK_Referred_By__c!=null){
                referedByAccountIdSet.add(con.FCHK_Referred_By__c);
            }
            
        }
        else if(trigger.isUpdate && trigger.isAfter){
            if(recordTypeMapAcc.get(Con.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel' && 
                (((Con.Recruitment_Source__c=='Member Referral' || Con.Recruitment_Source__c=='Staff Referral' || (Con.Recruitment_Source__c=='Clinic Referral')) 
                && Trigger.newMap.get(Con.Id).Recruitment_Source__c!=Trigger.oldMap.get(Con.Id).Recruitment_Source__c) 
                || (trigger.newMap.get(con.Id).FCHK_Referred_By__c!=trigger.oldMap.get(con.id).FCHK_Referred_By__c))){
                ConId.add(Con.Id);
                system.debug('--In Update call--');
                if(trigger.newmap.get(con.id).FCHK_Referred_By__c!=null){
                    referedByAccountIdSet.add(trigger.newmap.get(con.id).FCHK_Referred_By__c);
                }
                if(trigger.oldMap.get(con.id).FCHK_Referred_By__c!=null){
                    referedByAccountIdSet.add(trigger.oldMap.get(con.id).FCHK_Referred_By__c);
                }
            }
        }
    }
    System.debug('referedByAccountIdSet@@:'+referedByAccountIdSet);
    
    if(referedByAccountIdSet!=null && referedByAccountIdSet.size()>0){
        for(Account actObj:[select id,name,FCHK_Referred_By__c from Account where FCHK_Referred_By__c in:referedByAccountIdSet]){
            if(referActAccountListMap.get(actObj.FCHK_Referred_By__c)!=null){
                referActAccountListMap.get(actObj.FCHK_Referred_By__c).add(actObj);
            }
            else{
                referActAccountListMap.put(actObj.FCHK_Referred_By__c,new List<Account>{actObj});
            }
        }
        System.debug('referActAccountListMap@@:'+referActAccountListMap);
        for(Id actId:referedByAccountIdSet){
            if(referActAccountListMap.get(actId)==null){
                    referActAccountListMap.put(actId,new list<Account>{});
            }
        }
        
        for(Id actId:referedByAccountIdSet){
            System.debug('referActAccountListMap.get(actId)@@:'+referActAccountListMap.get(actId));
            if(referActAccountListMap.get(actId)!=null){
                    Account actObj = new Account(id=actid,FCHK_Referral_Count__c=referActAccountListMap.get(actId).size(),FCHK_Referred_On__c = Date.today());
                    accountMap.put(actObj.id,actObj);
            }
        }
        if(accountMap!=null && accountMap.size()>0){
        //RefAcc.FCHK_Referred_On__c = Date.today();
            update accountMap.values();
        }
        
    }    
    if(ConId != null)
        ContactLst = [select Id,Recruitment_Source__c,Member_Id__c,FCHK_Member_Age__c, PersonEmail,PersonHomePhone,PersonMobilePhone,
                  Member_Login_Name__c,FCHK_Territory__c,FCHK_Referred_By__c,FCHK_Referred_On__c,FCHK_Reject_SMS__c,PersonHasOptedOutOfEmail  from Account where Id In : ConId];
                  
    List<Contact> ContLst = [select id,AccountId from Contact where AccountId = :ConId];          //ContactLst[0].PersonMobilePhone];
    
    List<Campaign> CampLst = [select id, name, FCHK_Recruitment_Source__c, FCHK_Sample__c, Type from Campaign where name like 'Referral%' and IsActive=true];
             system.debug('--CampLst--'+CampLst+'-----size--'+CampLst.size());     
    
    if(ContactLst.size()>0){
    for(Account Cont : ContactLst){
        RefId.add(Cont.FCHK_Referred_By__c);
    }
   //List<Account> RefaccLst = [select id,FCHK_Referral_Count__c,FCHK_Referred_On__c from Account where id in :RefId];
    
    
    if(ContactLst.size()>0){        
                  
    
    for(Account Acc : ContactLst){
        for(Contact Cont : ContLst){
            if(Cont.AccountId == Acc.Id){
                CampaignMember CM = new CampaignMember();
                for(Campaign camp : CampLst){
                
                if((acc.PersonEmail != null && acc.PersonMobilePhone != null && acc.PersonHasOptedOutOfEmail==false) || (acc.PersonEmail != null && acc.PersonHasOptedOutOfEmail==false) || (acc.PersonEmail != null && acc.PersonHomePhone != null 
                && acc.PersonHasOptedOutOfEmail==false) )
                   {
                       
                        if(camp.Type=='Email')
                    {
                        
                        CampId=camp.id;
                        
                    }
                   }
                
                
                    
                   else if(acc.PersonMobilePhone != null && acc.FCHK_Reject_SMS__c==false)
                {
                    
                    if(camp.Type=='SMS')
                    {
                        
                        CampId=camp.id;
                        
                    }
                    
                } 
                   
                   
                    
                    
            }
                    
            
            if(CampId!=null){
                CM.ContactId = Cont.Id;               
                CM.CampaignId = CampId;
                CM.Status = 'Selected';                        
                system.debug('--CM--'+CM);
                InsertCampMemLst.add(CM);
                
                
            }
            /*
           for(Account RefAcc : RefaccLst){
                    if(RefAcc.id == Acc.FCHK_Referred_By__c){
                    system.debug('Check RefaccLst condition');
                        
                       if(RefAcc.FCHK_Referral_Count__c!=null && RefAcc.FCHK_Referral_Count__c>0){
                            system.debug('Check if condition');
                            RefAcc.FCHK_Referral_Count__c = RefAcc.FCHK_Referral_Count__c + 1;
                            
                        }
                        else if(RefAcc.FCHK_Referral_Count__c==0){
                        system.debug('Check else condition');
                            RefAcc.FCHK_Referral_Count__c = 1;
                        }
                            RefAcc.FCHK_Referred_On__c = Date.today();
                            system.debug('Check last condition');
                        UpdateAccLst.add(RefAcc);
                    }
                                        
                }*/
            }
        }
    }            
    }  
    

    if(InsertCampMemLst.size()>0) {
     //   insert InsertCampMemLst;
        database.insert(InsertCampMemLst,false);
    }
        
   /* if(UpdateAccLst.size() > 0){
    //AppLiteralscls.stopAccountAction=true;
        update UpdateAccLst;
        }
        */

    }


}