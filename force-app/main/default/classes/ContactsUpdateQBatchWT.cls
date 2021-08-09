public with sharing class ContactsUpdateQBatchWT implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator('SELECT IsSynced__c, MailingCity, MailingStreet, MailingPostalCode, MailingState, MailingCountry, AccountId FROM Contact WHERE IsSynced__c = false');
    }

    public void execute(Database.BatchableContext context, List<Contact> contacts){
        Set<Id> accountIds = new Set<Id>();
        for (Contact contact : contacts){
            accountIds.add(contact.AccountId);
        }

        Map<Id, Account> accounts = new Map<Id, Account>([SELECT Id, UpdatedByContact__c, BillingCity, BillingStreet, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Id =: accountIds]);
        for (Contact contact : contacts){
            contact.IsSynced__c = true;
            contact.MailingCity = accounts.get(contact.AccountId)?.BillingCity;
            contact.MailingStreet = accounts.get(contact.AccountId)?.BillingStreet;
            contact.MailingPostalCode = accounts.get(contact.AccountId)?.BillingPostalCode;
            contact.MailingState = accounts.get(contact.AccountId)?.BillingState;
            contact.MailingCountry = accounts.get(contact.AccountId)?.BillingCountry;
        }
        for (Account account : accounts.values()){
            account.UpdatedByContact__c = true;
        }

        update accounts.values();
        update contacts;

    }

    public void finish(Database.BatchableContext context){}
}
