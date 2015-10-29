trigger FCHK_Trg_Add_To_Campaign on CampaignMember (after insert,after update) {
     system.debug('Enter the trigger');
    Set<Id> campIdList = new Set<Id>();
    List<CampaignMember> InsertCampMemLst = new List<CampaignMember>();
    Id CampId;
    
    List<Campaign> CampLst = [select id, name, FCHK_Recruitment_Source__c, FCHK_Sample__c, Type from Campaign 
                                where name like 'Referral%' and IsActive=true];
             system.debug('--CampLst--'+CampLst+'-----size--'+CampLst.size());
     for(CampaignMember campObj:trigger.new){
         system.debug('Enter the trigger.new');
         campIdList.add(campObj.id);
     }
    List<CampaignMember> CampMemberLst = [select id, ContactId, CampaignId,contact.MobilePhone,contact.Email from CampaignMember 
                                where id in :campIdList];
            system.debug('--CampLst--'+CampMemberLst+'-----size--'+CampMemberLst.size());
    
        for(CampaignMember camObj:CampMemberLst){
                CampaignMember CM = new CampaignMember();
                for(Campaign camp : CampLst){
                
                if(camObj.contact.MobilePhone != null )
                {
                    system.debug('Enter the if condition');
                    if(camp.Type=='SMS')
                    {
                        system.debug('Enter the type');
                        CampId=camp.id;
                        
                    }
                    
                }
                    
                   else if((camObj.contact.MobilePhone != null && camObj.contact.Email!=null) ||camObj.contact.Email != null )
                   {
                       system.debug('Enter the else condition');
                        if(camp.Type=='Email')
                    {
                        system.debug('Enter the else condition');
                        CampId=camp.id;
                        
                    }
                   }
                    
                    
            }
            if(CampId!=null){
                    system.debug('Enter the CampId condition');       
                        camObj.CampaignId = CampId;
                        system.debug('--CM--'+camObj);
                        InsertCampMemLst.add(camObj);
                    }
            
        }            
      
 system.debug('End the CampId condition');
    
    if(InsertCampMemLst.size()>0) 
        update InsertCampMemLst;
    system.debug('--Please update--');

}