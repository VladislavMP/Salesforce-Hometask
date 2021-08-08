global with sharing class AccountTriggerHandler {

    public static void handleBeforeInsert(List<Account> newList){
        AccountHelper.createTask(newList);
    } 

    public static void handleBeforeUpdate(List<Account> newList, Map<Id, Account> newMap, List<Account> oldList, Map<Id, Account> oldMap){
        
    } 

    public static void handleBeforeDelete(List<Account> oldList, Map<Id, Account> oldMap){
        
    } 

    public static void handleAfterInsert(List<Account> newList, Map<Id, Account> newMap){
        
    } 

    public static void handleAfterUpdate(List<Account> newList, Map<Id, Account> newMap, List<Account> oldList, Map<Id, Account> oldMap){
        AccountHelper.assingTask(newList);
        AccountHelper.flagForSingelton = false;
    } 

    public static void handleAfterDelete(List<Account> oldList, Map<Id, Account> oldMap){
        
    } 

    public static void handleAfterUndelete(List<Account> newList, Map<Id, Account> newMap){
        
    } 
}
