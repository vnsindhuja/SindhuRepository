@isTest(seealldata=true)
public class FCHK_Test_Create_Campaign_Member{

    static testmethod void CreateCM_WithEmail_Web_NoAge(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Website';
        Acc.PersonEmail = 'abc@gmail1.com';
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithEmail_Web_40(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1972, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Website';
        Acc.PersonEmail = 'abc7@gmail.com';
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithEmail_Web_50_60(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1960, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Website';
        Acc.PersonEmail = 'abc6@gmail.com';
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithEmail_Web_60(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1952, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Website';
        Acc.PersonEmail = 'abc5@gmail.com';
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithEmail_HL_NoAge(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';
        Acc.PersonEmail = 'abc4@gmail.com';
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithEmail_HL_40(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1972, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';
        Acc.PersonEmail = 'abc3@gmail.com';
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithEmail_HL_50_60(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1960, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';
        Acc.PersonEmail = 'abc2@gmail.com';
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithEmail_HL_60(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1952, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';
        Acc.PersonEmail = 'abc1@gmail.com';
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
        static testmethod void CreateCM_WithOEmail_HL_NoAge(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';     
        Acc.OpCo__c = 'SG';   
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithOEmail_HL_40(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1972, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';        
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithOEmail_HL_50_60(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1960, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';        
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
    
    static testmethod void CreateCM_WithOEmail_HL_60(){                    
        RecordType RecId = [select Id from RecordType where SObjectType='Account' and Name='Optimel Record' limit 1];
        Date BDate = date.newinstance(1952, 2, 17);
        //Account Acc = [SELECT Id FROM Account LIMIT 1];             
        Account Acc = new Account();
        Acc.RecordTypeId = RecId.Id;
        Acc.FirstName = 'Test Account';
        Acc.LastName = 'Test';
        Acc.PersonMobilePhone = '52589546';
        Acc.Recruitment_Source__c = 'Hotline';        
        Acc.PersonBirthdate = BDate;
        Acc.OpCo__c = 'SG';
        insert Acc;        
    }
}