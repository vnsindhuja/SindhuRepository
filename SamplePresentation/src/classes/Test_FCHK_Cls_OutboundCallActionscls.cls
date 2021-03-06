@isTest
private class Test_FCHK_Cls_OutboundCallActionscls {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Account Acc = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        Acc.FirstName = 'Test';
        Acc.LastName = 'Test';
        Acc.PersonEmail = 'TestemaiTestEmail@method.com';
        Acc.PersonMobilePhone = '55800000';
        Acc.PersonHomePhone = '45800000';
        Acc.recordTypeId = recordTypeIds;
        acc.PersonBirthdate = System.today().addYears(-50);       
        insert Acc;        
        List<Task> taskList = new List<Task>();
        List<RecordType> recordTypeList = new List<RecordType>();
        recordTypeList = [select id,name,developerName from RecordType 
        	where sObjectType='Task' and DeveloperName='X1st_Purchase_Outbound_Call' limit 1];
        if(recordTypeList!=null && recordTypeList.size()>0){
        	Task taskObj = new Task();
        	taskObj.RecordTypeId=recordTypeList[0].id;
        	taskObj.subject = 'Outbound Call';
        	taskObj.FCHK_Did_you_try_the_Sample__c = 'Yes';
        	taskObj.FCHK_Did_you_consume_the_Sample__c = 'Yes';
        	taskObj.FCHK_Would_you_like_to_go_for_Purchase__c = 'No';
        	taskObj.FCHK_First_Purchase__c = 'Claimed Purchase';
        	taskObj.whatId = Acc.id;
        	taskObj.FCHK_Consume_Remark__c='Wyeth (Enercal)';
        	taskList.add(taskObj); 
        	if(taskList!=null && taskList.size()>0){
        			insert taskList;
        	}
        	
        }
    }
    static testMethod void createOutboundcallsunitTest() {
        // TO DO: implement unit test
        Account actObj = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND Name= 'Optimel Record'].id;
        actObj.FirstName = 'Test';
        actObj.LastName = 'Test';
        actObj.PersonEmail = 'TestemaiTest1Email@method.com';
        actObj.PersonMobilePhone = '55810000';
        actObj.PersonHomePhone = '45810000';
        actObj.recordTypeId = recordTypeIds;
        actObj.PersonBirthdate = System.today().addYears(-50); 
        actObj.FCHK_FirstPurchaseDate__c = System.today().addyears(-20);      
        insert actObj;
        actObj.FCHK_is30DaysCompleted__c = true;
        update actObj;  
        List<RecordType> recordTypeList = new List<RecordType>();
        recordTypeList = [select id,name,developerName from RecordType 
        	where sObjectType='Task' and (DeveloperName='Sample_Invitation_Outbound_Call' 
        		or DeveloperName='X1st_Purchase_Outbound_Call' or DeveloperName='X2nd_Purchase_Outbound_Call')];
        Map<String,Id> recordTypeMap = new Map<String,Id>();
        for(RecordType recTypeObj:recordTypeList){
        		recordTypeMap.put(recTypeObj.DeveloperName,recTypeObj.id);
        }
        List<Task> taskList = new List<Task>();
        Task taskObj1 = new Task();
		taskObj1.RecordTypeId=recordTypeMap.get('Sample_Invitation_Outbound_Call');
		taskObj1.subject = 'Outbound Call';        	
		taskObj1.FCHK_Product_Name__c = 'Optimel Silver';
		taskObj1.status='Completed';
		taskObj1.whatId = actObj.id;
		taskObj1.FCHK_Consume_Remark__c='Wyeth (Enercal)';
		taskObj1.FCHK_Sample_Request__c = 'Yes';
		taskObj1.FCHK_Sample_Request_Reason__c='Consume another brand currently';
		taskObj1.FCHK_Sample_Request_Remark__c = 'Others';
		taskList.add(taskObj1);
    	Task taskObj2 = new Task();
    	taskObj2.RecordTypeId=recordTypeMap.get('X1st_Purchase_Outbound_Call');
    	taskObj2.subject = 'Outbound Call';
    	taskObj2.FCHK_Product_Name__c = 'Optimel Gold';
    	taskObj2.whatId= actObj.id;
    	taskObj2.FCHK_Did_you_try_the_Sample__c='No';
    	taskObj2.FCHK_Try_Reason__c='Consume another brand currently';
    	taskObj2.FCHK_Try_Remark__c='Abbott (Ensure)';        	
    	taskList.add(taskObj2); 
    	Task taskObj3 = new Task();
    	taskObj3.RecordTypeId=recordTypeMap.get('X2nd_Purchase_Outbound_Call');
    	taskObj3.FCHK_Finished_consuming_purchased_2nd__c='Yes';
    	taskObj3.FCHK_2nd_Purchase_Reason__c = 'Consume another brand currently';
    	taskObj3.FCHK_Will_you_make_a_2nd_Purchase__c = 'No';
    	taskObj3.FCHK_2nd_Purchase_Remark__c = 'Anlene (Total for bone and joint health)';
    	taskObj3.subject = 'Outbound Call';
    	taskObj3.FCHK_Product_Name__c = 'Optimel Diamond';
    	taskObj3.whatId = actObj.id;
    	taskObj3.FCHK_Consume_Remark__c='Wyeth (Enercal)';
    	taskList.add(taskObj3);   
    	if(taskList!=null && taskList.size()>0){
    			insert taskList;
    			FCHK_Cls_CheckRecursive.flag=false;
    			for(Task taskObj:taskList){
    				taskObj.FCHK_Sample_Request__c = 'Yes';
    				taskObj.status='Completed';
    			}
    			update taskList;
    	}
    }
    static testMethod void createOutboundcallsunitTest1() {
        // TO DO: implement unit test
        Account actObj = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND DeveloperName= 'FCHK_MR_RT_Optimel'].id;
        actObj.FirstName = 'Test1';
        actObj.LastName = 'Test1';
        actObj.PersonEmail = 'TestemaiTest2Email@method.com';
        actObj.PersonMobilePhone = '55810100';
        actObj.PersonHomePhone = '45810100';
        actObj.recordTypeId = recordTypeIds;
        actObj.FCHK_is60DaysCompleted__c = false;
        actObj.PersonBirthdate = System.today().addYears(-50);   
        actObj.FCHK_FirstPurchaseDate__c = System.today().addyears(-20);          
        insert actObj;
        actObj.FCHK_is60DaysCompleted__c = true;
        update actObj;   
        List<RecordType> recordTypeList = new List<RecordType>();
        recordTypeList = [select id,name,developerName from RecordType 
        	where sObjectType='Task' and DeveloperName='X1st_Purchase_Outbound_Call' limit 1];
        Task taskObj = new Task();
    	taskObj.RecordTypeId=recordTypeList[0].id;
    	taskObj.subject = 'Outbound Call';
    	taskObj.FCHK_Did_you_try_the_Sample__c = 'Yes';
    	taskObj.FCHK_Did_you_consume_the_Sample__c = 'Yes';
    	taskObj.FCHK_Would_you_like_to_go_for_Purchase__c = 'No';
    	taskObj.FCHK_First_Purchase__c = 'Offer not attractive';
    	taskObj.whatId = actObj.id;
    	taskObj.FCHK_Consume_Remark__c='Wyeth (Enercal)';  
    	insert taskObj;  
    	taskObj.FCHK_First_Purchase__c = 'Claimed Purchase';
    	update taskObj;
    }
   
    static testMethod void createOutboundcallscreateSampleRequest() {
        // TO DO: implement unit test
        Account actObj = new Account();
        Id recordTypeIds = [select id,Name from Recordtype where sObjectType='Account' AND DeveloperName= 'FCHK_MR_RT_Optimel'].id;
        actObj.FirstName = 'Test';
        actObj.LastName = 'Test';
        actObj.PersonEmail = 'TestemaiTest1Email@method.com';
        actObj.PersonMobilePhone = '55810000';
        actObj.PersonHomePhone = '45810000';
        actObj.recordTypeId = recordTypeIds;
        actObj.FCHK_is30DaysCompleted__c = false;
        actObj.PersonBirthdate = System.today().addYears(-50); 
        actObj.FCHK_FirstPurchaseDate__c = System.today().addyears(-20);      
        insert actObj;
        actObj.FCHK_is30DaysCompleted__c = true;
        update actObj;  
        List<RecordType> recordTypeList = new List<RecordType>();
        recordTypeList = [select id,name,developerName from RecordType 
        	where sObjectType='Task' and (DeveloperName='Sample_Invitation_Outbound_Call')];
        Map<String,Id> recordTypeMap = new Map<String,Id>();
        for(RecordType recTypeObj:recordTypeList){
        		recordTypeMap.put(recTypeObj.DeveloperName,recTypeObj.id);
        }
        List<Task> taskList = new List<Task>();
        Task taskObj1 = new Task();
		taskObj1.RecordTypeId=recordTypeMap.get('Sample_Invitation_Outbound_Call');
		taskObj1.subject = 'Outbound Call';        	
		taskObj1.FCHK_Product_Name__c = 'Optimel Silver';
		taskObj1.FCHK_Sample_Request__c = 'No';		
		taskObj1.whatId = actObj.id;	
		taskObj1.status='Completed';	
		taskList.add(taskObj1);
    	Task taskObj2 = new Task();
    	taskObj2.RecordTypeId=recordTypeMap.get('Sample_Invitation_Outbound_Call');
    	taskObj2.subject = 'Outbound Call';
    	taskObj2.FCHK_Product_Name__c = 'Optimel Gold';
    	taskObj2.whatId = actObj.id;		
		taskObj2.FCHK_Sample_Request__c = 'No';	
		taskObj2.status='Completed';	
    	taskList.add(taskObj2); 
    	Task taskObj3 = new Task();    	
    	taskObj3.RecordTypeId=recordTypeMap.get('Sample_Invitation_Outbound_Call');
    	taskObj3.subject = 'Outbound Call';
    	taskObj3.FCHK_Product_Name__c = 'Optimel Diamond';
    	taskObj3.whatId = actObj.id;		
		taskObj3.FCHK_Sample_Request__c = 'No';	
		taskObj3.status='Completed';		  	
    	taskList.add(taskObj3); 
    	
    	if(taskList!=null && taskList.size()>0){
    			insert taskList;
    			FCHK_Cls_CheckRecursive.flag=false;
    			for(Task taskObj:taskList){
    				taskObj.FCHK_Sample_Request__c = 'Yes';
    				taskObj.status='Completed';
    			}
    			update taskList;
    	}
    }
    
}