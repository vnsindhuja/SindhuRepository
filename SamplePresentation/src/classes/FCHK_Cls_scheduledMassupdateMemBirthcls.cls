global with sharing class FCHK_Cls_scheduledMassupdateMemBirthcls implements Schedulable {
	 global void execute(SchedulableContext SC) {
      	FCHK_Cls_MassUpdateMembeBirthDayOffercls massUpdateMemberObj = new FCHK_Cls_MassUpdateMembeBirthDayOffercls();
      	Database.executeBatch(massUpdateMemberObj,1000);
   	}
}