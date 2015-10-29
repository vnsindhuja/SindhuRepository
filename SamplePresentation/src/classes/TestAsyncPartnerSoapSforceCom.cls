@isTest
private class TestAsyncPartnerSoapSforceCom {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test  
                AsyncPartnerSoapSforceCom.dummy();
        AsyncPartnerSoapSforceCom.dummy1();
         AsyncPartnerSoapSforceCom.dummy2();
        Urls__c urlObj = new Urls__c(name='domainurl',url__c='https://test.salesforce.com');
        insert urlObj;
        AsyncPartnerSoapSforceCom.AsyncSoap asyncSoapObj = new AsyncPartnerSoapSforceCom.AsyncSoap();      
       
    }    
}