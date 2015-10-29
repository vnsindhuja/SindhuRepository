public class FCHK_Cls_Order_Trigger_Handler{

    public static Set<Id> AccId = new Set<Id>();
    public static Set<Id> OrderId = new Set<Id>();
    public static List<Order> OrderLst = new List<Order>();
    public static List<Order> OrderLstUpdate = new List<Order>();
    public static List<Account> AccLst = new List<Account>();
    public static Map<Id,Account> AccMap;
    public static Map<Id,ID> AccMapOCount = new Map<Id,ID>();
    public static List<Order> OrderLstAddProd = new List<Order>();
    public static List<OrderItem> OrdItemLst = new List<OrderItem>();    
    
    
  
    public static void Update_SO_Number(List<Order> OrdrLst){
        for(Order ord : OrdrLst){
            ord.FCHK_SO_Number__c = Label.FCHK_CL_SO_Number;
        }
    }
       
    public static void CopyShippingAddress(List<Order> OrdrLst,Boolean Val){
        Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
        recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
    
        Map<id,RecordType> recordTypeMapOrdr = new Map<id,RecordType>();
        recordTypeMapOrdr.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
        for(Order Ord : OrdrLst){
            if(Ord.Status == 'Order Confirmed' || Ord.Status == 'Confirmed'){
                AccId.add(Ord.AccountId);
                OrderId.Add(Ord.Id);
            }
        }
        if(OrderId!=null){
        OrderLst = [select id, RecordTypeId,AccountId,FCHK_BirthDay_Offer_Taken__c,FCHK_1st_Purchase_Done__c,FCHK_Product_Code1__c,Account.FCHK_Optimel_Gold_Sample__c,
                    Account.FCHK_Optimel_Silver_Sample__c,Account.FCHK_Optimel_Diamond_Sample__c,FCHK_Product__c,FCHK_FM_FirstName__c,
                    FCHK_FM_LastName__c,FCHK_FM_DOB__c,FCHK_FM_Gender__c,FCHK_FM1_Relatioship_With_Member__c from Order where Id in :OrderId];
        AccMap = new Map<Id,Account>([select FCHK_BirthDay_Offer_Taken__c,FCHK_Shipping_Address__c,FCHK_1st_Purchase_Done__c,FCHK_Optimel_Gold_Sample__c,
                                     FCHK_Optimel_Silver_Sample__c,FCHK_Optimel_Diamond_Sample__c,FCHK_Brand_Name_Order__c,FCHK_Brand_Name_Order_Date__c,
                                     FCHK_FM1_First_Name__c,FCHK_FM2_First_Name__c,FCHK_FM3_First_Name__c,FCHK_FM1_Last_Name__c,FCHK_FM2_Last_Name__c,
                                     FCHK_FM3_Last_Name__c,FCHK_FM1_Gender__c,FCHK_FM2_Gender__c,FCHK_FM3_Gender__c,FCHK_FM1_Relationship_With_Member__c,
                                     FCHK_FM2_Relationship_with_Member__c,FCHK_FM3_Relationship_with_Member__c,FCHK_FM1_DOB__c,FCHK_FM2_DOB__c,
                                     FCHK_FM3_DOB__c,
                                (select id, FCHK_Shipping_Address__c,EffectiveDate
                                from Orders where Status = 'Order Confirmed' or Status = 'Confirmed' order by createddate desc limit 1) from Account where Id in : AccId ]);
         
        }  
        system.debug('-OrderLst-'+OrderLst);
        if(AccMap != null){                      
            for(Account Acc : AccMap.values()){
                for(Order Ordr : Acc.Orders){
                    String ShipAdd = Ordr.FCHK_Shipping_Address__c;
                    String s1 = ShipAdd.Replace('<br>','\r\n');
                    if(Val==false)
                        Acc.FCHK_Shipping_Address__c = s1; 
                        Acc.FCHK_Brand_Name_Order__c = 'Optimel';
                        Acc.FCHK_Brand_Name_Order_Date__c = Ordr.EffectiveDate;                   
                             
                 }   
                 system.debug('-Acc-'+Acc.Orders);
                if(OrderLst!=null){  
                for(Order O : OrderLst){   
                    if(Acc.Id==O.AccountId){   
                        if(O.FCHK_BirthDay_Offer_Taken__c == true && Acc.FCHK_BirthDay_Offer_Taken__c!=true && Val==false){
                            Acc.FCHK_BirthDay_Offer_Taken__c = true;                        
                        }       
                        if(O.FCHK_1st_Purchase_Done__c == true && Acc.FCHK_1st_Purchase_Done__c!=true && Val==false){
                            Acc.FCHK_1st_Purchase_Done__c = true;                       
                        }                                        
                        if(O.FCHK_Product_Code1__c == 'OP- GL' && Val==true){
                            if(O.Account.FCHK_Optimel_Gold_Sample__c!=null)
                                Acc.FCHK_Optimel_Gold_Sample__c = O.Account.FCHK_Optimel_Gold_Sample__c + 1;
                            else
                                Acc.FCHK_Optimel_Gold_Sample__c = 1;                    
                        }
                        if(O.FCHK_Product_Code1__c == 'OP- SL' && Val==true){
                            if(O.Account.FCHK_Optimel_Silver_Sample__c!=null)
                                Acc.FCHK_Optimel_Silver_Sample__c = O.Account.FCHK_Optimel_Silver_Sample__c + 1;
                            else
                            Acc.FCHK_Optimel_Silver_Sample__c = 1;                
                        }
                        if(O.FCHK_Product_Code1__c == 'OP- DM' && Val==true){
                            if(O.Account.FCHK_Optimel_Diamond_Sample__c!=null)
                                Acc.FCHK_Optimel_Diamond_Sample__c = O.Account.FCHK_Optimel_Diamond_Sample__c + 1;
                            else
                                Acc.FCHK_Optimel_Diamond_Sample__c = 1;                    
                        }  
                        if(O.FCHK_Product__c == 'Optimel Silver'){
                            Acc.FCHK_FM1_Relationship_With_Member__c = O.FCHK_FM1_Relatioship_With_Member__c;
                            Acc.FCHK_FM1_Gender__c = O.FCHK_FM_Gender__c;
                            Acc.FCHK_FM1_DOB__c = O.FCHK_FM_DOB__c;
                            Acc.FCHK_FM1_Last_Name__c = O.FCHK_FM_LastName__c;
                            Acc.FCHK_FM1_First_Name__c = O.FCHK_FM_FirstName__c;
                        }
                        if(O.FCHK_Product__c == 'Optimel Gold'){
                            Acc.FCHK_FM2_Relationship_With_Member__c = O.FCHK_FM1_Relatioship_With_Member__c;
                            Acc.FCHK_FM2_Gender__c = O.FCHK_FM_Gender__c;
                            Acc.FCHK_FM2_DOB__c = O.FCHK_FM_DOB__c;
                            Acc.FCHK_FM2_Last_Name__c = O.FCHK_FM_LastName__c;
                            Acc.FCHK_FM2_First_Name__c = O.FCHK_FM_FirstName__c;
                        }
                        if(O.FCHK_Product__c == 'Optimel Diamond'){
                            Acc.FCHK_FM3_Relationship_With_Member__c = O.FCHK_FM1_Relatioship_With_Member__c;
                            Acc.FCHK_FM3_Gender__c = O.FCHK_FM_Gender__c;
                            Acc.FCHK_FM3_DOB__c = O.FCHK_FM_DOB__c;
                            Acc.FCHK_FM3_Last_Name__c = O.FCHK_FM_LastName__c;
                            Acc.FCHK_FM3_First_Name__c = O.FCHK_FM_FirstName__c;
                        }
                    }
                }        
                }
                AccLst.add(Acc);
            }     
            if(AccLst.size()>0)
                update AccLst;        
    
        }
        System.debug('1.Number of Queries used in this apex code so far: bill' + Limits.getQueries());
    }
    
    public static void UpdateAcc_OrderDelete(List<Order> OrdrLstOld){
        Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
        recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
        
        Map<id,RecordType> recordTypeMapOrdr = new Map<id,RecordType>();
        recordTypeMapOrdr.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
        for(Order Ord : OrdrLstOld){
            AccId.add(Ord.AccountId);
            OrderId.Add(Ord.Id);
        }
        if(OrderId!=null){
        OrderLst = [select id, RecordTypeId,AccountId,FCHK_BirthDay_Offer_Taken__c,FCHK_1st_Purchase_Done__c,FCHK_Product_Code1__c
                     from Order where Id in :OrderId];
                    
        AccMap = new Map<Id,Account>([select id,FCHK_Order_Count__c,FCHK_BirthDay_Offer_Taken__c,FCHK_1st_Purchase_Done__c,
                                    FCHK_Optimel_Gold_Sample__c,FCHK_Optimel_Silver_Sample__c,FCHK_Optimel_Diamond_Sample__c,
                                    FCHK_Shipping_Address__c,(select id, FCHK_Shipping_Address__c from Orders order by createddate desc limit 1)
                                    from Account where Id in : AccId ]);                                    
        
            for(Order ord : OrderLst){
               /* if(recordTypeMapOrdr.get(ord.RecordTypeId).DeveloperName=='FCHK_RT_Order' && AccMap.get(ord.AccountId).FCHK_Order_Count__c > 0)
                    AccMap.get(ord.AccountId).FCHK_Order_Count__c = AccMap.get(ord.AccountId).FCHK_Order_Count__c - 1;*/
                if(recordTypeMapOrdr.get(ord.RecordTypeId).DeveloperName=='FCHK_RT_Order' && ord.FCHK_BirthDay_Offer_Taken__c == true)
                    AccMap.get(ord.AccountId).FCHK_BirthDay_Offer_Taken__c = false;
                if(recordTypeMapOrdr.get(ord.RecordTypeId).DeveloperName=='FCHK_RT_Order' && ord.FCHK_1st_Purchase_Done__c == true)
                    AccMap.get(ord.AccountId).FCHK_1st_Purchase_Done__c = false;
                    
                if(recordTypeMapOrdr.get(ord.RecordTypeId).DeveloperName=='FCHK_RT_Sample_Request' && ord.FCHK_Product_Code1__c == 'OP- GL'){
                    if(AccMap.get(ord.AccountId).FCHK_Optimel_Gold_Sample__c > 0)
                        AccMap.get(ord.AccountId).FCHK_Optimel_Gold_Sample__c = AccMap.get(ord.AccountId).FCHK_Optimel_Gold_Sample__c - 1;                                            
                }
                if(recordTypeMapOrdr.get(ord.RecordTypeId).DeveloperName=='FCHK_RT_Sample_Request' && ord.FCHK_Product_Code1__c == 'OP- SL'){
                    if(AccMap.get(ord.AccountId).FCHK_Optimel_Silver_Sample__c > 0)
                        AccMap.get(ord.AccountId).FCHK_Optimel_Silver_Sample__c = AccMap.get(ord.AccountId).FCHK_Optimel_Silver_Sample__c - 1;                               
                }
                if(recordTypeMapOrdr.get(ord.RecordTypeId).DeveloperName=='FCHK_RT_Sample_Request' && ord.FCHK_Product_Code1__c == 'OP- DM'){
                    if(AccMap.get(ord.AccountId).FCHK_Optimel_Diamond_Sample__c > 0)
                        AccMap.get(ord.AccountId).FCHK_Optimel_Diamond_Sample__c = AccMap.get(ord.AccountId).FCHK_Optimel_Diamond_Sample__c - 1;                                     
                }  
                
                String ShipAdd = AccMap.get(ord.AccountId).Orders[0].FCHK_Shipping_Address__c;
                String s1 = ShipAdd.Replace('<br>','\r\n');
                AccMap.get(ord.AccountId).FCHK_Shipping_Address__c = s1;           
                
                system.debug('--Map--'+AccMap.get(ord.AccountId).Orders[0].id);
                AccLst.add(AccMap.get(ord.AccountId));
                
            }
            if(AccLst.size() > 0)
                update AccLst;
        }
        System.debug('1.Number of Queries used in this apex code so far: delete' + Limits.getQueries());
    }
    
    public static void CopyBillingToShipping(List<Order> OrdrLstNew){
        Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
        recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
        
        Map<id,RecordType> recordTypeMapOrdr = new Map<id,RecordType>();
        recordTypeMapOrdr.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
        for(Order Ord : OrdrLstNew){            
                AccId.add(Ord.AccountId);
                OrderId.Add(Ord.Id);            
           
        }
        
        List<Account> RecAcc = [select id,RecordTypeId from Account where Id in :AccId];
        for(Account A : RecAcc){
        system.debug('--A.RecordTypeId--'+A.RecordTypeId);
            AccMapOCount.put(A.Id,A.RecordTypeId);
        }
        if(OrderId!=null)
        OrderLst = [select id, AccountId,FCHK_BirthDay_Offer_Taken__c,FCHK_Same_as_BillingAddress__c, FCHK_Offer_Type__c,
                    FCHK_1st_Purchase_Done__c,FCHK_Block__c,FCHK_Building__c,FCHK_District__c,FCHK_EState__c,FCHK_Flat__c,FCHK_Street__c,
                    FCHK_Floor__c,FCHK_Territory__c,Account.FCHK_Block__c,Account.FCHK_Building__c,Account.FCHK_District__c,
                    Account.FCHK_EState__c,Account.FCHK_Flat__c,Account.FCHK_Floor__c,Account.FCHK_Territory__c, Account.RecordTypeId,
                    Account.FCHK_HCP_Member__c,FCHK_Billing_Address1__c,Account.FCHK_Street__c,FCHK_Total_Product_Quantity__c from Order where Id in :OrderId];
                    
        if(OrderLst.size() > 0 ){
        for(Order ord : OrderLst){
            if(AccMapOCount.get(Ord.AccountId) == recordTypeMapAcc.get(Ord.Account.RecordTypeId).Id){
            
                PriceBook2 prckbk = [select id from PriceBook2 where IsStandard=true];
                PriceBook2 prckbkHCP = [select id from PriceBook2 where name='HCP Member Price Book'];
                system.debug('-prckbk-'+prckbk.id);                
                if(ord.Account.FCHK_HCP_Member__c==true && ord.FCHK_Total_Product_Quantity__c==0){          
                    Ord.Pricebook2Id = prckbkHCP.id;
                }
                else if(ord.Account.FCHK_HCP_Member__c!=true && ord.FCHK_Total_Product_Quantity__c==0){
                    Ord.Pricebook2Id = prckbk.id;
                }
                system.debug('--AccMapOCount.get(Ord.AccountId)--'+AccMapOCount.get(Ord.AccountId));
                //system.debug('--recordTypeMapOrdr.get(O.Account.RecordTypeId).DeveloperName--'+recordTypeMapOrdr.get(O.Account.RecordTypeId).DeveloperName=='FCHK_MR_RT_Optimel'.Id);
                if(ord.FCHK_Same_as_BillingAddress__c == true && (ord.Account.FCHK_Block__c!=null || ord.Account.FCHK_Building__c!=null || ord.Account.FCHK_District__c!=null ||
                    ord.Account.FCHK_Flat__c !=null || ord.Account.FCHK_EState__c!=null || ord.Account.FCHK_Floor__c!=null || ord.Account.FCHK_Territory__c!=null || ord.Account.FCHK_Street__c!=null)){
                    ord.FCHK_Block__c = ord.Account.FCHK_Block__c;
                    ord.FCHK_Building__c = ord.Account.FCHK_Building__c;
                    ord.FCHK_District__c = ord.Account.FCHK_District__c;
                    ord.FCHK_Flat__c = ord.Account.FCHK_Flat__c;
                    ord.FCHK_EState__c = ord.Account.FCHK_EState__c;
                    ord.FCHK_Floor__c = ord.Account.FCHK_Floor__c;
                    ord.FCHK_Territory__c = ord.Account.FCHK_Territory__c;
                    ord.FCHK_Street__c = ord.Account.FCHK_Street__c;
                    //OrderLstUpdate.add(ord);
                    system.debug('--ord.Account.FCHK_EState__c--'+ord.Account.FCHK_EState__c);
                }
                 OrderLstUpdate.add(ord);
            }
        }
        
        if(OrderLstUpdate.size() > 0)
            update OrderLstUpdate;             
        }
        System.debug('1.Number of Queries used in this apex code so far: ship' + Limits.getQueries());
    }
    
  
    
    public static void ChangeOrderPriceBook(List<Order> OrdrLst){
        PriceBook2 prckbk = [select id from PriceBook2 where IsStandard=true];
        PriceBook2 prckbkHCP = [select id from PriceBook2 where name='HCP Member Price Book'];
        system.debug('-prckbk-'+prckbk.id);
         for(Order Ordr : OrdrLst){                    
            Ordr.Pricebook2Id = prckbk.id;
        }
    }
    public static void AddSampleProducts(List<Order> OrdrLst){
        Map<id,RecordType> recordTypeMapAcc = new Map<id,RecordType>();
        recordTypeMapAcc.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Account'));
        
        Map<id,RecordType> recordTypeMapOrdr = new Map<id,RecordType>();
        recordTypeMapOrdr.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
         for(Order ord : OrdrLst){
             
                OrderId.add(ord.id);
                AccId.add(ord.AccountId);
            
        }
        List<Account> RecAcc = new List<Account>();
        if(AccId!=null){    
           RecAcc  = [select id,RecordTypeId from Account where Id in :AccId];
        }    
        if(RecAcc.size() > 0){
            for(Account A : RecAcc){
            system.debug('--A.RecordTypeId--'+A.RecordTypeId);
                AccMapOCount.put(A.Id,A.RecordTypeId);
            }
        }
        if(OrderId!=null){
             OrderLstAddProd = [select id, AccountId,Pricebook2Id,Account.Id,Account.FCHK_HCP_Member__c,Account.RecordTypeId,
                                FCHK_Product_Code1__c,FCHK_Product__c from Order where Id in :OrderId];
        }
        PriceBook2 prckbk = [select id from PriceBook2 where IsStandard=true];
        PriceBook2 prckbkHCP = [select id from PriceBook2 where name='HCP Member Price Book'];
        List<PricebookEntry> PriceBkLstS = [select id,Pricebook2Id,ProductCode from PriceBookEntry where Pricebook2Id=:prckbk.id];
        List<PricebookEntry> PriceBkLstHCP = [select id,Pricebook2Id,ProductCode from PriceBookEntry where Pricebook2Id=:prckbkHCP.id];
        Map<String, PricebookEntry> PriceBkMap = new Map<String,PricebookEntry>();
        /*if(PriceBkLst.size() > 0){
            for(PricebookEntry prbk : PriceBkLst){
                PriceBkMap.put(prbk.ProductCode,prbk);
            }
        }*/
        if(OrderLstAddProd.size() > 0){       
            for(Order O : OrderLstAddProd){
                
                
                    if(PriceBkLstS.size() > 0 && O.Account.FCHK_HCP_Member__c!=true){
                        for(PricebookEntry prbk : PriceBkLstS)
                            PriceBkMap.put(prbk.ProductCode,prbk);
                    }
                    if(PriceBkLstHCP.size() > 0 && O.Account.FCHK_HCP_Member__c==true){
                        for(PricebookEntry prbk : PriceBkLstHCP){
                            PriceBkMap.put(prbk.ProductCode,prbk);
                        }
                        
                    }
                
            
                if(AccMapOCount.get(O.AccountId) == recordTypeMapAcc.get(O.Account.RecordTypeId).Id 
                	&& PriceBkMap!=null && PriceBkMap.size()>0 && PriceBkMap.get(O.FCHK_Product_Code1__c)!=null){
                    OrderItem OrdItem = new OrderItem();
                    OrdItem.OrderId = O.Id;
                    OrdItem.PricebookentryId = PriceBkMap.get(O.FCHK_Product_Code1__c).Id;         
                    OrdItem.Quantity = 1;
                    OrdItem.UnitPrice = 0.0;
                    OrdItemLst.add(OrdItem);
                }
            }  
            if(OrdItemLst.size()>0)
                insert OrdItemLst;   
        }  
          System.debug('1.Number of Queries used in this apex code so far: Sample' + Limits.getQueries());
        
    }
    
 public static void Calculate_Next_Holiday(List<Order> Ordr){
    Date TodayDate = Date.Today();
    Integer Todaymonthint=TodayDate.Month();
    system.debug('--Todaymonthint--'+Todaymonthint);
    List<Holiday> HolLst = [select id,name,ActivityDate from Holiday where  Activitydate=this_year and Activitydate>=:TodayDate order by ActivityDate asc];    
    //List<Holiday> HolLst = [select id,name,ActivityDate from Holiday order by ActivityDate asc];
    system.debug('--HolidayLst--'+HolLst);
    for(Order o : Ordr){
        Date OrdrDate; 
        DateTime OrderSentDate = (DateTime)o.EffectiveDate;       
        Integer HolDay=0;
        String dayOfWeekIsSat = OrderSentDate.format('EEEE');            
        system.debug('--day1--'+dayOfWeekIsSat);
        if(dayOfWeekIsSat=='Friday')
            HolDay = 2;
        else if(dayOfWeekIsSat=='Saturday')
            HolDay = 2;
        else if(dayOfWeekIsSat=='Sunday')
            HolDay = 1;
            
        Date PrevDate=null;
        system.debug('--HolDay--'+HolDay);
        List<Date> Dates = new List<Date>();
        integer i=0,Actmonthint,Actyear,Todayyear,flag=0;       
        for(Holiday hol : HolLst){
            OrdrDate=hol.Activitydate;  
            //TodayDate=Date.Today();                   
            Actmonthint=OrdrDate.month();
            //Todaymonthint=TodayDate.month();
            Actyear = OrdrDate.Year();
            Todayyear = TodayDate.Year();
           
            //if(OrdrDate>TodayDate && Actmonthint == Todaymonthint && Actyear==Todayyear){           
                
                Dates.add(hol.ActivityDate);
                //o.FCHK_Next_Holiday_On__c = hol.ActivityDate;
            //}
            
        }
        system.debug('--Dates--'+Dates);
        /*if(Dates.size()==1){
            TodayDate=o.EffectiveDate;
            Datetime dt2 = (DateTime)Dates[0];            
            String dayOfWeek2 = dt2.format('EEEE');            
            system.debug('--day1--'+dayOfWeek2);
            Integer daysbetn = TodayDate.daysBetween(Dates[0]);
            if(daysbetn==1 && HolDay==0){
                if(dayOfWeek2=='Friday')
                    HolDay = 3;
                else
                    HolDay = 1;                    
            }     
            else if(daysbetn==1 && HolDay>0){
                if(dayOfWeek2=='Friday')
                    HolDay = HolDay + 1;                                    
            }               
            
        }
        else{*/
        for(Integer dat=0;dat<Dates.size()-1;dat++ ){
            DateTime TodayDate1 = o.EffectiveDate;
            String dayToday = TodayDate1.format('EEEE');
            Integer daysbetnToday = o.EffectiveDate.daysBetween(Dates[dat]);
            /*if(dayToday=='Friday' && daysbetnToday>1){
                HolDay=2;
            }*/
            //if(daysbetnToday==1){
                system.debug('--HolDay--'+HolDay);

                Datetime dt = (DateTime)Dates[dat];
                Datetime dt1 = (DateTime)Dates[dat+1];
                String dayOfWeek = dt.format('EEEE');
                String dayOfWeek1 = dt1.format('EEEE');
                system.debug('--day--'+dayOfWeek);system.debug('--day1--'+dayOfWeek1);
                Integer daysbetn = Dates[dat].daysBetween(Dates[dat+1]);
                system.debug('--daysbetn--'+daysbetn);
                system.debug('--daysbetnToday--'+daysbetnToday);
                if(daysbetn==1 || daysbetnToday==1||daysbetnToday==2||daysbetnToday==3){
                    if((daysbetnToday==1 && dayOfWeek1=='Friday') || (dayOfWeek=='Monday' && daysbetnToday==3) || (dayToday=='Saturday' && daysbetnToday==2) || (dayToday=='Sunday' && daysbetnToday==1)){
                    system.debug('---in if---'+HolDay);
                    //Saranyan - Cant we use Calendar functions instead of Hard Coded days for weekends?
                        if(HolDay==0)
                            HolDay = 4;
                        else    
                            HolDay = HolDay + 1;
                    }           
                    else if(dayOfWeek=='Tuesday' && HolDay==4){
                        HolDay = HolDay + 1;
                    }
                    else if(dayOfWeek=='Wednesday' && HolDay==5){
                        HolDay = HolDay + 1;
                    }
                   
                }   
                else if(HolDay == 0)
                     HolDay = 0;
               
           // }
        }
        //}
        o.FCHK_Number_of_Holidays__c = HolDay;
    }
    System.debug('1.Number of Queries used in this apex code so far: Hol' + Limits.getQueries());
    }   
        
    

}