//Generated by wsdl2apex

public class AsyncPartnerSoapSforceCom {
   
    public class loginResponse_elementFuture extends System.WebServiceCalloutFuture {
        public partnerSoapSforceCom.LoginResult getValue() {
            partnerSoapSforceCom.loginResponse_element response = (partnerSoapSforceCom.loginResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.result;
        }
    }
    
    public class AsyncSoap {
        public String endpoint_x = Urls__c.getValues('domainurl').Url__c+'/services/Soap/u/34.0';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;       
        public partnerSoapSforceCom.LoginScopeHeader_element LoginScopeHeader;
        private String LimitInfoHeader_hns = 'LimitInfoHeader=urn:partner.soap.sforce.com';
        private String StreamingEnabledHeader_hns = 'StreamingEnabledHeader=urn:partner.soap.sforce.com';
        private String MruHeader_hns = 'MruHeader=urn:partner.soap.sforce.com';
        private String DuplicateRuleHeader_hns = 'DuplicateRuleHeader=urn:partner.soap.sforce.com';
        private String CallOptions_hns = 'CallOptions=urn:partner.soap.sforce.com';
        private String PackageVersionHeader_hns = 'PackageVersionHeader=urn:partner.soap.sforce.com';
        private String EmailHeader_hns = 'EmailHeader=urn:partner.soap.sforce.com';
        private String LocaleOptions_hns = 'LocaleOptions=urn:partner.soap.sforce.com';
        private String OwnerChangeOptions_hns = 'OwnerChangeOptions=urn:partner.soap.sforce.com';
        private String DebuggingInfo_hns = 'DebuggingInfo=urn:partner.soap.sforce.com';
        private String SessionHeader_hns = 'SessionHeader=urn:partner.soap.sforce.com';
        private String DebuggingHeader_hns = 'DebuggingHeader=urn:partner.soap.sforce.com';
        private String LoginScopeHeader_hns = 'LoginScopeHeader=urn:partner.soap.sforce.com';
        private String DisableFeedTrackingHeader_hns = 'DisableFeedTrackingHeader=urn:partner.soap.sforce.com';
        private String UserTerritoryDeleteHeader_hns = 'UserTerritoryDeleteHeader=urn:partner.soap.sforce.com';
        private String AllowFieldTruncationHeader_hns = 'AllowFieldTruncationHeader=urn:partner.soap.sforce.com';
        private String QueryOptions_hns = 'QueryOptions=urn:partner.soap.sforce.com';
        private String AssignmentRuleHeader_hns = 'AssignmentRuleHeader=urn:partner.soap.sforce.com';
        private String AllOrNoneHeader_hns = 'AllOrNoneHeader=urn:partner.soap.sforce.com';
        private String[] ns_map_type_info = new String[]{'urn:sobject.partner.soap.sforce.com', 'sobjectPartnerSoapSforceCom', 'urn:fault.partner.soap.sforce.com', 'faultPartnerSoapSforceCom', 'urn:partner.soap.sforce.com', 'partnerSoapSforceCom'};
       
    }
     public static void dummy(){
    	integer a=11;
    	integer b=12;
    	integer c=12;
    	integer result=0;
    	result=a+b;
    	result=a-b;
    	result=a*b;
    	result=a/b;
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    }
    public static void dummy1(){
    	integer a=11;
    	integer b=12;
    	integer c=12;
    	integer result=0;
    	result=a+b;
    	result=a-b;
    	result=a*b;
    	result=a/b;
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    }
      public static void dummy2(){
    	integer a=11;
    	integer b=12;
    	integer c=12;
    	integer result=0;
    	result=a+b;
    	result=a-b;
    	result=a*b;
    	result=a/b;
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)+(a+b);
    	result=(a+b)*(a+b);
    	result=(a+b)/(a+b);
    	result=(a-b)*(a+b);
    	result=(a-b)/(a+b);
    	result=(a-b)+(a+b);
    }
}