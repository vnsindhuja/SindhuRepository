trigger FCHK_Trg_Account_Actions_HCP on Account (before insert,before update) {
    
    
    if(trigger.isInsert && trigger.isBefore){
       if(AppLiteralscls.stopAccountAction==false){
               Set<String> dupphoneSet = new Set<String>();
              
              for(Account actObj:trigger.new){
                  if(actObj.Phone!=null){
                  
                    if(dupphoneSet.Contains(actObj.Phone)){
                    
                        actobj.addError('Duplicate phone number found.');
                    }
                    else{
                    
                        dupphoneSet.add(actObj.Phone);
                    }
                  }
                  
                
                
              }
              Set<String> phoneSet = new Set<String>();
              
              Map<String,Account> accountEmailPhoneMap = new Map<String,Account>(); 

//Id recordTypeId = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Medical Marketing'].id;           

Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));  
                   
              for(Account accObj:trigger.new){
if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='MedicalMarketing' && accObj.OpCo__c == 'HK')
              {
                     
                     if(accObj.Phone!=null){
                     
                        phoneSet.add(accObj.Phone);
                     }
                    
}                    
              }
             
              if((phoneSet!=null && phoneSet.size()>0)){
                        for(Account accObj:[select id,firstname,lastName,Phone from Account where  Phone in:phoneSet]){
                                if(accObj.Phone!=null){
                                
                                    
                                    accountEmailPhoneMap.put(accObj.Phone,accObj);
                                    
                                }
                                
                                 
                        }
                    
              }
               
             
                 for(Account accObj:trigger.new){
                 if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='MedicalMarketing')
                 {
                           

                       if((accObj.Phone!=null) && (accountEmailPhoneMap!=null||accountEmailPhoneMap.size()>0) && (accountEmailPhoneMap.get(accObj.Phone)!=null ))
                        {

                        accObj.addError('Member With Duplicate Phone Found.');
                        }  

                        
                        }
 
  
}
         
        
         
         
     }  
}
   if(trigger.isUpdate && trigger.isBefore){
              
                  if(AppLiteralscls.stopAccountAction==false){
                  
                  Set<String> dupphoneSet = new Set<String>();
              
              for(Account actObj:trigger.new){
                  if(actObj.Phone!=null){
                    if(dupphoneSet.Contains(actObj.Phone)){
                        actobj.addError('Duplicate phone number found.');
                    }
                    else{
                        dupphoneSet.add(actObj.Phone);
                    }
                  }
                  
                
                
              }
                        Set<String> phoneSet = new Set<String>();
                        
                        Map<String,Account> accountEmailPhoneMapUpdate = new Map<String,Account>();        
                        //Id recordTypeId = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Medical Marketing'].id;
                        Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
    recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account')); 
                        for(Account accObj:trigger.new){
                            if(trigger.newMap.get(accObj.id).Phone!=trigger.oldMap.get(accObj.id).Phone ){                      
                                 if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='MedicalMarketing')
                                {
                                    if(accObj.Phone!=null && accObj.OpCo__c == 'HK'){
                                            phoneSet.add(accObj.Phone);
                                    }
                                    
                                }     
                            }               
                        }
                        
                      if((phoneSet!=null && phoneSet.size()>0) ){
                                for(Account accObj:[select id,firstname,lastName,Phone from Account where   Phone in:phoneSet  and id not in:trigger.newMap.keyset()]){
                                        
                                        if(accObj.Phone!=null){
                                             
                                                accountEmailPhoneMapUpdate.put(accObj.Phone,accObj);
                                                
                                        }
                                         
                                        
                                }
                      }
                    for(Account accObj:trigger.new){
                        if(trigger.newMap.get(accObj.id).Phone!=trigger.oldMap.get(accObj.id).Phone ){
                            if(recordTypeMapAcc.get(accObj.RecordTypeId)!=null && recordTypeMapAcc.get(accObj.RecordTypeId).DeveloperName=='MedicalMarketing')
                            {
                                    
                                    if(trigger.newMap.get(accObj.id).Phone!=null && accountEmailPhoneMapUpdate.get(trigger.newMap.get(accObj.id).Phone)!=null){
                                       
                                       accObj.addError('Member With Duplicate Phone Found.');
                                    }
                                            
                            } 
                    }
                }        
             }
     } 

}