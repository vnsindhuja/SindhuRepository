global class FCHK_Cls_AddCampaignMemberAutomationcls implements Database.batchable<sObject>,Database.stateful{
	     Map<String,Set<Id>>  campaignContactSetMap = new Map<String,Set<Id>>();
	     Map<String,Campaign>  campaignMap = new Map<String,Campaign>();
	     Set<String> offlineRecruitSourceSet = new Set<String>{'Frisomum' ,'Hotline','Event','Mall Event'};
		 global Database.QueryLocator start(Database.BatchableContext BC){
		        String query = 'SELECT Id,Name,personEmail,FCHK_Member_Age__c,Recruitment_Source__c,';
		        query+='OpCo__c,FCHK_Reject_SMS__c,PersonMobilePhone,PersonHasOptedOutOfEmail,';
		        query +='PersonBirthdate,PersonContactId FROM Account ';
		        query+=' where RecordType.DeveloperName=\'FCHK_MR_RT_Optimel\' and PersonContactId!=null';
		        return Database.getQueryLocator(query);
		 }
		  global void execute(Database.BatchableContext BC, List<Account> accountList){
		  		Map<Id,RecordType> cmemberRecordTypeMap = new Map<Id,RecordType>();
		  		Map<String,Id> rectypeMap = new Map<String,Id>();
		  		List<CampaignMember> cmemberList = new  List<CampaignMember>();
		  		Map<Id,String> campaignNameMap = new Map<id,String>();
		  		cmemberRecordTypeMap.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('CampaignMember'));
		  		if(cmemberRecordTypeMap!=null && cmemberRecordTypeMap.size()>0){
		  			for(Id rectypeId:cmemberRecordTypeMap.keyset()){
		  					rectypeMap.put(cmemberRecordTypeMap.get(recTypeId).DeveloperName,rectypeId);
		  			}
		  		}
		  		Set<String> campaignNamesSet = new Set<String>();//To hold campaigns 
		  		List<CampaignMember> campaignMemberList = new List<CampaignMember>();
		  		Set<Id> contactIdSet = new Set<Id>();
		  		campaignNamesSet.addAll(AppLiteralscls.campaignNamesSet);
		  		if(campaignNamesSet!=null && campaignNamesSet.size()>0){
			  		 for(Campaign campObj:[select id,Name from Campaign where name in:campaignNamesSet]){
			  		 	campaignMap.put(campObj.Name,campObj);
			  		 	campaignNameMap.put(campObj.Id,campObj.Name);
			  		 }
		  		}
		  		for(Account actObj:accountList){
		               if(actObj.personContactId!=null){
		               		contactIdSet.add(actObj.personContactId);
		               }     
		        }
		        if(contactIdSet!=null && contactIdSet.size()>0){
		         		for(CampaignMember cmemberObj:[select id,ContactId,CampaignId,Campaign.Name 
		         			from CampaignMember where contactId in:contactIdSet]){
		         				if(campaignContactSetMap.get(cmemberObj.Campaign.Name)!=null){
		         					campaignContactSetMap.get(cmemberObj.Campaign.Name).add(cmemberObj.contactId);
		         				}
		         				else{
		         					campaignContactSetMap.put(cmemberObj.Campaign.Name,new Set<Id>{cmemberObj.ContactId});
		         				}
		         		}	
		         }
		         for(Account actObj:accountList){
		         		if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=40 && actObj.FCHK_Member_Age__c<=49
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' && actObj.FCHK_Reject_SMS__c==false 
		         			&& actObj.PersonMobilePhone!=null 
		         			&& campaignMap.get('New Member welcome message-Offline w/o email S-40')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message-Offline w/o email S-40').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=50 && actObj.FCHK_Member_Age__c<=59
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' && actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('New Member welcome message-Offline w/o email S-50')!=null		         			
		         			&& actObj.PersonMobilePhone!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message-Offline w/o email S-50').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=60 
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' && actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('New Member welcome message-Offline w/o email S-60')!=null		         			
		         			&& actObj.PersonMobilePhone!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message-Offline w/o email S-60').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=60 
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' && actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('New Member welcome message-Offline w/o email for ALL')!=null		         			
		         			&& actObj.PersonMobilePhone!=null
		         			&& actObj.PersonBirthdate==null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message-Offline w/o email for ALL').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=40 && actObj.FCHK_Member_Age__c<=49 
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Offline with email S-40')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Offline with email S-40').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=50 && actObj.FCHK_Member_Age__c<=59 
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Offline with email S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Offline with email S-50').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=60  
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Offline with email S-60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Offline with email S-60').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=60  
		         			&& offlineRecruitSourceSet.contains(actObj.Recruitment_Source__c)
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Offline with email for ALL')!=null 
		         			&& actObj.PersonBirthdate==null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Offline with email for ALL').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=40 && actObj.FCHK_Member_Age__c<=49  
		         			&& actObj.Recruitment_Source__c=='Website' 
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Online with email S-40')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Online with email S-40').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=50 && actObj.FCHK_Member_Age__c<=59  
		         			&& actObj.Recruitment_Source__c=='Website' 
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Online with email S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Online with email S-50').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=60   
		         			&& actObj.Recruitment_Source__c=='Website' 
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Online with email S-60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Online with email S-60').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.personBirthDate==null    
		         			&& actObj.Recruitment_Source__c=='Website' 
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('New Member welcome message - Online with email for ALL')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('New Member welcome message - Online with email for ALL').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c<=49 
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-40')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-40').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=51 && actObj.FCHK_Member_Age__c<=59  
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-50').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=51 && actObj.FCHK_Member_Age__c<=59  
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-50').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=61   
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Birthday-SMS-S-60').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c<=49   
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Birthday-eDM-S-40')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Birthday-eDM-S-40').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=51 && actObj.FCHK_Member_Age__c<=59   
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Birthday-eDM-S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Birthday-eDM-S-50').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=61   
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Birthday-eDM-S-60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Birthday-eDM-S-60').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c==50    
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK' 
		         			&& actObj.PersonMobilePhone!=null  
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Transition-SMS-Turning 50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Transition-SMS-Turning 50').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c==50    
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK'
	         				&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Transition-eDM-Turning 50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Transition-eDM-Turning 50').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c==60    
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK'
		         			&& actObj.personMobilePhone!=null 
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Transition-SMS-Turning 60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Transition-SMS-Turning 60').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c==60    
		         			&& actObj.personBirthDate!=null && actObj.personBirthDate.Month()==System.today().month()  
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('Birthday Greeting and Offer-Transition-eDM-Turning 60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Birthday Greeting and Offer-Transition-eDM-Turning 60').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=50  && actObj.FCHK_Member_Age__c<=59 
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('Member Regular Communication S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Member Regular Communication S-50').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=60 
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.PersonHasOptedOutOfEmail==false 
		         			&& campaignMap.get('Member Regular Communication S-60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('Member Regular Communication S-60').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=40 && actObj.FCHK_Member_Age__c<=49 
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& actObj.personMobilePhone!=null 
		         			&& campaignMap.get('First Purchase Offer-SMS-S-40')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-SMS-S-40').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=50 && actObj.FCHK_Member_Age__c<=59 
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& actObj.personMobilePhone!=null 
		         			&& campaignMap.get('First Purchase Offer-SMS-S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-SMS-S-50').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=50 && actObj.FCHK_Member_Age__c<=59 
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& actObj.personMobilePhone!=null 
		         			&& campaignMap.get('First Purchase Offer-SMS-S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-SMS-S-50').id));
		         		}
		         		else if(actObj.personEmail==null 
		         			&& actObj.FCHK_Member_Age__c>=60  
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.FCHK_Reject_SMS__c==false 
		         			&& actObj.personMobilePhone!=null 
		         			&& campaignMap.get('First Purchase Offer-SMS-S-60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-SMS-S-60').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=40 && actObj.FCHK_Member_Age__c<=49   
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.PersonHasOptedOutOfEmail==false 	         			
		         			&& campaignMap.get('First Purchase Offer-eDM-S-40')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-eDM-S-40').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=50 && actObj.FCHK_Member_Age__c<=59   
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.PersonHasOptedOutOfEmail==false 	         			
		         			&& campaignMap.get('First Purchase Offer-eDM-S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-eDM-S-50').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=50 && actObj.FCHK_Member_Age__c<=59   
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.PersonHasOptedOutOfEmail==false 	         			
		         			&& campaignMap.get('First Purchase Offer-eDM-S-50')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-eDM-S-50').id));
		         		}
		         		else if(actObj.personEmail!=null 
		         			&& actObj.FCHK_Member_Age__c>=60    
		         			&& actObj.OpCo__c=='HK'		         			
		         			&& actObj.PersonHasOptedOutOfEmail==false 	         			
		         			&& campaignMap.get('First Purchase Offer-eDM-S-60')!=null){
		         			cmemberList.add(returnCmemberrecord(actObj.personContactId,campaignMap.get('First Purchase Offer-eDM-S-60').id));
		         		}
		         }
		         if(cmemberList!=null && cmemberList.size()>0){
		         		database.insert(cmemberList,false);
		         		/*for(CampaignMember cmemberObj:cmemberList){
		         				if(campaignContactSetMap.get(campaignNameMap.get(cmemberObj.CampaignId))!=null){
		         						campaignContactSetMap.get(campaignNameMap.get(cmemberObj.CampaignId)).add(cmemberObj.ContactId);
		         				}
		         				else{
		         						campaignContactSetMap.put(campaignNameMap.get(cmemberObj.CampaignId),new Set<Id>{cmemberObj.ContactId});
		         				}
		         		}*/
		         }
		         
		         
		         
		         //update scope;
			} 
		 global void finish(Database.BatchableContext BC){
		 	
		 }
		 global CampaignMember returnCmemberrecord(Id contactId,Id campaignId){
		 	CampaignMember cmemberObj = new CampaignMember(contactId=contactId,campaignId=campaignId);
		 	return cmemberObj;
		 }
}