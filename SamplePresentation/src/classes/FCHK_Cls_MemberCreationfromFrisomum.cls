global class FCHK_Cls_MemberCreationfromFrisomum {
		webservice static String createMemberfromFrisomum(String memberdetailfromFriso){
			String successErrorMessage='';
			List<FCHK_Cls_MemberCreationfrmfrisoParser.FCHK_Cls_MemberDetailfromFrisocls>  memberfromFrisoList = 
						(List<FCHK_Cls_MemberCreationfrmfrisoParser.FCHK_Cls_MemberDetailfromFrisocls>)JSON.deserialize(memberdetailfromFriso,List<FCHK_Cls_MemberCreationfrmfrisoParser.FCHK_Cls_MemberDetailfromFrisocls>.class);
			System.debug('Deserialized Result:'+memberfromFrisoList);
			List<Account> accountList = new List<Account>();			
			List<RecordType> recTypeList = new List<RecordType>();
			Set<String> phoneSet = new Set<String>();
          	Set<String> emailSet = new Set<String>();
          	Set<String> homePhoneSet = new Set<String>();
     		Map<String,Account> accountEmailPhoneMap = new Map<String,Account>(); 
			recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account' 
                    and recordType.developerName='FCHK_MR_RT_Optimel' limit 1];
			if(memberfromFrisoList!=null && memberfromFrisoList.size()>0 && recTypeList!=null && recTypeList.size()>0){
				//Duplicate check starts
				for(FCHK_Cls_MemberCreationfrmfrisoParser.FCHK_Cls_MemberDetailfromFrisocls memberObj:memberfromFrisoList){
							if(memberObj.memberEmail!=null){
								emailSet.add(memberObj.memberEmail);
							}
							if(memberObj.memberMobile!=null){
								phoneSet.add(memberObj.memberMobile);
							}
							if(memberObj.homephone!=null){
								homePhoneSet.add(memberObj.homephone);
							}
				}
				System.debug('emailSet@@:'+emailSet);
				System.debug('phoneSet@@:'+phoneSet);
				System.debug('homePhoneSet@@:'+homePhoneSet);
				if((phoneSet!=null && phoneSet.size()>0) 
					|| (emailSet!=null && emailSet.size()>0) 
					||(homePhoneSet!=null && homePhoneSet.size()>0)){
					for(Account actobj:[select id,firstname,lastName,PersonEmail,PersonMobilePhone,PersonHomePhone 
						from Account 
						where IsPersonAccount=true 
						AND (PersonEmail in:emailSet 
						or PersonMobilePhone in:phoneSet 
						or PersonHomePhone in:homePhoneSet)]){
						 	if(actobj.PersonMobilePhone!=null && actobj.PersonEmail!=null 
						 		&& actobj.PersonHomePhone!=null){
                                    accountEmailPhoneMap.put(actobj.PersonMobilePhone+'#'+actobj.PersonEmail+'#'+actobj.PersonHomePhone,actobj);
                         	}
                         	if(actobj.PersonMobilePhone!=null){
                                    accountEmailPhoneMap.put(actobj.PersonMobilePhone,actobj);
                         	}
                  			if(actobj.PersonEmail!=null){
                                    accountEmailPhoneMap.put(actobj.PersonEmail,actobj);
                        	}
                        	if(actobj.PersonHomePhone!=null){
                                    accountEmailPhoneMap.put(actobj.PersonHomePhone,actobj);
                            }
                             
					}
					
				}
				System.debug('accountEmailPhoneMap@@:'+accountEmailPhoneMap);
				//End of Duplicate check starts
				
				
				
				JSONGenerator gen=JSON.createGenerator(true);
				gen.writeStartArray(); 
				String errorMsg = '';
				for(FCHK_Cls_MemberCreationfrmfrisoParser.FCHK_Cls_MemberDetailfromFrisocls memberObj:memberfromFrisoList){
						errorMsg='';
						if((memberObj.memberMobile!=null || memberObj.memberEmail!=null || memberObj.homephone!=null)
						 	&& (accountEmailPhoneMap!=null && accountEmailPhoneMap.size()>0) 
							&& (accountEmailPhoneMap.get(memberObj.memberMobile)!=null 
							&& accountEmailPhoneMap.get(memberObj.memberEmail)!=null 
							&& accountEmailPhoneMap.get(memberObj.homephone)!=null)){
		                        errorMsg ='Member with duplicate email address and phone number found.'; 
		                        gen.writeStartObject();
					            gen.writeStringField('frisorecordId',memberObj.frisorecordId);
					            gen.writeStringField('errorDescription',errorMsg);
					            gen.writeBooleanField('isError',true);  
					            gen.writeBooleanField('isSuccess',false);
					            gen.writeBooleanField('isTechnical',false);                 
					            gen.writeEndObject();
                    	}
                    	if(errorMsg=='' && (memberObj.memberMobile!=null) 
                    		&& (accountEmailPhoneMap!=null && accountEmailPhoneMap.size()>0) 
                    		&& (accountEmailPhoneMap.get(memberObj.memberMobile)!=null)){
                    			System.debug('if entering....');
                    			errorMsg ='Member with duplicate phone number found.'; 
                    			gen.writeStartObject();
					            gen.writeStringField('frisorecordId',memberObj.frisorecordId);
					            gen.writeStringField('errorDescription',errorMsg);
					            gen.writeBooleanField('isError',true);  
					            gen.writeBooleanField('isSuccess',false);
					            gen.writeBooleanField('isTechnical',false);                 
					            gen.writeEndObject();
                    	} 
                    	if(errorMsg=='' && (memberObj.memberEmail!=null) 
                    		&& (accountEmailPhoneMap!=null && accountEmailPhoneMap.size()>0) 
                    		&& (accountEmailPhoneMap.get(memberObj.memberEmail)!=null)){
                    			errorMsg ='Member with duplicate email address found.';
                    			gen.writeStartObject();
					            gen.writeStringField('frisorecordId',memberObj.frisorecordId);
					            gen.writeStringField('errorDescription',errorMsg);
					            gen.writeBooleanField('isError',true);  
					            gen.writeBooleanField('isSuccess',false);  
					            gen.writeBooleanField('isTechnical',false);               
					            gen.writeEndObject();
                    	}
                    	if((errorMsg=='' && memberObj.homephone!=null) 
                    		&& (accountEmailPhoneMap!=null && accountEmailPhoneMap.size()>0) 
                    		&& (accountEmailPhoneMap.get(memberObj.homephone)!=null)){
                    			errorMsg ='Member with duplicate home phone found.';
                    			gen.writeStartObject();
					            gen.writeStringField('frisorecordId',memberObj.frisorecordId);
					            gen.writeStringField('errorDescription',errorMsg);
					            gen.writeBooleanField('isError',true);  
					            gen.writeBooleanField('isSuccess',false);  
					            gen.writeBooleanField('isTechnical',false);               
					            gen.writeEndObject();
                    	}
						if(errorMsg==''){						
								Account actobj = new Account();
								actobj.RecordTypeId = recTypeList[0].id;
								actobj.FirstName = memberObj.firstName;
								actobj.LastName = memberObj.LastName;
								actobj.PersonEmail = memberObj.memberEmail;
								actobj.PersonMobilePhone = memberObj.memberMobile;
								actobj.PersonHomePhone = memberObj.homephone;
								actobj.PersonBirthdate = memberObj.memberDOB;
								actobj.Recruitment_Source__c = memberObj.recruitmentSource;
								actobj.FCHK_Chinese_Address__c= memberObj.chineesAddress;
								//added the following snippet on 18 sep,2015 in phase 2b
								actObj.FCHK_Reject_SMS__c = memberObj.rejectSMS;
								actObj.PersonHasOptedOutOfEmail = memberObj.emailOptOut;
								actObj.FCHK_Reject_DirectMail__c= memberObj.rejectDirectEmail;
								actObj.PersonDoNotCall = memberObj.doNotCall;
								//end of adding
								if(memberObj.country=='Hong Kong'){
									actobj.OpCo__c='HK';
								}
								else{
									actobj.OpCo__c = '   ';
								}
								//Address Mapping
								actobj.FCHK_Floor__c = memberObj.floor;
								actobj.FCHK_Flat__c = memberObj.flat;
								actobj.FCHK_Block__c = memberObj.block;
								actobj.FCHK_Building__c = memberObj.building;
								actobj.FCHK_District__c = memberObj.district;
								actobj.FCHK_Street__c = memberObj.street;
								actobj.FCHK_Territory__c = memberObj.country;
								actobj.FCHK_Estate__c = memberObj.estate;
								actobj.FCHK_FrisoRecordId__c = memberObj.frisorecordId;
								accountList.add(actobj);
						}
						
				}
				if(accountList!=null && accountList.size()>0){					
					List<Database.SaveResult> resultList= Database.insert(accountList,false);
					Set<Id> accountIdSet = new Set<Id>(); 
					Map<String,String> actIdFrisoIdMap = new Map<String,String>();  
					 for(Database.SaveResult resultObj:resultList){
                    	if (resultObj.isSuccess()) {
                    		accountIdSet.add(resultObj.getId());
                    	}
					 }
					if(accountIdSet!=null && accountIdSet.size()>0){
							for(Account actobj:[select id,FCHK_FrisoRecordId__c from Account where id in:accountIdSet]){
								actIdFrisoIdMap.put(actobj.id,actobj.FCHK_FrisoRecordId__c);
							}
					}
					
						                
                    for(Database.SaveResult resultObj:resultList){
                    	if (resultObj.isSuccess()) {
                         // Operation was successful, so get the ID of the record that was processed
	                         System.debug('Successfully inserted account. Account ID: ' + resultObj.getId());	                       
	                         //return 'Success:'+returnErrorMsg('Success',resultObj.getId());
	                         if(actIdFrisoIdMap!=null && actIdFrisoIdMap.size()>0 && actIdFrisoIdMap.get(resultObj.getId())!=null){   
					            gen.writeStartObject();
					            gen.writeStringField('frisorecordId',actIdFrisoIdMap.get(resultObj.getId()));
					            gen.writeStringField('errorDescription','');
					            gen.writeBooleanField('isError',false);  
					            gen.writeBooleanField('isSuccess',true); 
					            gen.writeBooleanField('isTechnical',false);           
					            gen.writeEndObject();
	                         }
					                        
                    	}
	                    else if(resultObj.isSuccess()==false){
	                        // Operation failed, so get all errors     
		                        String errordescription='';           
		                        for(Database.Error err : resultObj.getErrors()) {
		                            errordescription+=' '+err.getStatusCode()+'  '+err.getMessage() +' '+err.getFields();
		                        }
		                        //return 'Error:'+returnErrorMsg('Technical',errordescription);
		                        
		                        gen.writeStartObject();
					            gen.writeStringField('frisorecordId','');
					            gen.writeStringField('errorDescription',errordescription);
					            gen.writeBooleanField('isError',false);  
					            gen.writeBooleanField('isSuccess',false); 
					            gen.writeBooleanField('isTechnical',true);           
					            gen.writeEndObject();
		                        
	                    }  
                    }
                      
				}
				gen.writeEndArray();
				String jsonString= gen.getAsString();	
				if(jsonString!=null && jsonString!=''){
                	successErrorMessage = jsonString;
				}
				System.debug('jsonString@@:'+jsonString);
			}
			
			
			return successErrorMessage;
		}
}