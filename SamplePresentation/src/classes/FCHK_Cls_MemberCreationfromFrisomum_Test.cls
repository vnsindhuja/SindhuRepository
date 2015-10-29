@isTest
private class FCHK_Cls_MemberCreationfromFrisomum_Test {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
         String jsonString = '[{"lastName":"Balaji","firstName":"Malemarpuram","memberMobile":"56789456","homephone":"89789457","memberEmail":"mbalaji105@gmail.com","memberDOB":"1988-05-25","recruitmentSource":"Frisomum","floor":"12/F",'+
            +'"flat":"Flat 25","block":"Block No- 00","building":"Acacia  Building 1","district":"Kowloon City","street":"150 Kennedy Road",'+
            +'"country":"hong kong","estate":"WAN CHAI","frisorecordId":"001O000000kAZJn"}]';
            FCHK_Cls_MemberCreationfromFrisomum.createMemberfromFrisomum(jsonString);
    }
    static testMethod void duplicatefoundUnitTest(){
    	List<RecordType> recTypeList = new List<RecordType>();
    	recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account' 
                    and recordType.developerName='FCHK_MR_RT_Optimel' limit 1];    	
    	Account actobj = new Account();
    	if(recTypeList!=null && recTypeList.size()>0){
			actobj.RecordTypeId = recTypeList[0].id;
    	}
		actobj.FirstName = 'Malemarpuram';
		actobj.LastName = 'Balaji';
		actobj.PersonEmail = 'mbalaji111@gmail.com';
		actobj.PersonMobilePhone = '52222222';
		actobj.PersonHomePhone = '33333333';
		actobj.PersonBirthdate = System.today().addYears(-27);
        try
        {
		insert actobj;
        }
        catch (Exception ex1)
        {
            
        }
		String jsonString = '[{"lastName":"Balaji","firstName":"Malemarpuram","memberMobile":"52222222","homephone":"33333333","memberEmail":"mbalaji111@gmail.com","memberDOB":"1988-05-25","recruitmentSource":"Frisomum","floor":"12/F",'+
            +'"flat":"Flat 25","block":"Block No- 00","building":"Acacia  Building 1","district":"Kowloon City","street":"150 Kennedy Road",'+
            +'"country":"hong kong","estate":"WAN CHAI","frisorecordId":"001O000000kAZJn"}]';
            FCHK_Cls_MemberCreationfromFrisomum.createMemberfromFrisomum(jsonString);
    	
    }
    static testMethod void duplicatephoneUnitTest(){
    	List<RecordType> recTypeList = new List<RecordType>();
    	recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account' 
                    and recordType.developerName='FCHK_MR_RT_Optimel' limit 1];    	
    	Account actobj = new Account();
    	if(recTypeList!=null && recTypeList.size()>0){
			actobj.RecordTypeId = recTypeList[0].id;
    	}
		actobj.FirstName = 'Malemarpuram';
		actobj.LastName = 'Balaji';
		actobj.PersonEmail = 'mbalaji1059@gmail.com';
		actobj.PersonMobilePhone = '67894567';
		actobj.PersonHomePhone = '12561445';
		actobj.PersonBirthdate = System.today().addYears(-27);
		insert actobj;
		String jsonString = '[{"lastName":"Balaji","firstName":"Malemarpuram","memberMobile":"67894567","homephone":"12456145","memberEmail":"mbalaji105@gmail.com","memberDOB":"1988-05-25","recruitmentSource":"Frisomum","floor":"12/F",'+
            +'"flat":"Flat 25","block":"Block No- 00","building":"Acacia  Building 1","district":"Kowloon City","street":"150 Kennedy Road",'+
            +'"country":"hong kong","estate":"WAN CHAI","frisorecordId":"001O000000kAZJn"}]';
            FCHK_Cls_MemberCreationfromFrisomum.createMemberfromFrisomum(jsonString);
    	
    }
    static testMethod void duplicateemailUnitTest(){
    	List<RecordType> recTypeList = new List<RecordType>();
    	recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account' 
                    and recordType.developerName='FCHK_MR_RT_Optimel' limit 1];    	
    	Account actobj = new Account();
    	if(recTypeList!=null && recTypeList.size()>0){
			actobj.RecordTypeId = recTypeList[0].id;
    	}
		actobj.FirstName = 'Malemarpuram';
		actobj.LastName = 'Balaji';
		actobj.PersonEmail = 'mbalaji105@gmail.com';
		actobj.PersonMobilePhone = '55555555';
		actobj.PersonHomePhone = '45645645';
		actobj.PersonBirthdate = System.today().addYears(-27);
		insert actobj;
		String jsonString = '[{"lastName":"Balaji","firstName":"Malemarpuram","memberMobile":"55555554","homephone":"45645654;","memberEmail":"mbalaji105@gmail.com","memberDOB":"1988-05-25","recruitmentSource":"Frisomum","floor":"12/F",'+
            +'"flat":"Flat 25","block":"Block No- 00","building":"Acacia  Building 1","district":"Kowloon City","street":"150 Kennedy Road",'+
            +'"country":"hong kong","estate":"WAN CHAI","frisorecordId":"001O000000kAZJn"}]';
            FCHK_Cls_MemberCreationfromFrisomum.createMemberfromFrisomum(jsonString);
    	
    }
    static testMethod void duplicateHomephoneUnitTest(){
    	List<RecordType> recTypeList = new List<RecordType>();
    	recTypeList=[select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='Account' 
                    and recordType.developerName='FCHK_MR_RT_Optimel' limit 1];    	
    	Account actobj = new Account();
    	if(recTypeList!=null && recTypeList.size()>0){
			actobj.RecordTypeId = recTypeList[0].id;
    	}
		actobj.FirstName = 'Malemarpuram';
		actobj.LastName = 'Balaji';
		actobj.PersonEmail = 'mbalaji1014@gmail.com';
		actobj.PersonMobilePhone = '58958959';
		actobj.PersonHomePhone = '85020264';
		actobj.PersonBirthdate = System.today().addYears(-27);
		insert actobj;
		String jsonString = '[{"lastName":"Balaji","firstName":"Malemarpuram","memberMobile":"58958995","homephone":"85020264","memberEmail":"mbalaji105@gmail.com","memberDOB":"1988-05-25","recruitmentSource":"Frisomum","floor":"12/F",'+
            +'"flat":"Flat 25","block":"Block No- 00","building":"Acacia  Building 1","district":"Kowloon City","street":"150 Kennedy Road",'+
            +'"country":"hong kong","estate":"WAN CHAI","frisorecordId":"001O000000kAZJn"}]';
            FCHK_Cls_MemberCreationfromFrisomum.createMemberfromFrisomum(jsonString);
    	
    }
}