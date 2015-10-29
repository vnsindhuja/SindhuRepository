@isTest
private class FCHK_Cls_scheduleAddmemtocampauto_test {

   public static testMethod void testSchedule() {
        // TO DO: implement unit test
        Test.StartTest();
        FCHK_Cls_scheduleAddmemtocampautomation sh1 = new FCHK_Cls_scheduleAddmemtocampautomation();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Territory Check', sch, sh1);
        Test.stopTest(); 
        
    }
}