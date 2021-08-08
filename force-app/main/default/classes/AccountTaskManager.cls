public with sharing class AccountTaskManager {

    @InvocableMethod
    public static void createTaskForAccount(List<Id> accountsIds){
        List<Task> tasks = new List<Task>();
        for (Account account : [SELECT Name, Id FROM Account WHERE Id =: accountsIds]){
            tasks.add(new Task(Subject = 'Negotiations with ' + account.Name, WhatId = account.Id, IsSynced__c = false));
        }
        insert tasks;
    }
}

