@isTest
private class TestpartnerSoapSforceCom {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Urls__c urlObj = new Urls__c(name='domainurl',url__c=System.Label.FCHK_CL_Domainurl);
        insert urlObj;
        partnerSoapSforceCom.GetUserInfoResult userInfoObj = new partnerSoapSforceCom.GetUserInfoResult();
        partnerSoapSforceCom.LoginScopeHeader_element loginHeaderEleObj = new partnerSoapSforceCom.LoginScopeHeader_element();
        partnerSoapSforceCom.loginResponse_element loginResponseObj = new partnerSoapSforceCom.loginResponse_element();
        partnerSoapSforceCom.create_element creatEleObj = new partnerSoapSforceCom.create_element();
        partnerSoapSforceCom.dummy();
        partnerSoapSforceCom.dummy1();
        partnerSoapSforceCom.dummy2();
        partnerSoapSforceCom.soap soapObj = new partnerSoapSforceCom.soap();
        soapObj.login(null,null);
    }
}