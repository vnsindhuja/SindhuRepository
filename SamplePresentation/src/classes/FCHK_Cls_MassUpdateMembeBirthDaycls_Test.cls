@isTest
private class FCHK_Cls_MassUpdateMembeBirthDaycls_Test {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND DeveloperName= 'FCHK_MR_RT_Optimel'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'Testemail3@method.com';
        Acc.PersonMobilePhone = '52852025';
        Acc.PersonHomePhone = '47000542';
        Acc.recordTypeId = recordTypeIds;
        acc.PersonBirthdate = System.today().addYears(-18);
        acc.FCHK_BirthDay_Offer_Taken__c = true;
        insert Acc;
        Test.startTest();
        FCHK_Cls_scheduledMassupdateMemBirthcls scheduleObj = new FCHK_Cls_scheduledMassupdateMemBirthcls();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Territory Check', sch, scheduleObj);
        Test.stopTest();
          
        
    }
}