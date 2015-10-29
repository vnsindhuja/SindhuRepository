public with sharing class FCHK_cls_AccountActionscls {       
       @future(callout=true)
       public static void createRecordfrmOptimeltoFriso(String jsonString){
       	   String response = '';
       	   List<Account> accountList = new List<Account>();
       		if(jsonString!=null && jsonString!=''){
       			if(!Test.isRunningTest()){
	       			FrisoCredentials__c frisoObj = FrisoCredentials__c.getValues('FrisoIntegration');
	       			System.debug('User name:'+frisoObj.Username__c);
	       			System.debug('Password:'+frisoObj.Password__c);
	       			if(frisoObj!=null && frisoObj.Username__c!=null 
	       				&& frisoObj.Password__c!=null){
		       			String username = frisoObj.Username__c;
		       			String password = frisoObj.Password__c+(frisoObj.SecurityToken__c!=null?frisoObj.SecurityToken__c:'');
	       				partnerSoapSforceCom.Soap sp=new partnerSoapSforceCom.Soap();
						partnerSoapSforceCom.LoginResult loginResult = sp.login(username, password);
						partnerSoapSforceCom.create_element sobjjjj=new partnerSoapSforceCom.create_element();
						OptimeltofrisoServicecls.OptimeltoFrisomumcls      apexWebSvc = new OptimeltofrisoServicecls.OptimeltoFrisomumcls();
						OptimeltofrisoServicecls.SessionHeader_element sessionHeader = new OptimeltofrisoServicecls.SessionHeader_element();
						sessionHeader.sessionId = loginResult.sessionId; 
						// The Web services have a maximum timeout of 2 minutes. The timeout value
						// is in milliseconds.
						apexWebSvc.timeout_x = 120000;
						apexWebSvc.SessionHeader = sessionHeader;
						response=apexWebSvc.updateMemberfromOptimel(jsonString);
						System.debug('response@@:'+response);
	   				}
       			}
       			else if(Test.isrunningTest()){
	       				JSONGenerator gen=JSON.createGenerator(true);
						gen.writeStartArray();
						gen.writeStartObject();
			            gen.writeStringField('optimelRecordId','00104sdfasdf');
			            gen.writeStringField('recordId','0014534sdafsda');
			            gen.writeStringField('errorDescription','');
			            gen.writeBooleanField('isError',false);  
			            gen.writeBooleanField('isSuccess',true); 
			            gen.writeBooleanField('isTechnical',false);           
			            gen.writeEndObject();
			            gen.writeEndArray();
						String jsonString1= gen.getAsString();
						response = jsonString1;	
       			}
       			
       			if(response!=null && response!=''){
							List<FrisoErrorParserCls.FrisoErrParsercls> optimeltoFrisoDetailList = 
								(List<FrisoErrorParserCls.FrisoErrParsercls>)JSON.deSerialize(response,
												List<FrisoErrorParserCls.FrisoErrParsercls>.class);
							if(optimeltoFrisoDetailList!=null && optimeltoFrisoDetailList.size()>0){
									for(FrisoErrorParserCls.FrisoErrParsercls frisoparserObj:optimeltoFrisoDetailList){
											System.debug('Error Des:'+frisoparserObj.errorDescription+'##:'+frisoparserObj.isError+'isTechnical@:'+frisoparserObj.isTechnical);
											if(frisoparserObj.optimelRecordId!=null && frisoparserObj.optimelRecordId!='' 
												&& frisoparserObj.isSuccess==true && frisoparserObj.recordId!=null 
												&& frisoparserObj.recordId!=''){
												if(!Test.isRunningTest()){
													Account actObj = new Account(id=frisoparserObj.optimelRecordId ,FCHK_CreatedinFrisomum__c=true);
													accountList.add(actObj);
												}
											}
									}
									if(!Test.isRunningTest()){
										List<Database.SaveResult> resultList = database.update(accountList,false);
										System.debug('resultList@@:'+resultList);
									}
									
							}
				}
       			
       		}
       }
       public static void copyRecOptimeltoFriso(List<Account> accountList){
       		String jsonString = prepareJsonString(accountList);
       		if(jsonString!=null && jsonString!=''){
       			createRecordfrmOptimeltoFriso(jsonString);
       		}
       }
       public static String  prepareJsonString(List<Account> accountList){
       		JSONGenerator gen=JSON.createGenerator(true);
			gen.writeStartArray();
			for(Account actObj:accountList){
				gen.writeStartObject();
				gen.writeStringField('Name',actobj.Name);
				if(actobj.FCHK_18_District_Chi__c!=null && actobj.FCHK_18_District_Chi__c!=''){
					gen.writeStringField('districtChina',actobj.FCHK_18_District_Chi__c);
				}
				if(actobj.FCHK_18_District_Eng__c!=null && actobj.FCHK_18_District_Eng__c!=''){
					gen.writeStringField('districtEng',actobj.FCHK_18_District_Eng__c);
				}
				if(actobj.FCHK_Address_Chi__c!=null && actobj.FCHK_Address_Chi__c!=''){
					gen.writeStringField('addressChin',actobj.FCHK_Address_Chi__c);
				}
				if(actobj.FCHK_Area_Chi__C!=null && actobj.FCHK_Area_Chi__C!=''){
					gen.writeStringField('areaChin',actobj.FCHK_Area_Chi__C);
				}
				if(actobj.FCHK_Area_Eng__C!=null && actobj.FCHK_Area_Eng__C!=''){
					gen.writeStringField('areaEng',actobj.FCHK_Area_Eng__C);
				}
				if(actobj.FCHK_Block__c!=null && actobj.FCHK_Block__c!=''){
					gen.writeStringField('block',actobj.FCHK_Block__c);
				}
				if(actobj.FCHK_Building__c!=null && actobj.FCHK_Building__c!=''){
					gen.writeStringField('building',actobj.FCHK_Building__c);
				}
				if(actobj.FCHK_Business_Hours__c!=null && actobj.FCHK_Business_Hours__c!=''){
					gen.writeStringField('businessHours',actobj.FCHK_Business_Hours__c);
				}
				if(actobj.FCHK_District__c!=null && actobj.FCHK_District__c!=''){
					gen.writeStringField('district',actobj.FCHK_District__c);
				}
				if(actobj.FCHK_Estate__c!=null && actobj.FCHK_Estate__c!=''){
					gen.writeStringField('estate',actobj.FCHK_Estate__c);
				}
				if(actobj.FCHK_F1_Trail__c!=null && actobj.FCHK_F1_Trail__c!=''){
					gen.writeStringField('f1Trail',actobj.FCHK_F1_Trail__c);
				}
				if(actobj.Fax!=null && actobj.Fax!=''){
					gen.writeStringField('fax',actobj.Fax);
				}
				if(actobj.FCHK_Flat__c!=null && actobj.FCHK_Flat__c!=''){
					gen.writeStringField('flat',actobj.FCHK_Flat__c);
				}
				if(actobj.FCHK_Floor__c!=null && actobj.FCHK_Floor__c!=''){
					gen.writeStringField('floor',actobj.FCHK_Floor__c);
				}
				if(actobj.FCHK_Infer_recommendation__c!=null && actobj.FCHK_Infer_recommendation__c!=''){
					gen.writeStringField('inferRecom',actobj.FCHK_Infer_recommendation__c);
				}
				if(actobj.FCHK_Medical_Rep__C!=null && actobj.FCHK_Medical_Rep__C!=''){
					gen.writeStringField('medicalRep',actobj.FCHK_Medical_Rep__C);
				}
				if(actobj.FCHK_Patient_Flow__C!=null && actobj.FCHK_Patient_Flow__C!=''){
					gen.writeStringField('patientFlow',actobj.FCHK_Patient_Flow__C);
				}
				if(actobj.FCHK_Patient_type__c!=null && actobj.FCHK_Patient_type__c!=''){
					gen.writeStringField('patientType',actobj.FCHK_Patient_type__c);
				}
				if(actobj.FCHK_Relevancy__c!=null && actobj.FCHK_Relevancy__c!=''){
					gen.writeStringField('releVancy',actobj.FCHK_Relevancy__c);
				}
				if(actobj.FCHK_Specialist__c!=null && actobj.FCHK_Specialist__c!=''){
					gen.writeStringField('specialist',actobj.FCHK_Specialist__c);
				}
				if(actobj.phone!=null && actobj.phone!=''){
					gen.writeStringField('phone',actobj.phone);
				}
				if(actobj.FCHK_MedicalType__c!=null && actobj.FCHK_MedicalType__c!=''){
					gen.writeStringField('medicalType',actobj.FCHK_MedicalType__c);
				}
				if(actobj.FCHK_Classification__c!=null && actobj.FCHK_Classification__c!=''){
					gen.writeStringField('classification',actobj.FCHK_Classification__c);
				}
				if(actobj.FCHK_Street__c!=null && actobj.FCHK_Street__c!=null){
					gen.writeStringField('street',actobj.FCHK_Street__c);	
				}
				if(actObj.FCHK_Country__c!=null && actobj.FCHK_Country__c!=null){
					gen.writeStringField('country',actobj.FCHK_Country__c);
				}
				if(actobj.id!=null){
					gen.writeStringField('optimelRecId',actobj.id);
				}
				
				gen.writeEndObject();
			}
			gen.writeEndArray();
			String jsonString= gen.getAsString();
			System.debug('jsonString:::'+jsonString);
			if(jsonString!=null && jsonString!='')
       			return jsonString;
       		else
       			return '';
       }
}