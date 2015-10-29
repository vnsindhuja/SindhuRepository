@isTest
private class TestfaultPartnerSoapSforceCom {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
     	faultPartnerSoapSforceCom.ApiFault apifaultObj = new faultPartnerSoapSforceCom.ApiFault();
        faultPartnerSoapSforceCom.InvalidSObjectFault invalidSobjectObj = new faultPartnerSoapSforceCom.InvalidSObjectFault();
        faultPartnerSoapSforceCom.MalformedQueryFault malformedObj = new faultPartnerSoapSforceCom.MalformedQueryFault();
        faultPartnerSoapSforceCom.InvalidIdFault invalidFaultObj = new faultPartnerSoapSforceCom.InvalidIdFault();
        faultPartnerSoapSforceCom.MalformedSearchFault searchFaultObj = new faultPartnerSoapSforceCom.MalformedSearchFault();
        faultPartnerSoapSforceCom.InvalidFieldFault invalidFieldFaultObj = new faultPartnerSoapSforceCom.InvalidFieldFault();
    	faultPartnerSoapSforceCom.ApiQueryFault apiQueryFaultObj = new faultPartnerSoapSforceCom.ApiQueryFault();
    	faultPartnerSoapSforceCom.UnexpectedErrorFault upexpectedErrorFaultObj = new faultPartnerSoapSforceCom.UnexpectedErrorFault();
    	faultPartnerSoapSforceCom.InvalidQueryLocatorFault invalidQueryLocatorFaultObj = new faultPartnerSoapSforceCom.InvalidQueryLocatorFault();
    	faultPartnerSoapSforceCom.LoginFault loginFaultObj = new faultPartnerSoapSforceCom.LoginFault();
    	faultPartnerSoapSforceCom.InvalidNewPasswordFault invalidNewPasswordFaultObj = new faultPartnerSoapSforceCom.InvalidNewPasswordFault();
    }
}