global with sharing class AccountTriggerHandler {

    public static void handleBeforeInsert(List<Account> newList){
        List<Id> accountsIds = new List<Id>();
        for (Account account : newList){
            accountsIds.add(account.Id);
        }

        AccountHelper.createTask(accountsIds);
    } 

    public static void handleBeforeUpdate(List<Account> newList, Map<Id, Account> newMap, List<Account> oldList, Map<Id, Account> oldMap){
        
    } 

    public static void handleBeforeDelete(List<Account> oldList, Map<Id, Account> oldMap){
        
    } 

    public static void handleAfterInsert(List<Account> newList, Map<Id, Account> newMap){
        
    } 

    public static void handleAfterUpdate(List<Account> newList, Map<Id, Account> newMap, List<Account> oldList, Map<Id, Account> oldMap){
        AccountHelper.assingTasks(newList);
        List<Id> accountsIds = new List<Id>();
        accountsIds = AccountHelper.isBillingAddressChanged(newList, oldMap);
        //AccountHelper.updateContacts(accountsIds);
        AccountHelper.updateContactsQueueable(accountsIds);
    } 

    public static void handleAfterDelete(List<Account> oldList, Map<Id, Account> oldMap){
        
    } 

    public static void handleAfterUndelete(List<Account> newList, Map<Id, Account> newMap){
        
    } 
}
