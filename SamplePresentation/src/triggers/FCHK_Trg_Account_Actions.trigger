trigger FCHK_Trg_Account_Actions on Account (after insert,before insert,before update) {
    //Added on jul 13 ,2015 for Optimel to Friso functionality 
    if(trigger.isInsert && trigger.isAfter){   
        StopTrigger__c stopTrigObj = StopTrigger__c.getValues('Stopoptimeltofriso');  //used to stop execution when existing frisomum data 
        if(stopTrigObj!=null && stopTrigObj.isStop__c==false){  
            List<Account> accountList = new List<Account>();
            for(Account accountObj:[select id,name,FCHK_18_District_Chi__c,FCHK_18_District_Eng__c,FCHK_Address_Chi__c
                            ,FCHK_Area_Chi__C,FCHK_Area_Eng__C,FCHK_Block__c,FCHK_Street__c,FCHK_Building__c,FCHK_Business_Hours__c,FCHK_Country__c
                            ,FCHK_District__c,FCHK_Estate__c,FCHK_F1_Trail__c,Fax,FCHK_Flat__c,FCHK_Floor__c
                            ,FCHK_Infer_recommendation__c,FCHK_Medical_Rep__C,FCHK_Patient_Flow__C,FCHK_Patient_type__c
                            ,FCHK_Relevancy__c,FCHK_Specialist__c,phone,FCHK_MedicalType__c,FCHK_Classification__c 
                            from Account where id in:trigger.newMap.keyset() 
                            and RecordType.developername='MedicalMarketing' 
                            and OpCo__c='HK']){
                accountList.add(accountObj);
            }
            if(accountList!=null && accountList.size()>0){
                    FCHK_cls_AccountActionscls.copyRecOptimeltoFriso(accountList);
            }
        }
        // for adding member to campaign (cold sms,cold eDM)
       /*  FCHK_cls_addMembertoCampaign.addMembertoCampaign(trigger.new);*/
    }
    //End of cod added on jul 13 ,2015 for Optimel to Friso functionality 
    
    if(trigger.isInsert && trigger.isBefore){
       if(AppLiteralscls.stopAccountAction==false){
                    Set<String> dupphoneSet = new Set<String>();
                    Set<String> dupemailSet = new Set<String>();
                    Set<String> duphomePhoneSet = new Set<String>();
                    for(Account actObj:trigger.new){
                            if(actObj.PersonMobilePhone!=null){
                                if(dupphoneSet.Contains(actObj.PersonMobilePhone)){
                                    actobj.addError('Duplicate phone number found.');
                                }
                                else{
                                    dupphoneSet.add(actObj.PersonMobilePhone);
                                }
                            }
                            if(actObj.PersonEmail!=null){
                                if(dupemailSet.contains(actObj.PersonEmail)){
                                    actobj.addError('Duplicate email found');
                                }
                                else{
                                    dupemailSet.add(actObj.PersonEmail);
                                }
                            }
                            if(actObj.PersonHomePhone!=null){
                                if(duphomePhoneSet.contains(actObj.PersonHomePhone)){
                                    actobj.addError('Duplicate home phone found.');
                                }
                                else{
                                    duphomePhoneSet.add(actobj.PersonHomePhone);
                                }
                            }
                    
                  }
                Set<String> phoneSet = new Set<String>();
                Set<String> emailSet = new Set<String>();
                Set<String> homePhoneSet = new Set<String>();
                 Map<String,Account> accountEmailPhoneMap = new Map<String,Account>(); 
                //Id recordTypeId = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id; 
Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));              
                   
              for(Account accObj:trigger.new){
                  if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel')
                  {
                         if(accObj.PersonMobilePhone!=null){
                            phoneSet.add(accObj.PersonMobilePhone);
                         }
                         if(accObj.PersonEmail!=null){
                            emailSet.add(accObj.PersonEmail);
                         }  
                        if(accObj.PersonHomePhone!=null){
                            homePhoneSet.add(accObj.PersonHomePhone);
                         }  
                    }                    
              }
             
              if((phoneSet!=null && phoneSet.size()>0) || (emailSet!=null && emailSet.size()>0)||(homePhoneSet!=null && homePhoneSet.size()>0)){
                        for(Account accObj:[select id,firstname,lastName,PersonEmail,PersonMobilePhone,PersonHomePhone from Account where IsPersonAccount=true AND (PersonEmail in:emailSet or PersonMobilePhone in:phoneSet or PersonHomePhone in:homePhoneSet)]){
                                if(accObj.PersonMobilePhone!=null && accObj.PersonEmail!=null && accObj.PersonHomePhone!=null){
                                    
                                    accountEmailPhoneMap.put(accObj.PersonMobilePhone+'#'+accObj.PersonEmail+'#'+accObj.PersonHomePhone,accObj);
                                    
                                }
                                if(accObj.PersonMobilePhone!=null){
                                     
                                        accountEmailPhoneMap.put(accObj.PersonMobilePhone,accObj);
                                        
                                }
                                 if(accObj.PersonEmail!=null){
                                     
                                        accountEmailPhoneMap.put(accObj.PersonEmail,accObj);
                                       
                                }
                                if(accObj.PersonHomePhone!=null){
                                     
                                        accountEmailPhoneMap.put(accObj.PersonHomePhone,accObj);
                                       
                                }
                        }
                    
              }
               
             
             for(Account accObj:trigger.new){
                     if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel'){
                            if((accObj.PersonMobilePhone!=null || accObj.PersonEmail!=null || accObj.PersonHomePhone!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(accObj.PersonMobilePhone)!=null && accountEmailPhoneMap.get(accObj.PersonEmail)!=null && accountEmailPhoneMap.get(accObj.PersonHomePhone)!=null))
                            {
                              accObj.addError('Member With Duplicate Email Address and Phone Number Found.');
                            } 
    
                            else  if((accObj.PersonMobilePhone!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(accObj.PersonMobilePhone)!=null ))
                            {
    
                            accObj.addError('Member With Duplicate Mobile Found.');
                            }  
    
                            else if((accObj.PersonEmail!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(accObj.PersonEmail)!=null ))
                            {
    
                            accObj.addError('Member With Duplicate Email Address Found.');
                            }
                            
                            else if((accObj.PersonHomePhone!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(accObj.PersonHomePhone)!=null ))
                            {
    
                            accObj.addError('Member With Duplicate Home Phone Found.');
                            }
                            //for date of birth update 
                            if(accObj.PersonBirthdate!=null){
                                if(accObj.PersonBirthdate!=null){
                                    accObj.Birth_Day__c = String.valueOf(accObj.PersonBirthdate.Day());
                                    accObj.Birth_Month__c = String.valueOf(accObj.PersonBirthdate.Month());
                                    accObj.Birth_Year__c = String.valueOf(accObj.PersonBirthdate.Year());
                                }
                            }
                            //End of date of birth update                           
                    }
            }
        }  
    }
    if(trigger.isUpdate && trigger.isBefore){
              
              if(AppLiteralscls.stopAccountAction==false){
                    Set<String> dupphoneSet = new Set<String>();
                    Set<String> dupemailSet = new Set<String>();
                    Set<String> duphomePhoneSet = new Set<String>();
                    for(Account actObj:trigger.new){
                        if(actObj.PersonMobilePhone!=null){
                            if(dupphoneSet.Contains(actObj.PersonMobilePhone)){
                                 actobj.addError('Duplicate phone number found.');
                            }
                            else{
                                dupphoneSet.add(actObj.PersonMobilePhone);
                            }
                        }
                        if(actObj.PersonEmail!=null){
                            if(dupemailSet.contains(actObj.PersonEmail)){
                                actobj.addError('Duplicate email found');
                            }
                            else{
                                dupemailSet.add(actObj.PersonEmail);
                            }
                          }
                        if(actObj.PersonHomePhone!=null){
                            if(duphomePhoneSet.contains(actObj.PersonHomePhone)){
                                actobj.addError('Duplicate home phone found.');
                            }
                            else{
                                duphomePhoneSet.add(actobj.PersonHomePhone);
                            }
                        } 
                    }
                    Set<String> phoneSet = new Set<String>();
                    Set<String> emailSet = new Set<String>();
                    Set<String> homePhoneSet = new Set<String>();
                    Map<String,Account> accountEmailPhoneMapUpdate = new Map<String,Account>();        
                    //Id recordTypeId = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
                    Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
                    for(Account accObj:trigger.new){
                        if(trigger.newMap.get(accObj.id).PersonMobilePhone!=trigger.oldMap.get(accObj.id).PersonMobilePhone 
                         || trigger.newMap.get(accObj.id).PersonEmail!=trigger.oldMap.get(accObj.id).PersonEmail || 
                         trigger.newMap.get(accObj.id).PersonHomePhone!=trigger.oldMap.get(accObj.id).PersonHomePhone){                      
                             if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel')
                            {
                                if(accObj.PersonMobilePhone!=null){
                                        phoneSet.add(accObj.PersonMobilePhone);
                                }
                                if(accObj.PersonEmail!=null){
                                        emailSet.add(accObj.PersonEmail);
                                } 
                                if(accObj.PersonHomePhone!=null){
                                        homePhoneSet.add(accObj.PersonHomePhone);
                                }
                            }     
                        }               
                    }
                        
                  if((phoneSet!=null && phoneSet.size()>0) || (emailSet!=null && emailSet.size()>0)||(homePhoneSet!=null && homePhoneSet.size()>0)){
                            for(Account accObj:[select id,firstname,lastName,PersonEmail,PersonMobilePhone,PersonHomePhone from Account where IsPersonAccount=true AND (PersonEmail in:emailSet or PersonMobilePhone in:phoneSet or PersonHomePhone in:homePhoneSet) 
                                and id not in:trigger.newMap.keyset()]){
                                    if(accObj.PersonMobilePhone!=null && accObj.PersonEmail!=null && accObj.PersonHomePhone!=null){
                                        
                                        accountEmailPhoneMapUpdate.put(accObj.PersonMobilePhone+'#'+accObj.PersonEmail+'#'+accObj.PersonHomePhone,accObj);
                                        
                                    }
                                    if(accObj.PersonMobilePhone!=null){
                                         
                                            accountEmailPhoneMapUpdate.put(accObj.PersonMobilePhone,accObj);
                                            
                                    }
                                     if(accObj.PersonEmail!=null){
                                         
                                            accountEmailPhoneMapUpdate.put(accObj.PersonEmail,accObj);
                                           
                                    }
                                    if(accObj.PersonHomePhone!=null){
                                         
                                            accountEmailPhoneMapUpdate.put(accObj.PersonHomePhone,accObj);
                                           
                                    }
                            }
                  }
                    for(Account accObj:trigger.new){
                            if(trigger.newMap.get(accObj.id).PersonMobilePhone!=trigger.oldMap.get(accObj.id).PersonMobilePhone 
                                 || trigger.newMap.get(accObj.id).PersonEmail!=trigger.oldMap.get(accObj.id).PersonEmail || 
                                     trigger.newMap.get(accObj.id).PersonHomePhone!=trigger.oldMap.get(accObj.id).PersonHomePhone){
                                        if(recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel'){
                                                
                                                if((trigger.newMap.get(accObj.id).PersonMobilePhone!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(accObj.id).PersonMobilePhone)!=null) 
                                                    && (trigger.newMap.get(accObj.id).PersonEmail!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(accObj.id).PersonEmail)!=null) 
                                                    && (trigger.newMap.get(accObj.id).PersonHomePhone!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(accObj.id).PersonHomePhone)!=null) )
                                                {
                                                   accObj.addError('Member With Duplicate Email Address,Mobile and Home Phone Number Found.');
                                                }   
                                                else if(trigger.newMap.get(accObj.id).PersonMobilePhone!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(accObj.id).PersonMobilePhone)!=null){
                                                   
                                                   accObj.addError('Member With Duplicate Mobile Found.');
                                                }
                                                else  if(trigger.newmap.get(accObj.id).PersonHomePhone!=null && accountEmailPhoneMapUpdate.get(trigger.newmap.get(accObj.id).PersonHomePhone)!=null){
                                                    
                                                    accObj.addError('Member With Duplicate Home Phone Number Found.');
                                                }
                                                else  if(trigger.newmap.get(accObj.id).PersonEmail!=null && accountEmailPhoneMapUpdate.get(trigger.newmap.get(accObj.id).PersonEmail)!=null){
                                                    
                                                    accObj.addError('Member With Duplicate Email Address Found.');
                                                }   
                                                  
                                        } 
                            }
                                    //for date of birth update 
                                    if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel' && trigger.newMap.get(accObj.id).PersonBirthdate!=trigger.oldMap.get(accObj.id).PersonBirthdate){
                                        
                                        if(trigger.newMap.get(accObj.id).PersonBirthdate!=null){
                                            accObj.Birth_Day__c = String.valueOf(trigger.newMap.get(accObj.id).PersonBirthdate.Day());
                                            accObj.Birth_Month__c = String.valueOf(trigger.newMap.get(accObj.id).PersonBirthdate.Month());
                                            accObj.Birth_Year__c = String.valueOf(trigger.newMap.get(accObj.id).PersonBirthdate.Year());
                                        }
                                        else{
                                            accObj.Birth_Day__c = null;
                                            accObj.Birth_Month__c = null;
                                            accObj.Birth_Year__c = null;
                                        }
                                    }
                                    //End of date of birth update    
                    }     
                     //Creating tasks under person account
                     List<Account> accountList = new List<Account>();
                     for(Account actObj:trigger.new){
                            System.debug('for entering...');
                            if(actObj.FCHK_FirstPurchaseDate__c!=null && 
                            ((trigger.newMap.get(actObj.id).FCHK_is30DaysCompleted__c!=trigger.oldMap.get(actObj.id).FCHK_is30DaysCompleted__c 
                             && trigger.newMap.get(actObj.id).FCHK_is30DaysCompleted__c==true)
                             || (trigger.newMap.get(actObj.id).FCHK_is60DaysCompleted__c!=trigger.oldMap.get(actObj.id).FCHK_is60DaysCompleted__c
                             && trigger.newMap.get(actObj.id).FCHK_is60DaysCompleted__c==true))
                             && recordTypeMapAcc.get(actObj.RecordTypeId)!=null && recordTypeMapAcc.get(actObj.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel'){
                                System.debug('first If entering...');
                                accountList.add(actObj);                            
                            }
                            //Setting of First Purchase Date on person Account
                            if((trigger.newMap.get(actObj.id).FCHK_Claimed_Purchase__c!=trigger.oldMap.get(actObj.id).FCHK_Claimed_Purchase__c 
                            || trigger.newMap.get(actObj.id).FCHK_1st_Purchase_Done__c!=trigger.oldMap.get(actObj.id).FCHK_1st_Purchase_Done__c) 
                            && actObj.FCHK_FirstPurchaseDate__c==null){
                                actObj.FCHK_FirstPurchaseDate__c = System.today();
                            }
                            //End of Setting of first purchase date on person Account
                        
                     }
                     
                     if(accountList!=null && accountList.size()>0 && AppLiteralscls.stopOutboundcalls2ndtime==false){
                        System.debug('Second If entering...'+accountList);
                        FCHK_Cls_OutboundCallActionscls.createOutboundcalls(accountList);
                     }
                     //End of creating tasks(outbound calls) under person account   
             }
            
     } 

}