public with sharing class ContactManager implements Queueable {
    private List<Id> accountsIds;

    public ContactManager(List<Id> Ids){
        this.accountsIds = Ids;
    }

    public void execute(QueueableContext context){
        List<Contact> contacts = [SELECT IsSynced__c, ProcessedByFuture__c FROM Contact WHERE AccountId =: accountsIds];
        for (Contact contact : contacts){
            contact.IsSynced__c = false;
            contact.ProcessedByQueue__c = true;
        }

        update contacts;
    }

    public static void updateContacts(List<Id> newAccountsIds){
        List<Contact> contacts = [SELECT IsSynced__c, ProcessedByFuture__c FROM Contact WHERE AccountId =: newAccountsIds];
        for (Contact contact : contacts){
            contact.IsSynced__c = false;
            contact.ProcessedByFuture__c = true;
        }
        
        update contacts;
    }

}
