global with sharing class FCHK_Cls_MassUpdateMembeBirthDayOffercls implements Database.batchable<sObject>{
	global Database.QueryLocator start(Database.BatchableContext BC){
				 String query = '';
				/*if(Test.isRunningTest()){ 
			        query = 'SELECT Id,personEmail,FCHK_Member_Age__c,Recruitment_Source__c,';		       
			        query +='PersonBirthdate,PersonContactId FROM Account ';
			        query+=' where RecordType.DeveloperName=\'FCHK_MR_RT_Optimel\' and PersonContactId!=null';
			        query+=' and FCHK_BirthDay_Offer_Taken__c=true limit 1';
				}
				else{*/
					
				//}
				if(System.today().month()==1 || test.isRunningTest()){
					query = 'SELECT Id,personEmail,FCHK_Member_Age__c,Recruitment_Source__c,';		       
				        query +='PersonBirthdate,PersonContactId FROM Account ';
				        query+=' where RecordType.DeveloperName=\'FCHK_MR_RT_Optimel\' and PersonContactId!=null';
				        query+=' and FCHK_BirthDay_Offer_Taken__c=true';
			        return Database.getQueryLocator(query);
				}
				else{
					return null;
				}
		 }
		  global void execute(Database.BatchableContext BC, List<Account> accountList){
		         for(Account actObj:accountList){
		         		actObj.FCHK_BirthDay_Offer_Taken__c = false;
		         }
		         //update accountList;
		         List<Database.saveResult> resultList = database.update(accountList,false);
		         System.debug('resultList::'+resultList);
			} 
		 global void finish(Database.BatchableContext BC){
		 	
		 }
}