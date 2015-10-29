trigger FCHK_OrderTrigger on Order (before insert,after insert,after update,before delete) {
  Map<id,RecordType> recordTypeMapOrdr = new Map<id,RecordType>();
    recordTypeMapOrdr.putAll(FCHK_Cls_RecordTypeUtilcls.getRecordTypes('Order'));
  if(Trigger.isBefore && Trigger.isInsert){
      //FCHK_Cls_Order_Trigger_Handler.ChangeOrderPriceBook(Trigger.New);
      //FCHK_Cls_Order_Trigger_Handler.Check_FirstPurchase_Birthday(Trigger.New);
      FCHK_Cls_Order_Trigger_Handler.Calculate_Next_Holiday(Trigger.New);
      FCHK_Cls_Order_Trigger_Handler.Update_SO_Number(Trigger.New);
  }
  /*if(Trigger.isBefore && Trigger.isUpdate){
      FCHK_Cls_Order_Trigger_Handler.Check_FirstPurchase_Birthday(Trigger.New);
  }*/
  if(Trigger.isAfter && Trigger.isInsert && FCHK_Cls_CheckRecursive.runonce()){
      FCHK_Cls_Order_Trigger_Handler.CopyBillingToShipping(Trigger.New);  
      FCHK_Cls_Order_Trigger_Handler.CopyShippingAddress(Trigger.New,true); 
      for(Order OrdObj:trigger.new){
          if(recordTypeMapOrdr.get(OrdObj.RecordTypeId).DeveloperName=='FCHK_RT_Sample_Request')         
              FCHK_Cls_Order_Trigger_Handler.AddSampleProducts(Trigger.New);    
      }
  }
  if(Trigger.isAfter && Trigger.isUpdate && FCHK_Cls_CheckRecursive.runonce()){
      FCHK_Cls_Order_Trigger_Handler.CopyShippingAddress(Trigger.New,false);  
      FCHK_Cls_Order_Trigger_Handler.CopyBillingToShipping(Trigger.New);
                
  }
  if(Trigger.isDelete && Trigger.isBefore && FCHK_Cls_CheckRecursive.runonce()){
      FCHK_Cls_Order_Trigger_Handler.UpdateAcc_OrderDelete(Trigger.Old);
      
  }
  
    
}