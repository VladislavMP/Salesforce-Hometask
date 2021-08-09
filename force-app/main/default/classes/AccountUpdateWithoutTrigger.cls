public with sharing class AccountUpdateWithoutTrigger {

    @future
    public static void updateAccounts(){
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

        List<Contact> contacts = new List<Contact>([SELECT IsSynced__c, ProcessedByFuture__c FROM Contact WHERE AccountId =: accountsIds]);
        for(Contact contact : contacts){
            contact.IsSynced__c = false;
            contact.ProcessedByFuture__c = true;
        }

        update contacts;
    } 
}
