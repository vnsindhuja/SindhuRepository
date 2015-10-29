public with sharing class FCHK_Optimel_Utils {
    
    public static String getOptimelRecordType()
    {
        Schema.DescribeSObjectResult d = Schema.SObjectType.Account;
		Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('Optimel Record');
		System.debug(rtByName.getRecordTypeId());
		return rtByName.getRecordTypeId();
    }

}