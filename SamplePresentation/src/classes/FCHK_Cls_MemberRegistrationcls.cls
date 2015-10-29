global class FCHK_Cls_MemberRegistrationcls {
    /*
       JsonString eg:{"lastName":null,"firstName":null,"memberPhone":null,"memberEmail":null,"birthDay":null,"birthMonth":null,"birthYear":null,"userName":null,"password":null,"referredBy":"001O000000kqJna"}
        
    */
    webservice static String registerMember(String memberDetails,boolean isCreate){
       if(isCreate==true){
            String message='';
            String errorMessage='';     
            /*MemberDetailParsercls.memberDetailcls  memberDetailObj = (MemberDetailParsercls.memberDetailcls)JSON.deserialize(memberDetails,MemberDetailParsercls.memberDetailcls.class);*/
            FCHK_Cls_MemberDetailParsercls.FCHK_Cls_MemberDetailcls memberDetailObj = (FCHK_Cls_MemberDetailParsercls.FCHK_Cls_MemberDetailcls)JSON.deserialize(memberDetails, FCHK_Cls_MemberDetailParsercls.FCHK_Cls_MemberDetailcls.class);
            /*Validations starts */    
            	if((memberDetailObj.memberPhone==null && memberDetailObj.homePhone==null) || (memberDetailObj.memberPhone=='' && memberDetailObj.homePhone=='')){
            		 return 'Error:'+returnErrorMsg('validation','Please Enter Mobile or Home Phone.');
            		
            	}
                if((memberDetailObj.memberPhone==null && memberDetailObj.memberEmail==null) || (memberDetailObj.memberPhone=='' && memberDetailObj.memberEmail=='')){
                        return 'Error:'+returnErrorMsg('validation','Please Enter Mobile or Email Address.');
                }  
                else if(memberDetailObj.memberPhone!=null && memberDetailObj.memberPhone!='' 
                        && !memberDetailObj.memberPhone.isNumeric()){
                    return 'Error:'+returnErrorMsg('invalidFieldValues','Invalid Mobile Number.');
                }
                /*else if(memberDetailObj.memberEmail!=null && memberDetailObj.memberEmail!='' 
                        && validateEmail(memberDetailObj.memberEmail)==false){
                    return 'Error:'+returnErrorMsg('invalidFieldValues','Invalid Email.');              
                }*/
                else if(memberDetailObj.birthDay!=null && memberDetailObj.birthDay!='' 
                        && memberDetailObj.birthDay!='Day' && !memberDetailObj.birthDay.isNumeric()){                       
                    return 'Error:'+returnErrorMsg('invalidFieldValues','Invalid Birth Day.');
                }
                else if(memberDetailObj.birthMonth!=null && memberDetailObj.birthMonth!='' 
                        && memberDetailObj.birthMonth!='Month' && !memberDetailObj.birthMonth.isNumeric()){
                    return 'Error:'+returnErrorMsg('invalidFieldValues','Invalid Birth Month.');
                }
                else if(memberDetailObj.birthYear!=null && memberDetailObj.birthYear!='' 
                        &&  memberDetailObj.birthYear!='Year' && !memberDetailObj.birthYear.isNumeric()){
                    return 'Error:'+returnErrorMsg('invalidFieldValues','Invalid Birth Year.');
                }            
            /*End of Validations */           
            /*
                Starting of Duplicate Checking in leads(members) and personAccounts
            */     
                List<Account> dupPerAccountList = new List<Account>(); //To hold existing Person Account         
                if(memberDetailObj.memberPhone!=null && memberDetailObj.memberEmail!=null && memberDetailObj.homePhone!=null){
                    dupPerAccountList = [select id,PersonMobilePhone,personEmail from Account 
                            where (PersonMobilePhone=:memberDetailObj.memberPhone and personEmail=:memberDetailObj.memberEmail 
                            and PersonHomePhone=:memberDetailObj.homePhone)  
                            and isPersonAccount=true limit 1]; 
                                if((dupPerAccountList!=null && dupPerAccountList.size()>0)){                                    
                                     errorMessage ='Error:'+returnErrorMsg('EmailPhoneHomePhoneFound',System.label.FCH_CL_EmailPhoneHomeFound);
                                     return errorMessage;
                                } 
                }       
                if(dupPerAccountList.size()==0 && memberDetailObj.memberPhone!=null && memberDetailObj.memberEmail!=null){
                    dupPerAccountList = [select id,PersonMobilePhone,personEmail from Account 
                            where (PersonMobilePhone=:memberDetailObj.memberPhone and personEmail=:memberDetailObj.memberEmail)  
                            and isPersonAccount=true limit 1]; 
                                if((dupPerAccountList!=null && dupPerAccountList.size()>0)){                                    
                                     errorMessage ='Error:'+returnErrorMsg('EmailPhoneFound',System.label.FCHK_CL_EmailPhoneFound);
                                     return errorMessage;
                                } 
                }
                if(dupPerAccountList.size()==0 && memberDetailObj.homePhone!=null){
                        dupPerAccountList = [select id,PersonMobilePhone,personEmail from Account 
                            where PersonHomePhone=:memberDetailObj.homePhone and isPersonAccount=true limit 1];
                                if((dupPerAccountList!=null && dupPerAccountList.size()>0)){                                    
                                     errorMessage ='Error:'+returnErrorMsg('HomePhoneFound',System.label.FCHK_CL_Homephonefound);
                                      return errorMessage;
                                }    
                }  
                if(dupPerAccountList.size()==0 && memberDetailObj.memberEmail!=null){
                        dupPerAccountList = [select id,PersonMobilePhone,personEmail from Account 
                            where personEmail=:memberDetailObj.memberEmail and isPersonAccount=true limit 1];
                                if((dupPerAccountList!=null && dupPerAccountList.size()>0)){                                    
                                     errorMessage ='Error:'+returnErrorMsg('EmailFound',System.label.FCHK_CL_EmailFound);
                                      return errorMessage;
                                }    
                }  
                if(dupPerAccountList.size()==0 && memberDetailObj.memberPhone!=null){         
                        dupPerAccountList = [select id,phone,personEmail from Account 
                            where PersonMobilePhone=:memberDetailObj.memberPhone and isPersonAccount=true limit 1];  
                                if((dupPerAccountList!=null && dupPerAccountList.size()>0)){                                    
                                     errorMessage ='Error:'+returnErrorMsg('MobileFound',System.label.FCHK_CL_MobileFound);
                                    return errorMessage;
                                }             
                }
                    
                       
            //End of duplicate checking in personAccounts
            if(errorMessage==''){
                Map<String,Id> recordTypeIdMap = new Map<String,Id>();
                List<RecordType> recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account' 
                    and recordType.developerName='FCHK_MR_RT_Optimel' limit 1];
                if(recTypeList!=null && recTypeList.size()>0){
                    AppLiteralscls.stopAccountAction=true;
                    Account actobj= new Account();
                    if(memberDetailObj.firstName!=null && memberDetailObj.firstName!=''){
                          actobj.FirstName = memberDetailObj.firstName;
                    }
                    actobj.LastName = memberDetailObj.lastName!=null && memberDetailObj.lastName!=''?memberDetailObj.lastName:'    ';
                    if(memberDetailObj.memberPhone!=null && memberDetailObj.memberPhone!=''){
                         actobj.PersonMobilePhone = memberDetailObj.memberPhone;
                    }
                    if(memberDetailObj.memberEmail!=null && memberDetailObj.memberEmail!=''){
                        actobj.personEmail = memberDetailObj.memberEmail;
                        actobj.Member_Login_Name__c =memberDetailObj.memberEmail;
                    }        
                    if(memberDetailObj.password!=null && memberDetailObj.password!=''){        
                        actobj.FCHK_Password__c = memberDetailObj.password;
                    }
                    if(recTypeList[0].id!=null){
                        actObj.RecordTypeId=recTypeList[0].id;
                    }
                    if(memberDetailObj.birthDay!=null && memberDetailObj.birthDay!=''){
                        actObj.Birth_Day__c = memberDetailObj.birthDay;
                    }
                    if(memberDetailObj.birthMonth!=null && memberDetailObj.birthMonth!=''){
                        actobj.Birth_Month__c = memberDetailObj.birthMonth;
                    }
                    if(memberDetailObj.birthYear!=null && memberDetailObj.birthYear!=''){
                        actobj.Birth_Year__c = memberDetailObj.birthYear; 
                    }
                    if(memberDetailObj.gender!=null && memberDetailObj.gender!=''){
                        actobj.Gender__c = memberDetailObj.gender;
                    }
                    if(memberDetailObj.birthDay!=null && memberDetailObj.birthDay!='' 
                        &&  memberDetailObj.birthMonth!=null && memberDetailObj.birthMonth!='' 
                        && memberDetailObj.birthYear!=null && memberDetailObj.birthYear!='' 
                        && memberDetailObj.birthDay.isNumeric() 
                        && memberDetailObj.birthMonth.isNumeric()
                        && memberDetailObj.birthYear.isNumeric()){
                        actobj.PersonBirthdate=Date.newInstance(integer.valueof(memberDetailObj.birthYear),integer.valueOf(memberDetailObj.birthMonth),integer.valueOf(memberDetailObj.birthDay));                  
                    }               
                    actobj.FCHK_Active__c = true;
                    actobj.Recruitment_Source__c = (memberDetailObj.recruitmentSource!=null && memberDetailObj.recruitmentSource!='')?memberDetailObj.recruitmentSource:'Website';
                    if(memberDetailObj.registrationType!=null && memberDetailObj.registrationType!=''){
                        actobj.FCHK_Registration_Type__c = memberDetailObj.registrationType;
                    }
                    else{
                        actobj.FCHK_Registration_Type__c = 'Simple';
                    }
                    if(memberDetailObj.homePhone!=null){
                        actobj.PersonHomePhone = memberDetailObj.homePhone;
                    }
                    //for interest fields
                    if(memberDetailObj.health!=null){
                        actobj.FCHK_Health__c = memberDetailObj.health;
                    }
                    if(memberDetailObj.familyActivities!=null){
                        actobj.FCHK_Family_Activities__c = memberDetailObj.familyActivities;
                    }
                    if(memberDetailObj.foodandNutrition!=null){
                        actobj.FCHK_Food_and_Nutrition__c=memberDetailObj.foodandNutrition;
                    }
                    if(memberDetailObj.travel!=null){
                        actObj.FCHK_Travel__c = memberDetailObj.travel;
                    }
                    if(memberDetailObj.entertainmentandLeisure!=null){
                        actobj.FCHK_Entertainment_Leisure__c = memberDetailObj.entertainmentandLeisure;
                    }
                    if(memberDetailObj.shopping!=null){
                        actobj.FCHK_Shopping__c = memberDetailObj.shopping;                     
                    }
                    if(memberDetailObj.sportsandWellness!=null){
                        actobj.FCHK_Sports_and_Wellness__c = memberDetailObj.sportsandWellness; 
                    }
                    if(memberDetailObj.retirementPlanning!=null){
                        actobj.FCHK_Retirement_Planning__c = memberDetailObj.retirementPlanning;
                    }
                    //Ending for interest fields 
                    if(memberDetailObj.agreeTerms!=null){
                        actobj.FCHK_AgreeTerms__c = memberDetailObj.agreeTerms;
                    }
                    if(memberDetailObj.referredOn!=null){
                    	actobj.FCHK_Referred_On__c = memberDetailObj.referredOn;
                    }
                    if(memberDetailObj.referredBy!=null){
                    	actobj.FCHK_Referred_By__c = memberDetailObj.referredBy;
                    }
                    if(memberDetailObj.promotionCode!=null){
                    	actobj.FCHK_Promotion_Code__c = memberDetailObj.promotionCode;
                    }
                    /*if(memberDetailObj.faceBookId!=null && memberDetailObj.faceBookId!=''){
                        //actobj.FCHK_Facebook_id__c = memberDetailObj.faceBookId;
                    }*/
                    Database.SaveResult resultObj= Database.insert(actobj,false);
                    System.debug('resultObj@@:'+resultObj);
                    if (resultObj.isSuccess()) {
                         // Operation was successful, so get the ID of the record that was processed
                         System.debug('Successfully inserted account. Account ID: ' + resultObj.getId());
                         System.debug(returnErrorMsg('Success',resultObj.getId()));
                         return 'Success:'+returnErrorMsg('Success',resultObj.getId());                    
                    }
                    else if(resultObj.isSuccess()==false){
                        // Operation failed, so get all errors     
                        String errordescription='Error:';           
                        for(Database.Error err : resultObj.getErrors()) {
                            errordescription+=' '+err.getStatusCode()+'  '+err.getMessage();
                        }
                        return 'Error:'+returnErrorMsg('Technical',errordescription);
                    }    
                   
                }           
            }
            
            return message;
        }
        else {
              return 'Success:'+returnErrorMsg('false','');             
        }
    }
    global static String returnErrorMsg(String errType,String errMsgorId){
        String errorMessage = '';
        if(errType=='Success'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','true');
            gen.writeStringField('RecordId',errMsgorId);
            gen.writeEndObject();
            errorMessage = gen.getAsString();           
        }
        else if(errType=='EmailFound'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');
            gen.writeStringField('errorCode','FCMR001');
            gen.writeStringField('errorDescription',errMsgorId);            
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='MobileFound'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');
            gen.writeStringField('errorCode','FCMR002');
            gen.writeStringField('errorDescription',errMsgorId);            
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='EmailPhoneFound'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');
            gen.writeStringField('errorCode','FCMR003');
            gen.writeStringField('errorDescription',errMsgorId);            
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='EmailPhoneHomePhoneFound'){
        	/*added for homephone de duplication  */
        	JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');
            gen.writeStringField('errorCode','FCMR008');
            gen.writeStringField('errorDescription',errMsgorId);            
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='HomePhoneFound'){
        	/*added for homephone de duplication  */
        	JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');
            gen.writeStringField('errorCode','FCMR009');
            gen.writeStringField('errorDescription',errMsgorId);            
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='false'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','true');                      
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='extraFields'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');     
            gen.writeStringField('errorCode','FCMR004');
            gen.writeStringField('errorDescription',errMsgorId);                    
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='invalidFieldValues'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');     
            gen.writeStringField('errorCode','FCMR005');
            gen.writeStringField('errorDescription',errMsgorId);                    
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='validation'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');     
            gen.writeStringField('errorCode','FCMR006');
            gen.writeStringField('errorDescription',errMsgorId);                    
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }       
        else if(errType=='Technical'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');     
            gen.writeStringField('errorCode','503');
            gen.writeStringField('errorDescription','Technical Error'); 
            gen.writeStringField('errorDetail',errMsgorId);                 
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }
        else if(errType=='nomemberexistwithmobile'){
            JSONGenerator gen=JSON.createGenerator(true);       
            gen.writeStartObject();
            gen.writeStringField('result','false');     
            gen.writeStringField('errorCode','FCMR007');
            gen.writeStringField('errorDescription',errMsgorId);                    
            gen.writeEndObject();
            errorMessage = gen.getAsString();
        }      
        return errorMessage;
    }   
   webservice static String sendPassword(String userName){
        List<Account> dupPerAccountList = new List<Account>();
        String password='';
        if(userName!=null && userName!=''){ //check user  name and header is mirum /TAP with a SOAP header
           dupPerAccountList = [select id,PersonMobilePhone,personEmail,FCHK_Password__c from Account 
                    where Member_Login_Name__c=:userName and isPersonAccount=true limit 1];          
                if(dupPerAccountList!=null && dupPerAccountList.size()>0){
                        if(dupPerAccountList[0].FCHK_Password__c!=null){
                            password = 'Success:'+dupPerAccountList[0].FCHK_Password__c;
                        }
                        else{
                            password = 'Error:'+System.label.FCHK_CL_PasswordNotFound;
                        }
                }
                else{
                        password = 'Error:'+System.label.FCHK_CL_MemberNotfound;
                }
        }
        
        return password;
    }
   
}