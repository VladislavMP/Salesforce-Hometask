global with sharing class AccountHelper {
    private static Boolean flagForSingelton = true;

    public static void createTask(List<Account> newAccounts){
        AccountTaskManager.createTaskForAccount(newAccounts);
    }

    public static void assingTask(List<Account> newAccounts){

        if (flagForSingelton == true){
            AccountHelper.flagForSingelton = false;
            List<Id> newAccountIds = new List<Id>();

            for (Account account: newAccounts){
                newAccountIds.add(account.Id);
            }

            TasksManager.assignTasks(newAccountIds);
        }
    }
}
