@isTest
private class TestMemberRegistrationcls {

    static testMethod void myUnitTest() {
        String jsonString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"1245614","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","homePhone":"25454525","gender":"Male","registrationType":"Full","health":true,"familyActivities":true,"foodandNutrition":true,'+
            +'"travel":true,"entertainmentandLeisure":true,"shopping":true,"sportsandWellness":true,"retirementPlanning":true,"agreeTerms":true,"referredOn":"1988-01-07","promotionCode":"testcode","referredBy":null}';
        
        FCHK_Cls_MemberRegistrationcls.registerMember(jsonString,true);
        FCHK_Cls_MemberRegistrationcls.sendPassword('mbalaji105@gmail.com');
        String withoutPhoneemailString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":null,"memberEmail":null,"birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
         FCHK_Cls_MemberRegistrationcls.registerMember(withoutPhoneemailString,true);
          String invalidMobileNumberString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"2342wer","memberEmail":null,"birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidMobileNumberString,true);
          String invalidEmailString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"2342234","memberEmail":"mbalaji105@@@","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidEmailString,true);           

            String invalidBirthdayString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"2342234","memberEmail":"mbalaji106@gmail.com","birthDay":"qw","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidBirthdayString,true);
            String invalidBirthMonthString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"2342234","memberEmail":"mbalaji106@gmail.com","birthDay":"25","birthMonth":"qw","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidBirthMonthString,true);
            String invalidBirthYearString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"2342234","memberEmail":"mbalaji106@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"qw",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
         FCHK_Cls_MemberRegistrationcls.registerMember(invalidBirthYearString,true);
         String jsonString1 = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"1245614","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
           FCHK_Cls_MemberRegistrationcls.registerMember(jsonString1,true);        
         String mobileFound = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"1245614","memberEmail":"mbalaji106@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
        FCHK_Cls_MemberRegistrationcls.registerMember(mobileFound,true);
         String emailFound = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"12456145","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
        FCHK_Cls_MemberRegistrationcls.registerMember(emailFound,true);  
        String lengthyString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"124561457","memberEmail":"mbalaji115@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","gender":"Male","registrationType":"Full"}';
        FCHK_Cls_MemberRegistrationcls.registerMember(lengthyString,true);    
        //for all duplicates
        String allduplicatesjsonString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"1245614","memberEmail":"mbalaji105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","homePhone":"25454525","gender":"Male","registrationType":"Full"}';
        
        FCHK_Cls_MemberRegistrationcls.registerMember(allduplicatesjsonString,true);                      
     	 String withoutphonehomeduplicatesjsonString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":null,"memberEmail":"mbalaji1105@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji105@gmail.com","password":"test123","homePhone":null,"gender":"Male","registrationType":"Full"}';
        
        FCHK_Cls_MemberRegistrationcls.registerMember(withoutphonehomeduplicatesjsonString,true);     
         String allEmailjsonString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"51212154","memberEmail":"mbalaji879@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji879@gmail.com","password":"test123","homePhone":"25454458","gender":"Male","registrationType":"Full"}';
        
        FCHK_Cls_MemberRegistrationcls.registerMember(allEmailjsonString,true);   
          String allHomePhonejsonString = '{"lastName":"Balaji","firstName":"Malemarpuram","memberPhone":"51212944","memberEmail":"mbalaji11845@gmail.com","birthDay":"25","birthMonth":"05","birthYear":"1988",'+
            +'"userName":"mbalaji11845@gmail.com","password":"test123","homePhone":"25454525","gender":"Male","registrationType":"Full"}';
        
        FCHK_Cls_MemberRegistrationcls.registerMember(allEmailjsonString,true);   
        
        FCHK_Cls_MemberRegistrationcls.returnErrorMsg ('EmailFound','');
     	FCHK_Cls_MemberRegistrationcls.returnErrorMsg ('MobileFound','');
      	FCHK_Cls_MemberRegistrationcls.returnErrorMsg ('EmailPhoneFound','');
       	FCHK_Cls_MemberRegistrationcls.returnErrorMsg ('HomePhoneFound','');
        FCHK_Cls_MemberRegistrationcls.returnErrorMsg ('false','');
     	FCHK_Cls_MemberRegistrationcls.returnErrorMsg ('extraFields','');
       	FCHK_Cls_MemberRegistrationcls.returnErrorMsg ('nomemberexistwithmobile','');
             
    }
    static testMethod void testaccountActions(){        
         List<RecordType> recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account'  limit 1];
         Account actobj= new Account();
         actobj.firstName='Sailaja';
         actobj.lastName='Pattur';
         actobj.personEmail = 'sailajatest105@gmail.com';
         actobj.personMobilePhone = '97946456';
         actobj.OpCo__c = '   ';
         insert actobj;
         Account actobj1= new Account();
         actobj1.firstName='Sailaja';
         actobj1.lastName='Pattur';
         actobj1.personEmail = 'sailajatest105@gmail.com';
         actobj1.personMobilePhone = '97946456';
         actobj1.OpCo__c = '   ';
         try{
         insert actobj1;
         }
         Catch(Exception e){
            System.debug('E:::'+e.getMessage());
         }
    }
}