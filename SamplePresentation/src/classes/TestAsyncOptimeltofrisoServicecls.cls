@isTest
private class TestAsyncOptimeltofrisoServicecls {

  static testMethod void myUnitTest() {
        // TO DO: implement unit test
       Urls__c urlObj = new Urls__c(name='instanceurl',url__c=System.label.FCHK_CL_InstanceUrl);
       insert urlObj;
        AsyncOptimeltofrisoServicecls.AsyncOptimeltoFrisomumcls asyncOptimelObj = new  AsyncOptimeltofrisoServicecls.AsyncOptimeltoFrisomumcls();
        AsyncOptimeltofrisoServicecls.dummy();
        AsyncOptimeltofrisoServicecls.dummy1();
    }
}