public with sharing class FCHK_cls_addMembertoCampaign {
	public static void addMembertoCampaign(List<Account> accountList){
			Map<String,Campaign> campaingnMap = new Map<String,Campaign>();//To hold campaign name with Cmapaign
			List<CampaignMember> cmemberList = new List<CampaignMember>();
			 Map<id,RecordType> recordTypeMap = new Map<id,RecordType>();
			recordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
			for(Campaign campaignObj:[select id,name from Campaign 
				 where (name = 'Sample Invitation eDM Cold' or name = 'Sample Invitation SMS Cold') and IsActive=true]){
				campaingnMap.put(campaignObj.Name,campaignObj);
			}
			for(Account actObj:accountList){
				if(actObj.personContactId!=null && recordTypeMap.get(actObj.RecordTypeId).developerName=='FCHK_MR_RT_Optimel'){
					if((actObj.FCHK_Member_Age__c == null  || actObj.FCHK_Member_Age__c < 40) 
						&& actObj.FCHK_Member_Status__c == 'Cold' && actObj.PersonEmail == null 
						&& actObj.PersonMobilePhone!=null && campaingnMap.get('Sample Invitation SMS Cold')!=null){
						CampaignMember cmemberObj = new CampaignMember(campaignId=campaingnMap.get('Sample Invitation SMS Cold').id,
																		ContactId=actobj.personContactId,
																		Status = 'Selected'); 
						cmemberList.add(cmemberObj);
					}
					else if((actObj.FCHK_Member_Age__c == null  || actObj.FCHK_Member_Age__c < 40) 
						&& actObj.FCHK_Member_Status__c == 'Cold' 
						&& actObj.PersonEmail != null && actObj.PersonMobilePhone == null){
						CampaignMember cmemberObj = new CampaignMember(campaignId=campaingnMap.get('Sample Invitation eDM Cold').id,
																		ContactId=actobj.personContactId,
																		Status = 'Selected'); 
						cmemberList.add(cmemberObj);
					}
				}
			}
			
			
			if(cmemberList!=null && cmemberList.size()>0){
					database.insert(cmemberList,false);
			}
			
			
			
	}
}