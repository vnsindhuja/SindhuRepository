@isTest
private class TestOptimeltofrisoServicecls {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Urls__c urlObj = new Urls__c(name='instanceurl',url__c=System.label.FCHK_CL_InstanceUrl);
        //Savepoint sp = Database.setSavepoint();
        insert urlObj;
        Test.startTest();
        	OptimeltofrisoServicecls.LogInfo loginObj = new OptimeltofrisoServicecls.LogInfo();
	        OptimeltofrisoServicecls.AllowFieldTruncationHeader_element truncationHeaderObj = new OptimeltofrisoServicecls.AllowFieldTruncationHeader_element();
	        OptimeltofrisoServicecls.DebuggingHeader_element debugHeaderObj = new OptimeltofrisoServicecls.DebuggingHeader_element();
	        OptimeltofrisoServicecls.CallOptions_element callOptionObj = new OptimeltofrisoServicecls.CallOptions_element();
	        OptimeltofrisoServicecls.location locationObj = new OptimeltofrisoServicecls.location();
	        OptimeltofrisoServicecls.address addressObj = new OptimeltofrisoServicecls.address();
	        OptimeltofrisoServicecls.SessionHeader_element sessionHeaderObj = new OptimeltofrisoServicecls.SessionHeader_element();
	        OptimeltofrisoServicecls.updateMemberfromOptimelResponse_element responseObj = new OptimeltofrisoServicecls.updateMemberfromOptimelResponse_element();
	        OptimeltofrisoServicecls.DebuggingInfo_element debuggingInfoObj = new OptimeltofrisoServicecls.DebuggingInfo_element();
	        OptimeltofrisoServicecls.OptimeltoFrisomumcls optimelFrisomumcls = new OptimeltofrisoServicecls.OptimeltoFrisomumcls();
	    	OptimeltofrisoServicecls.updateMemberfromOptimel_element updateObj = new OptimeltofrisoServicecls.updateMemberfromOptimel_element();
	    	//OptimeltofrisoServicecls.dummy();	
	    	OptimeltofrisoServicecls.OptimeltoFrisomumcls optimelServiceObj = new OptimeltofrisoServicecls.OptimeltoFrisomumcls();
	    	String jsonString = 'Hi';	    	
	    	Test.setMock(WebServiceMock.class, new OptimelServiceWebserviceMockup());
	    	optimelServiceObj.updateMemberfromOptimel(jsonString);
    	Test.stopTest();
    }
}