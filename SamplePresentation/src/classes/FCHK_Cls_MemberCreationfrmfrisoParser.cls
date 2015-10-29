public with sharing class FCHK_Cls_MemberCreationfrmfrisoParser {
	 public class FCHK_Cls_MemberDetailfromFrisocls{
			public String firstName{get;set;}
            public String lastName{get;set;}
            public String memberEmail{get;set;}
            public String memberMobile{get;set;}
            public Date   memberDOB{get;set;}           
            //public String userName{get;set;}
            public String recruitmentSource{get;set;}                  
            public String homePhone{get;set;}
            public String flat{get;set;}
            public String floor{get;set;}
            public String building{get;set;}
            public String block{get;set;}
            public String estate{get;set;}
            public String district{get;set;}
            public String street{get;set;}
            public String country{get;set;}
            public String frisoRecordId{get;set;}
            public boolean chineesAddress{get;set;}
            //Added the following json fields on 18 Sep ,2015 in phase 2b stage
            public boolean rejectSMS{get;set;}
            public boolean emailOptOut{get;set;}
            public boolean rejectDirectEmail{get;set;}
            public boolean doNotCall{get;set;}          
            //End of adding
	}
                       
}