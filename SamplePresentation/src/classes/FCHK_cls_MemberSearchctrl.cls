public class FCHK_cls_MemberSearchctrl
{    
    public String getAccountList() 
      {        
        return null;    
      }    
      
     public FCHK_cls_MemberSearchctrl() 
     {    
     }        
     
     private Account aAccount = New Account();   
     public List<Account> accountList{get; set; }     
            
     public Boolean bRender{get;set;}    
     public string searchEmail    
      {        
       get        
          {            
           if (searchEmail==null) searchEmail= '';           
           return searchEmail;        
          }        
       set;    
      }        
      
      public string searchMobileNo    
       {        
        get        
           {            
            if (searchMobileNo==null) searchMobileNo= '';            
            return searchMobileNo;        
           }       
        set;    
       }        
       
       public string searchHomePhone    
        {        
         get        
            {            
             if (searchHomePhone==null) searchHomePhone= '';            
             return searchHomePhone;        
            }        
         set;    
        }        
        
        
        public PageReference search()    
         {        
           bRender = false;       
            if(accountList== null)        
              {            
                accountList= new List<Account>();        
              }        
            else        
              {            
                accountList.Clear();        
              }        
              String qryEmail = 'Select Name,PersonEmail,PersonHomePhone,PersonMobilePhone from Account  where  PersonEmail like \'%'+searchEmail+'%\' ';        
              String qryHomePhone = 'Select Name,PersonEmail,PersonHomePhone,PersonMobilePhone  from Account  where  PersonHomePhone like \'%'+searchHomePhone+'%\' ';        
              String qryMobileNo = 'Select Name,PersonEmail,PersonHomePhone,PersonMobilePhone  from Account  where  PersonMobilePhone like \'%'+searchMobileNo+'%\' ';                
              
              accountList= new List<Account>();        
              accountList= Database.query(qryEmail);        
              accountList= Database.query(qryHomePhone);        
              accountList= Database.query(qryMobileNo);        
              
                             
               return null;    
               }
               }