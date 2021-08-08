global with sharing class AccountHelper {
    private static Boolean flagForSingleton = true;

    @future
    public static void createTask(List<Id> newAccountsIds){
        AccountTaskManager.createTaskForAccount(newAccountsIds);
    }

    @future
    public static void updateContacts(List<Id> newAccountsIds){
        ContactManager.updateContacts(newAccountsIds);
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

        if (flagForSingleton == true){
            AccountHelper.flagForSingleton = false;
            List<Id> newAccountIds = new List<Id>();

            for (Account account : newAccounts){
                newAccountIds.add(account.Id);
            }

            TasksManager.assignTasks(newAccountIds);
        }
    }
}
