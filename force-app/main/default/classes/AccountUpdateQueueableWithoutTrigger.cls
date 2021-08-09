public with sharing class AccountUpdateQueueableWithoutTrigger {

    public void execute(QueueableContext context){
        List<Account> accounts = new List<Account>([SELECT BillingCity, BillingStreet, BillingPostalCode, BillingState, BillingCountry FROM Account LIMIT 150]);
        List<Account> accountsIds = new List<Account>();
        for(Account account : accounts){
            if(account.BillingCity != null ||
                account.BillingStreet != null ||
                account.BillingPostalCode != null ||
                account.BillingState != null ||
                account.BillingCountry != null){
                    accountsIds.add(account);
                }
        }

        List<Contact> contacts = new List<Contact>([SELECT IsSynced__c, ProcessedByQueue__c FROM Contact WHERE AccountId =: accountsIds]);
        for(Contact contact : contacts){
            contact.IsSynced__c = false;
            contact.ProcessedByQueue__c = true;
        }

        update contacts;
    }
}
