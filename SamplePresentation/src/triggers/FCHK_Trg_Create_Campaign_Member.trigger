trigger FCHK_Trg_Create_Campaign_Member on Account (after insert) {

    Set<Id> ConId = new Set<Id>();
    List<Account> ContactLst = new List<Account>();    
    List<CampaignMember> InsertCampMemLst = new List<CampaignMember>();
    Id CampId;
    //RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
    Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
    
    
    for(Account Con : Trigger.new){
    
        if(recordTypeMapAcc.get(Con.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel')
            ConId.add(Con.Id);
    }
    
    if(ConId != null)
        ContactLst = [select Id,Recruitment_Source__c,Member_Id__c,FCHK_Member_Age_Num__c, PersonEmail,PersonHomePhone,PersonMobilePhone,
                  Member_Login_Name__c,FCHK_Territory__c,PersonHasOptedOutOfEmail,FCHK_Reject_SMS__c  from Account where Id In : ConId];
                  
    List<Contact> ContLst = [select id,AccountId from Contact where AccountId = :ConId];          //ContactLst[0].PersonMobilePhone];
    
    List<Campaign> CampLst = [select id, name, FCHK_Recruitment_Source__c, FCHK_Sample__c, Type from Campaign 
                                where name like 'New Member welcome message%' and IsActive=true];
             system.debug('--CampLst--'+CampLst+'-----size--'+CampLst.size());     
    if(ContactLst.size()>0){        
                  
   system.debug('-ContactLst-'+ContactLst);
    
    for(Account Acc : ContactLst){
        for(Contact Cont : ContLst){
            if(Cont.AccountId == Acc.Id){
                CampaignMember CM = new CampaignMember();
                for(Campaign camp : CampLst){
                
                if((Acc.Recruitment_Source__c == 'Website' || Acc.Recruitment_Source__c == 'Member Referral') && Acc.PersonEmail != null && Acc.personMobilePhone==null && acc.PersonHasOptedOutOfEmail==false)
                {
                    if(Acc.FCHK_Member_Age_Num__c == null  || Acc.FCHK_Member_Age_Num__c < 40){
                        if(camp.FCHK_Recruitment_Source__c=='Online' && camp.Type=='Email' && camp.FCHK_Sample__c=='All'){                        
                            CampId = camp.id;
                        }
                    }
                    else if(Acc.FCHK_Member_Age_Num__c >= 40 && Acc.FCHK_Member_Age_Num__c < 50 ){
                        if(camp.FCHK_Recruitment_Source__c=='Online' && camp.Type=='Email' && camp.FCHK_Sample__c=='Optimel Silver'){
                           CampId = camp.id;
                        }
                    }
                    else if(Acc.FCHK_Member_Age_Num__c >= 60 ){
                        if(camp.FCHK_Recruitment_Source__c=='Online' && camp.Type=='Email' && camp.FCHK_Sample__c=='Optimel Diamond'){
                            CampId = camp.id;
                        }
                    }
                    else if(Acc.FCHK_Member_Age_Num__c >= 50 && Acc.FCHK_Member_Age_Num__c < 60 ){
                        if(camp.FCHK_Recruitment_Source__c=='Online' && camp.Type=='Email' && camp.FCHK_Sample__c=='Optimel Gold'){
                            CampId = camp.id;
                        }
                    }
                    
                    
                     system.debug('--InsertCampMemLst--'+InsertCampMemLst);
                }
                else if((Acc.Recruitment_Source__c == 'Hotline' || Acc.Recruitment_Source__c=='Frisomum' || Acc.Recruitment_Source__c=='Event' || Acc.Recruitment_Source__c=='Clinics' || Acc.Recruitment_Source__c=='Mall Event' || Acc.Recruitment_Source__c=='Elderly Center' || Acc.Recruitment_Source__c=='Modern Trade' || Acc.Recruitment_Source__c=='Open Trade' ||Acc.Recruitment_Source__c=='Member Referral'||Acc.Recruitment_Source__c=='Clinic Referral'||Acc.Recruitment_Source__c=='Staff Referral'||
                    Acc.Recruitment_Source__c=='Roadshow'|| Acc.Recruitment_Source__c=='Others') && Acc.PersonEmail != null && Acc.PersonMobilePhone!=null && Acc.PersonHasOptedOutOfEmail==false && Acc.FCHK_Reject_SMS__c==false){
                         if(Acc.FCHK_Member_Age_Num__c == null  || Acc.FCHK_Member_Age_Num__c < 40){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='Email' && camp.FCHK_Sample__c=='All'){                        
                                CampId = camp.id;
                            }
                        }
                        else if(Acc.FCHK_Member_Age_Num__c >= 40 && Acc.FCHK_Member_Age_Num__c < 50 ){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='Email' && camp.FCHK_Sample__c=='Optimel Silver'){                        
                                CampId = camp.id;
                            }
                        }                       
                        else if(Acc.FCHK_Member_Age_Num__c >= 50 && Acc.FCHK_Member_Age_Num__c < 60 ){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='Email' && camp.FCHK_Sample__c=='Optimel Gold'){                        
                                CampId = camp.id;
                            }
                        }
                        else if(Acc.FCHK_Member_Age_Num__c >= 60 ){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='Email' && camp.FCHK_Sample__c=='Optimel Diamond'){                        
                                CampId = camp.id;
                            }
                        }
                           
                     system.debug('--InsertCampMemLst--'+InsertCampMemLst);       
                }
                else if((Acc.Recruitment_Source__c == 'Hotline' || Acc.Recruitment_Source__c=='Frisomum' || Acc.Recruitment_Source__c=='Event' || Acc.Recruitment_Source__c=='Clinics' || Acc.Recruitment_Source__c=='Mall Event' || 
                Acc.Recruitment_Source__c=='Elderly Center' || Acc.Recruitment_Source__c=='Modern Trade' || Acc.Recruitment_Source__c=='Open Trade' ||Acc.Recruitment_Source__c=='Member Referral'||Acc.Recruitment_Source__c=='Clinic Referral'||Acc.Recruitment_Source__c=='Staff Referral'||Acc.Recruitment_Source__c=='Roadshow' || Acc.Recruitment_Source__c=='Others') 
                && Acc.PersonEmail == null && Acc.PersonMobilePhone!=null && Acc.FCHK_Reject_SMS__c==false){
                        if(Acc.FCHK_Member_Age_Num__c == null || Acc.FCHK_Member_Age_Num__c < 40){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='SMS' && camp.FCHK_Sample__c=='All'){                        
                                CampId = camp.id;
                            }
                        }
                        else if(Acc.FCHK_Member_Age_Num__c >= 40 && Acc.FCHK_Member_Age_Num__c < 50 ){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='SMS' && camp.FCHK_Sample__c=='Optimel Silver'){                        
                                CampId = camp.id;
                            }
                        }                        
                        else if(Acc.FCHK_Member_Age_Num__c >= 50 && Acc.FCHK_Member_Age_Num__c < 60 ){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='SMS' && camp.FCHK_Sample__c=='Optimel Gold'){                        
                                CampId = camp.id;
                            }
                        }
                        else if(Acc.FCHK_Member_Age_Num__c >= 60 ){
                            if(camp.FCHK_Recruitment_Source__c=='Offline' && camp.Type=='SMS' && camp.FCHK_Sample__c=='Optimel Diamond'){                        
                                CampId = camp.id;
                            }
                        }
                           
                     system.debug('--InsertCampMemLst--'+InsertCampMemLst);       
                }
                    
            }
            if(CampId!=null){
                        CM.ContactId = Cont.Id;               
                        //CM.CampaignId = '701O0000000B4r9';
                        CM.CampaignId = CampId;
                        CM.Status = 'Selected';                        
                        system.debug('--CM--'+CM);
                        InsertCampMemLst.add(CM);
                    }
            }
        }            
    }  
    }
    
    if(InsertCampMemLst.size()>0) 
        insert InsertCampMemLst;

}