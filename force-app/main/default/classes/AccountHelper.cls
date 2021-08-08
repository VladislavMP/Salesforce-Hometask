global with sharing class AccountHelper {
    private static Boolean flagForSingleton = true;

    public static void createTask(List<Account> newAccounts){
        AccountTaskManager.createTaskForAccount(newAccounts);
    }

    public static void assingTask(List<Account> newAccounts){

        if (flagForSingleton == true){
            AccountHelper.flagForSingleton = false;
            List<Id> newAccountIds = new List<Id>();

            for (Account account: newAccounts){
                newAccountIds.add(account.Id);
            }

            TasksManager.assignTasks(newAccountIds);
        }
    }
}
