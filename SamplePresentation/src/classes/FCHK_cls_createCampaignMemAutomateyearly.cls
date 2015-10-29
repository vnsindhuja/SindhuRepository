global class FCHK_cls_createCampaignMemAutomateyearly implements Database.batchable<sobject>, database.stateful{
	Map<String,CampainCriteriaLogic__c> campainCriteriaMap = new Map<String,CampainCriteriaLogic__c>();
	global database.queryLocator start(Database.BatchableContext BC){
		Set<String> campaignNameSet = new Set<String>();//to hold campaigns from CampainCriteriaLogic__c object
		for(CampainCriteriaLogic__c campaingCritObj:[select id,name,BlastingFrequency__c,CriteriaLogic__c 
			from CampainCriteriaLogic__c 
			where BlastingFrequency__c='Year']){
			campaignNameSet.add(campaingCritObj.Name);
			campainCriteriaMap.put(campaingCritObj.Name,campaingCritObj);
		}
		System.debug('campainCriteriaMap!@@@:'+campainCriteriaMap);
		if (System.today().month()!=1)
		{
			return null;
		}
		if(campaignNameSet!=null && campaignNameSet.size()>0){
			String query = 'select id,name from campaign where name in:campaignNameSet';
			return database.getQueryLocator(query);
		}
		return null;
		
	}
	global void execute(Database.BatchableContext BC,List<Campaign> campaignList){
		if(campaignList!=null && campaignList.size()>0){	
			System.debug('campainCriteriaMap@@:'+campainCriteriaMap);
			System.debug('campainCriteriaMap@@:'+campainCriteriaMap.get(campaignList[0].Name));	
			String filterLogic= campainCriteriaMap.get(campaignList[0].Name).CriteriaLogic__c;
			System.debug('campaignList::'+campaignList);
			Map<String,FilterConditions__c> filterMap = new Map<String,FilterConditions__c>();

			for(FilterConditions__c filterObj:[select id,
			                                   	name,FieldName__c,ObjectName__c,Operator__c,Value__c 
			                                   from FilterConditions__c]){
			                                   filterMap.put(filterObj.Name,filterObj) ;  
			                                      
			                            }
			String whereCondition='';
			System.debug('filterMap.keyset()@@:'+filterMap.keyset());
			for(String key:filterMap.keyset()){
			    if(whereCondition=='' && filterLogic.contains(key)){
			        whereCondition=filterLogic.replace(key,filterMap.get(key).FieldName__c+' '+filterMap.get(key).Operator__c+' '+filterMap.get(key).Value__c);
			    }
			    else if(whereCondition!='' && whereCondition.contains(key)){
			        whereCondition=whereCondition.replace(key,filterMap.get(key).FieldName__c+' '+filterMap.get(key).Operator__c+' '+filterMap.get(key).Value__c);      
			    }
			    
			}
			String RecTypeDevelopername = 'FCHK_MR_RT_Optimel';
			String query='select id,personContactID from Account where id!=null and recordType.DeveloperName=:RecTypeDevelopername ';
			if(whereCondition!=''){
				query+=' and '+whereCondition;
			}
			System.debug('query!!!'+query);
			
			List<Account> accountList = Database.query(query);
			List<CampaignMember> cmemberList = new List<CampaignMember>();
			for(Account actObj:accountList){
				 CampaignMember cmemberObj = new CampaignMember(contactId=actobj.personContactId,campaignId=campaignList[0].id);
			     cmemberList.add(cmemberObj);
			    	System.debug('accountList@@:'+actObj.id);
			}
			if(cmemberList!=null && cmemberList.size()>0){
					database.insert(cmemberList,false);
			}
		}	
			//Database.executeBatch(new FCHK_cls_createCampaignMemAutomateyearly(),1);

		
	}
	global void finish(Database.BatchableContext BC){
		
	}
}