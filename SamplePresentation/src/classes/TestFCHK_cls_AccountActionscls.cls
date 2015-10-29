@isTest
private class TestFCHK_cls_AccountActionscls {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        StopTrigger__c stopTrigObj = new StopTrigger__c();
        stopTrigObj.Name = 'Stopoptimeltofriso';
        stopTrigObj.isStop__c = false;
        insert stopTrigObj;
        List<RecordType> recordTypeList = [select id,name,developername from Recordtype 
        					where SobjectType='Account' and DeveloperName='MedicalMarketing'];
        Account actObj = new Account();
        if(recordTypeList!=null && recordTypeList.size()>0){
        	actobj.RecordTypeId = recordTypeList[0].id;
        }
        actobj.Name = 'Test Name';
        actObj.FCHK_18_District_Chi__c = '九龍城區';
        actobj.FCHK_18_District_Eng__c = 'Kowloon City';
        actObj.FCHK_Address_Chi__c ='九龍城區';
        actObj.FCHK_Area_Chi__C = '九龍城';
        actObj.FCHK_Area_Eng__C = 'Aberdeen';
        actObj.FCHK_Block__c ='Test Block';
        actObj.FCHK_Building__c ='Test Build';
        actobj.FCHK_Business_Hours__c = '10';
        actObj.FCHK_District__c = 'Kennedy Town';
        actObj.FCHK_Estate__c = 'Test Estate';
        actObj.FCHK_F1_Trail__c = 'Test f1';
        actObj.Fax='45654567';
        actObj.Phone='56565757';
        actObj.FCHK_Flat__c = '2fl';
        actobj.FCHK_Floor__c = '2fl';
        actobj.FCHK_Infer_recommendation__c ='1';
        actObj.FCHK_Medical_Rep__C='Wilson Lee';
        actObj.FCHK_Patient_Flow__C ='1';
        actobj.FCHK_Patient_type__c = '1';
        actobj.FCHK_Relevancy__c='1';
        actobj.FCHK_Specialist__c ='ZOG';
        actObj.FCHK_MedicalType__c = 'Hosptial';
        actobj.FCHK_Classification__c = '10';
        actobj.OpCo__c = 'HK';
        actobj.FCHK_Street__c = 'Test Street';
        actobj.FCHK_Country__c = 'Test Country';
        insert actobj;
    }
}