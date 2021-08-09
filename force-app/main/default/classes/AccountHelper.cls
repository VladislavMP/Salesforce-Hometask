global with sharing class AccountHelper {
   public static Boolean flagForSingleton = true;

    @future
    public static void createTask(List<Id> accountIds, List<String> accountNames){
        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < accountIds.size(); i++){
            tasks.add(new Task(Subject = 'Negotiations with ' + accountNames[i], WhatId = accountIds[i], IsSynced__c = false));
        }
        insert tasks;
    }

    @future
    public static void updateContacts(List<Id> accountsIds){
        //ContactManager.updateContacts(newAccountsIds);
        List<Contact> contacts = [SELECT IsSynced__c, ProcessedByFuture__c FROM Contact WHERE AccountId =: accountsIds];
        for (Contact contact : contacts){
            contact.IsSynced__c = false;
            contact.ProcessedByFuture__c = true;
        }
        
        update contacts;
    }

    public static void updateContactsQueueable(List<Id> newAccountsIds)
    {
        ContactManager updateJob = new ContactManager(newAccountsIds);
        ID jobID = System.enqueueJob(updateJob);
    }

    public static List<Id> isBillingAddressChanged(List<Account> newAccounts, Map<Id, Account> oldAccountsMap){
        List<Id> accountsIds = new List<Id>();
        for (Account account : newAccounts){
            if (account.BillingCity != oldAccountsMap.get(account.Id).BillingCity ||
                account.BillingStreet != oldAccountsMap.get(account.Id).BillingStreet ||
                account.BillingPostalCode != oldAccountsMap.get(account.Id).BillingPostalCode ||
                account.BillingState != oldAccountsMap.get(account.Id).BillingState ||
                account.BillingCountry != oldAccountsMap.get(account.Id).BillingCountry){

                accountsIds.add(account.Id);
            }
        }

        return accountsIds;
    }

    public static void assingTasks(List<Account> newAccounts){
            List<Id> newAccountIds = new List<Id>();

            for (Account account : newAccounts){
                newAccountIds.add(account.Id);
            }

            TasksManager.assignTasks(newAccountIds);
    }

}
