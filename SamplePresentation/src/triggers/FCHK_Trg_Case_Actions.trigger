trigger FCHK_Trg_Case_Actions on Case (before insert,before update) {
    
  if(trigger.isInsert && trigger.isBefore){
       
              Set<String> phoneSet = new Set<String>();
              Set<String> emailSet = new Set<String>();
              Set<String> homePhoneSet = new Set<String>();
              Map<String,Account> accountEmailPhoneMap = new Map<String,Account>(); 
     
    	 Id recordTypeId = [select id,Name from Recordtype where sObjectType='Case' AND Name= 'New Member Registration'].id;
    
          for(Case caseObj:trigger.new){
        
               if(caseObj.RecordTypeId==recordTypeId)
            {
           
                     if(caseObj.FCHK_Mobile__c!=null){
                        phoneSet.add(caseObj.FCHK_Mobile__c);
                     }
                     if(caseObj.FCHK_Email__c!=null){
                        emailSet.add(caseObj.FCHK_Email__c);
                     } 
                      if(caseObj.FCHK_Home_Phone__c!=null){
                        homePhoneSet.add(caseObj.FCHK_Home_Phone__c);
                     }
}           
              }
             
              if((phoneSet!=null && phoneSet.size()>0) || (emailSet!=null && emailSet.size()>0)||(homePhoneSet!=null && homePhoneSet.size()>0)){
        
        
                        for(Account accObj:[select id,PersonEmail,PersonMobilePhone,PersonHomePhone from Account where IsPersonAccount=true AND (PersonEmail in:emailSet or PersonMobilePhone in:phoneSet or PersonHomePhone in:homePhoneSet)]){
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
               
             
             for(Case caseObj:trigger.new){
       if(caseObj.RecordTypeId==recordTypeId)
           {
           
           
            if((caseObj.FCHK_Mobile__c!=null || caseObj.FCHK_Email__c!=null || caseObj.FCHK_Home_Phone__c!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(caseObj.FCHK_Mobile__c)!=null && accountEmailPhoneMap.get(caseObj.FCHK_Email__c)!=null && accountEmailPhoneMap.get(caseObj.FCHK_Home_Phone__c)!=null))
            {
                
              caseObj.addError('Member with duplicate email address,phone number,home phone number found.');
            } 

            else  if((caseObj.FCHK_Mobile__c!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(caseObj.FCHK_Mobile__c)!=null ))
            {
            

            caseObj.addError('Member with duplicate phone number found.');
            } 

            else if((caseObj.FCHK_Email__c!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(caseObj.FCHK_Email__c)!=null ))
            {
            
            caseObj.addError('Member with duplicate email address found.');
            }
            else if((caseObj.FCHK_Home_Phone__c!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(caseObj.FCHK_Home_Phone__c)!=null ))
             {

                        caseObj.addError('Member With Duplicate Home Phone Found.');
            }           
 }
                

  
}
       
}

if(trigger.isUpdate && trigger.isBefore){
              
                  if(AppLiteralscls.stopAccountAction==false){
                        Set<String> phoneSet = new Set<String>();
                        Set<String> emailSet = new Set<String>();
                        Set<String> homePhoneSet = new Set<String>();
                        Map<String,Account> accountEmailPhoneMapUpdate = new Map<String,Account>();        
                        Id recordTypeId = [select id,Name from Recordtype where sObjectType='Case' AND Name= 'New Member Registration'].id;
                        for(Case caseObj:trigger.new){
        
               if(caseObj.RecordTypeId==recordTypeId)
            {
           
                     if(caseObj.FCHK_Mobile__c!=null){
                        phoneSet.add(caseObj.FCHK_Mobile__c);
                     }
                     if(caseObj.FCHK_Email__c!=null){
                        emailSet.add(caseObj.FCHK_Email__c);
                     } 
                      if(caseObj.FCHK_Home_Phone__c!=null){
                        homePhoneSet.add(caseObj.FCHK_Home_Phone__c);
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
                    for(Case caseObj:trigger.new){
                        if(trigger.newMap.get(caseObj.id).FCHK_Mobile__c!=trigger.oldMap.get(caseObj.id).FCHK_Mobile__c 
                             || trigger.newMap.get(caseObj.id).FCHK_Email__c!=trigger.oldMap.get(caseObj.id).FCHK_Email__c || 
                             trigger.newMap.get(caseObj.id).FCHK_Home_Phone__c!=trigger.oldMap.get(caseObj.id).FCHK_Home_Phone__c){
                            if(caseObj.RecordTypeId==recordTypeId)
                            {
                                    
                                    
                                    if((trigger.newMap.get(caseObj.id).FCHK_Mobile__c!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(caseObj.id).FCHK_Mobile__c)!=null) 
                                        && (trigger.newMap.get(caseObj.id).FCHK_Email__c!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(caseObj.id).FCHK_Email__c)!=null) 
                                        && (trigger.newMap.get(caseObj.id).FCHK_Home_Phone__c!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(caseObj.id).FCHK_Home_Phone__c)!=null) )
                                    {
                                       caseObj.addError('Member With Duplicate Email Address,Mobile and Home Phone Number Found.');
                                    }   
                                    else if(trigger.newMap.get(caseObj.id).FCHK_Mobile__c!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(caseObj.id).FCHK_Mobile__c)!=null){
                                       
                                       caseObj.addError('Member With Duplicate Mobile Found.');
                                    }
                                    else  if(trigger.newmap.get(caseObj.id).FCHK_Home_Phone__c!=null && accountEmailPhoneMapUpdate.get(trigger.newmap.get(caseObj.id).FCHK_Home_Phone__c)!=null){
                                        
                                        caseObj.addError('Member With Duplicate Home Phone Number Found.');
                                    }
                                    else  if(trigger.newmap.get(caseObj.id).FCHK_Email__c!=null && accountEmailPhoneMapUpdate.get(trigger.newmap.get(caseObj.id).FCHK_Email__c)!=null){
                                        
                                        caseObj.addError('Member With Duplicate Email Address Found.');
                                    }         
                            } 
                    }
                }        
             }
     } 
    
       
    


}