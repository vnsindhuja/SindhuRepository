public class FCHK_Cls_CheckRecursive{

    public static boolean flag=true;
    public static boolean runonce(){
        if(flag){
            flag=false;
        }
        else {
            return flag;
        }
    return true;
    }

}