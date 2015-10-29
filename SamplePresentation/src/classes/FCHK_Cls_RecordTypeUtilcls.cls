public with sharing class FCHK_Cls_RecordTypeUtilcls {
		public static Map<id,RecordType> getRecordTypes(String sObjectType){
			 Map<id,RecordType> recordTypeMap = new Map<id,RecordType>();
			 String query= 'select id,name,developerName from RecordType where sobjectType=\''+sObjectType+'\'';
			 for(RecordType recTypeObj:database.query(query)){
			 	recordTypeMap.put(recTypeObj.id,recTypeObj);
			 }
			return recordTypeMap;
		}
}