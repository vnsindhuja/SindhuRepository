public class FCHK_class_MemberSearchctrl
{   
    public List<Account> accountList{get;set;}
    public Boolean renderBlock{get;set;}
    public String insertBlock{get;set;}
     public String updateBlock{get;set;}
    public String actId{get;set;}
    public Account actObj{get;set;}
    public Contact conObj{get;set;}
    public String actFirstName{get;set;}
    public String actLastName{get;set;}
    List<Account> actList = new List<Account>();
    Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND DeveloperName= 'FCHK_MR_RT_Optimel'].id;
    public FCHK_class_MemberSearchctrl(){
      updateBlock = 'No';
      insertBlock = 'No';
        renderBlock = false;
        conObj= new Contact();
        accountList= new List<Account>();
        actObj = new Account();         
     }
   
    public PageReference SearchRecords(){ 
        accountList.Clear(); 
        renderBlock = false;    
        String sRecordType = 'FCHK_MR_RT_Optimel';
         if( actObj.PersonMobilePhone == null && actObj.PersonHomePhone == null )
            {
                renderBlock = false;
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please Enter Mobile or Home Phone.'));
                 return null;
                
            }
         
       String sQryString = 'Select Name,FirstName,LastName,PersonEmail,PersonHomePhone,PersonMobilePhone,PersonBirthdate,Recruitment_Source__c,FCHK_Referred_By__c,'
                           +'FCHK_Registration_Type__c,Gender__c,FCHK_FM1_First_Name__c,FCHK_FM1_Gender__c,FCHK_FM1_DOB__c,FCHK_FM1_Relationship_With_Member__c,'
                           +'FCHK_Flat__c,FCHK_Chinese_Address__c,FCHK_Shipping_Address__c,FCHK_Floor__c,FCHK_Block__c,FCHK_Building__c,FCHK_Estate__c,FCHK_Street__c,FCHK_Territory__c,'
                           +'FCHK_District__c,FCHK_Reject_SMS__c,PersonHasOptedOutOfEmail,FCHK_Reject_DirectMail__c,PersonDoNotCall,FCHK_User_of_Optimel__c,'
                           +'FCHK_FM1_Last_Name__c,Hospital_Clinic_MCHC_Name__c,FCHK_Referred_On__c,   FCHK_Grip_Test__c,FCHK_Bone_Test__c,'
                           +'FCHK_Systolic_BP__c,FCHK_Diastolic_BP__c from Account where recordType.DeveloperName =\''+sRecordType+'\' ';
        if(actObj.PersonEmail != null || actObj.PersonMobilePhone!=null || actObj.PersonHomePhone!=null){
          sQryString +='and (';
        }
        if(actObj.PersonEmail != null && actObj.PersonMobilePhone!=null && actObj.PersonHomePhone!=null){
          sQryString+=' personEmail =\''+actObj.PersonEmail+'\' or';
          sQryString+=' PersonMobilePhone =\''+actObj.PersonMobilePhone+'\' or';
          sQryString+=' PersonHomePhone =\''+actObj.PersonHomePhone+'\'';
        }
        if(actObj.PersonEmail != null && actObj.PersonMobilePhone!=null && actObj.PersonHomePhone==null ){
            sQryString+=' personEmail =\''+actObj.PersonEmail+'\'or';
            sQryString+=' PersonMobilePhone =\''+actObj.PersonMobilePhone+'\'';
        }
        if(actObj.PersonEmail != null && actObj.PersonMobilePhone==null && actObj.PersonHomePhone!=null ){
            sQryString+=' personEmail =\''+actObj.PersonEmail+'\'or';
            sQryString+=' PersonHomePhone =\''+actObj.PersonHomePhone+'\'';
        }
        if(actObj.PersonEmail != null && actObj.PersonMobilePhone==null && actObj.PersonHomePhone==null ){
            sQryString+=' personEmail =\''+actObj.PersonEmail+'\'';
        }
        if(actObj.PersonEmail == null && actObj.PersonMobilePhone!=null && actObj.PersonHomePhone!=null ){
            sQryString+=' PersonMobilePhone =\''+actObj.PersonMobilePhone+'\'or';
          sQryString+=' PersonHomePhone =\''+actObj.PersonHomePhone+'\'';
        }
        if(actObj.PersonEmail == null && actObj.PersonMobilePhone!=null && actObj.PersonHomePhone==null ){
            sQryString+=' PersonMobilePhone =\''+actObj.PersonMobilePhone+'\'';
        }
        if(actObj.PersonEmail == null && actObj.PersonMobilePhone ==null && actObj.PersonHomePhone!=null ){
            sQryString+=' PersonHomePhone =\''+actObj.PersonHomePhone+'\'';
        }
        
       
        if(sQryString.contains('(')){
          sQryString +=')';
        }
        system.debug('##querystring '+sQryString );   
        accountList = Database.query(sQryString);
        system.debug('#accountList '+accountList);
        Set<Id> ids=new set<Id>();
        Map<Id,Account> accountMap = new Map<Id,Account>();
        if(accountList!=null && accountList.size()==1){
            for(Account actObject: accountList){
              
              ids.add(actObject.id);
              Account accountObj = new Account(id=actObject.id);
                accountObj.firstName=(actFirstName==null && actFirstName==''?actFirstName:actObject.FirstName);
                accountObj.lastName=(actObject.lastName==null ?conObj.LastName:actObject.lastName );
                accountObj.Recruitment_Source__c=(actObject.Recruitment_Source__c==null ?actObj.Recruitment_Source__c:actObject.Recruitment_Source__c);
               if(actObject.PersonBirthdate==null){
                    accountObj.PersonBirthdate=actObj.PersonBirthdate;
                }
                accountObj.PersonMobilePhone=(actObject.PersonMobilePhone==null ?actObj.PersonMobilePhone:actObject.PersonMobilePhone);
                accountObj.PersonEmail=(actObject.PersonEmail ==null ?actObj.PersonEmail:actObject.PersonEmail );
                 accountObj.PersonHomePhone=(actObject.PersonHomePhone==null ?actObj.PersonHomePhone:actObject.PersonHomePhone);
                accountObj.FCHK_Registration_Type__c=(actObject.FCHK_Registration_Type__c ==null?actObj.FCHK_Registration_Type__c:actObject.FCHK_Registration_Type__c );
                accountObj.Gender__c=(actObject.Gender__c ==null ?actObj.Gender__c:actObject.Gender__c );
                accountObj.FCHK_User_of_Optimel__c=(actObject.FCHK_User_of_Optimel__c ==null?actObj.FCHK_User_of_Optimel__c:actObject.FCHK_User_of_Optimel__c );
                accountObj.FCHK_FM1_First_Name__c=(actObject.FCHK_FM1_First_Name__c ==null ?actObj.FCHK_FM1_First_Name__c:actObject.FCHK_FM1_First_Name__c );
                accountObj.FCHK_FM1_Last_Name__c=(actObject.FCHK_FM1_Last_Name__c ==null ?actObj.FCHK_FM1_Last_Name__c:actObject.FCHK_FM1_Last_Name__c );
                accountObj.FCHK_FM1_Gender__c=(actObject.FCHK_FM1_Gender__c ==null ?actObj.FCHK_FM1_Gender__c:actObject.FCHK_FM1_Gender__c );
                accountObj.FCHK_FM1_DOB__c=(actObject.FCHK_FM1_DOB__c ==null ?actObj.FCHK_FM1_DOB__c:actObject.FCHK_FM1_DOB__c );
                accountObj.FCHK_FM1_Relationship_With_Member__c=(actObject.FCHK_FM1_Relationship_With_Member__c ==null?actObj.FCHK_FM1_Relationship_With_Member__c:actObject.FCHK_FM1_Relationship_With_Member__c );
                if(actObject.FCHK_Flat__c==null && actObject.FCHK_Chinese_Address__c ==false && actObject.FCHK_Shipping_Address__c==null && actObject.FCHK_Floor__c ==null && actObject.FCHK_Block__c==null && actObject.FCHK_Building__c==null && actObject.FCHK_Estate__c==null && actObject.FCHK_Street__c==null && actObject.FCHK_Territory__c==null && actObject.FCHK_District__c==null){
                      accountObj.FCHK_Flat__c=actObj.FCHK_Flat__c;
                      accountObj.FCHK_Chinese_Address__c=  actObj.FCHK_Chinese_Address__c;
                      accountObj.FCHK_Shipping_Address__c= actObj.FCHK_Shipping_Address__c;
                      accountObj.FCHK_Floor__c = actObj.FCHK_Floor__c;
                      accountObj.FCHK_Block__c=actObj.FCHK_Block__c;
                      accountObj.FCHK_Building__c=actObj.FCHK_Building__c;
                      accountObj.FCHK_Estate__c=actObj.FCHK_Estate__c;
                      accountObj.FCHK_Street__c=actObj.FCHK_Street__c;
                      accountObj.FCHK_Territory__c=actObj.FCHK_Territory__c;
                      accountObj.FCHK_District__c=actObj.FCHK_District__c;
                }
                if(actObject.FCHK_Reject_SMS__c==false){
                        accountObj.FCHK_Reject_SMS__c=actObj.FCHK_Reject_SMS__c;
                    }
                if(actObject.PersonHasOptedOutOfEmail==false){
                    accountObj.PersonHasOptedOutOfEmail=actObj.PersonHasOptedOutOfEmail;
                }
                if(actObject.FCHK_Reject_DirectMail__c==false){
                    accountObj.FCHK_Reject_DirectMail__c=actObj.FCHK_Reject_DirectMail__c;
                }
                if(actObject.PersonDoNotCall==false){
                    accountObj.PersonDoNotCall=actObj.PersonDoNotCall;
                }
               
                    
                //accountObj.FCHK_HCP_Member__c=(actObject.FCHK_HCP_Member__c ==false?actObj.FCHK_HCP_Member__c:actObject.FCHK_HCP_Member__c);
               // accountObj.FCHK_HCP_Member_Name__c=(actObject.FCHK_HCP_Member_Name__c==null ?actObj.FCHK_HCP_Member_Name__c:actObject.FCHK_HCP_Member_Name__c);
                accountObj.Hospital_Clinic_MCHC_Name__c=(actObject.Hospital_Clinic_MCHC_Name__c==null ?actObj.Hospital_Clinic_MCHC_Name__c:actObject.Hospital_Clinic_MCHC_Name__c);
                //accountObj.FCHK_Member_Type__c=(actObject.FCHK_Member_Type__c==null ?actObj.FCHK_Member_Type__c:actObject.FCHK_Member_Type__c);
                accountObj.FCHK_Referred_By__c=(actObject.FCHK_Referred_By__c==null?actObj.FCHK_Referred_By__c:actObject.FCHK_Referred_By__c);
                accountObj.FCHK_Referred_On__c=(actObject.FCHK_Referred_On__c==null?actObj.FCHK_Referred_On__c:actObject.FCHK_Referred_On__c);
                accountObj.FCHK_Grip_Test__c=(actObject.FCHK_Grip_Test__c==null ?actObj.FCHK_Grip_Test__c:actObject.FCHK_Grip_Test__c);
                accountObj.FCHK_Bone_Test__c=(actObject.FCHK_Bone_Test__c==null ?actObj.FCHK_Bone_Test__c:actObject.FCHK_Bone_Test__c);
                accountObj.FCHK_Diastolic_BP__c=(actObject.FCHK_Diastolic_BP__c==null ?actObj.FCHK_Diastolic_BP__c:actObject.FCHK_Diastolic_BP__c);
                 accountObj.FCHK_Systolic_BP__c=(actObject.FCHK_Systolic_BP__c==null ?actObj.FCHK_Systolic_BP__c:actObject.FCHK_Systolic_BP__c);
                accountObj.recordTypeId=recordTypeIds;  
             
                
               accountMap.put(accountObj.id,accountobj);            
            }
            try{
              update accountMap.values();
            actFirstName='';
              conObj.LastName=null;
              actobj= new Account();
              updateBlock = 'Yes'; 
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Account is Successfully Updated . '));
              renderBlock = true;
            }
            catch(Exception ex){
                updateBlock = 'No'; 
                ApexPages.addMessages(ex);
            }
      
            accountList.Clear();
            
           accountList = [Select id,Name,FirstName,LastName,PersonEmail,PersonHomePhone,PersonMobilePhone,PersonBirthdate,Recruitment_Source__c,FCHK_Referred_By__c from Account where recordType.DeveloperName =:sRecordType
                       and id in :ids];
        
        }
        else if(accountList.size() > 1){
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Duplicate records found from two different Members.'));
            renderBlock = false;
        }
        
        if(accountList.IsEmpty())
        {
          actObj.firstName=actFirstName;
          actObj.lastName=conObj.LastName;
          actObj.recordTypeId=recordTypeIds ;
          try{
            upsert actObj;
            actFirstName='';
            conObj.LastName=null;
            actobj= new Account();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Account is Successfully Created.'));
          
          }
          catch(Exception ex){
         
            insertBlock = 'No';
        ApexPages.addMessages(ex);
      }
           //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sorry,We do not have such Record,one new account has created'));   
        }
        return null;
    }
        /*public PageReference CreateRecords(){ 
        
        if(accountList.IsEmpty())
        {
          actObj.firstName=actFirstName;
          actObj.lastName=conObj.LastName;
          actObj.recordTypeId=recordTypeIds ;
          try{
            insertBlock = 'Yes';
            upsert actObj;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Account is created.'));
            actFirstName='';
            actLastName='';
            actobj= new Account();
            
          
          }
          catch(Exception ex){
            insertBlock = 'No';
        ApexPages.addMessages(ex);
      }
           //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sorry,We do not have such Record,one new account has created'));   
        }
        return null;
    }*/
             
}