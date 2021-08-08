public with sharing class ContactsUpdateBatch implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator('SELECT IsSynced__c, AccountOwner__c, WhatId FROM Task WHERE IsSynced__c = false');
    }

    public void execute(Database.BatchableContext context, List<Contact> contacts){
    }

    public void finish(Database.BatchableContext context){}
}
