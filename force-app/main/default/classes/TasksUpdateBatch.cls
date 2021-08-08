public with sharing class TasksUpdateBatch implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator('SELECT IsSynced__c, AccountOwner__c, WhatId FROM Task WHERE IsSynced__c = false');
    }

    public void execute(Database.BatchableContext context, List<Task> tasks){
        List<Id> accountIds = new List<Id>();
        for (Task task : tasks){
            if (!accountIds.contains(task.WhatId)){
                accountIds.add(task.WhatId);
            }
        }

        Map<Id, Account> accounts = new Map<Id, Account>([SELECT Id, Name, UpdatedByTask__c FROM Account WHERE Id =: accountIds]);
        for (Task task : tasks){
            task.IsSynced__c = true;
            task.AccountOwner__c = accounts.get(task.WhatId).Name;
        }
        for (Account account : accounts.values())
        {
            account.UpdatedByTask__c = true;
        }

        update accounts.values();
        update tasks;
    }

    public void finish(Database.BatchableContext context){}
}
