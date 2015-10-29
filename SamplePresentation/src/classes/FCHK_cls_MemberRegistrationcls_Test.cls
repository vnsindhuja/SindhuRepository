@isTest
private class FCHK_cls_MemberRegistrationcls_Test {

   
    static testMethod void myUnitTest() {
        String jsonString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898989","memberPhone":"59875464","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
            
        
        FCHK_Cls_MemberRegistrationcls.registerMember(jsonString,true);
        FCHK_Cls_MemberRegistrationcls.sendPassword('mbalaji105@gmail.com');
        String withoutPhoneemailString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898988","memberPhone":null,"memberEmail":null,"birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
         FCHK_Cls_MemberRegistrationcls.registerMember(withoutPhoneemailString,true);
          String invalidMobileNumberString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898987","memberPhone":"2342wer","memberEmail":null,"birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidMobileNumberString,true);
          String invalidEmailString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898986","memberPhone":"59825646","memberEmail":"mbalaji105@@@","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidEmailString,true);           

            String invalidBirthdayString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898985","memberPhone":"54545458","memberEmail":"mbalaji106@gmail.com","birthDay":"qw","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidBirthdayString,true);
            String invalidBirthMonthString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898984","memberPhone":"54545457","memberEmail":"mbalaji106@gmail.com","birthDay":"25","birthMonth":"qw","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidBirthMonthString,true);
            String invalidBirthYearString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898983","memberPhone":"54545456","memberEmail":"mbalaji106@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"qw",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidBirthYearString,true);
         String jsonString1 = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898982","memberPhone":"54545455","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
           FCHK_Cls_MemberRegistrationcls.registerMember(jsonString1,true);        
         String mobileFound = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898981","memberPhone":"54545459","memberEmail":"mbalaji106@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
        FCHK_Cls_MemberRegistrationcls.registerMember(mobileFound,true);
         String emailFound = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898980","memberPhone":"54545448","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
        FCHK_Cls_MemberRegistrationcls.registerMember(emailFound,true);  
        String lengthyString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898979","memberPhone":"54545449","memberEmail":"mbalaji115@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
        FCHK_Cls_MemberRegistrationcls.registerMember(lengthyString,true);   
                           
     
    }
    
    static testMethod void testErrorMesssage(){
    	 String jsonString = '{"lastName":"Balaji","firstName":"Malemarpuram","homePhone":"89898978","memberPhone":"54545438","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
        
        FCHK_Cls_MemberRegistrationcls.registerMember(jsonString,false);  
        
        FCHK_Cls_MemberRegistrationcls.returnErrorMsg('extraFields',''); 
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('invalidFieldValues','Invalid fields');
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('validation','validation fields');
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('Technical','validation fields');
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('Technical','validation fields');
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('memberRecordIdNotfound','memberRecordIdNotfound');
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('nomemberexistwithmobile','nomemberexistwithmobile'); 
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('MobileFound','Mobile number Found');
    	FCHK_Cls_MemberRegistrationcls.returnErrorMsg('EmailPhoneFound','Mobile number Found');
    	FCHK_Cls_MemberRegistrationcls.sendPassword('test1234@gmail.com');
    	 String jsonString1 = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"58456212","memberEmail":"testrkrk234@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"testrkrk234@gmail.com","password":"","gender":"Male","registrationType":"Full",'+
            +'"health":true,"familyActivities":true,"foodandNutrition":true,"travel":true,"entertainmentandLeisure":true,'+
            +'"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true}';
        
        FCHK_Cls_MemberRegistrationcls.registerMember(jsonString1,true);
    }
    static testMethod void testaccountActions(){        
         List<RecordType> recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account'  limit 1];
         Account actobj= new Account();
         actobj.firstName='Sailaja';
         actobj.lastName='Pattur';
         actobj.personEmail = 'sailajatest105@gmail.com';
         actobj.personMobilePhone = '57946456';
         actobj.OpCo__c = '   ';
         insert actobj;
         Account actobj1= new Account();
         actobj1.firstName='Sailaja';
         actobj1.lastName='Pattur';
         actobj1.personEmail = 'sailajatest105@gmail.com';
         actobj1.personMobilePhone = '57846456';
         actobj1.OpCo__c = '   ';
         try{
         insert actobj1;
         }
         Catch(Exception e){
            System.debug('E:::'+e.getMessage());
         }
    }
}