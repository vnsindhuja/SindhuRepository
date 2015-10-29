global with sharing class FCHK_Cls_scheduleAddmemtocampautomation implements Schedulable{
	 global void execute(SchedulableContext SC) {
      	FCHK_Cls_AddCampaignMemberAutomationcls addMemtoCampaignObj = new FCHK_Cls_AddCampaignMemberAutomationcls();
      	Database.executeBatch(addMemtoCampaignObj,1000);
   	}
}