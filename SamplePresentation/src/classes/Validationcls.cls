public with sharing class Validationcls {
	public Account actObj{get;set;}
	public String firstName{get;set;}
	public String lastName{get;set;}
	public Validationcls(){
		actObj = new Account();
	}
}