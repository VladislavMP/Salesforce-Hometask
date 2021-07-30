public with sharing class AccountTaskManager {
    public AccountTaskManager() {
    }

    @InvocableMethod
    public static void AccountTaskCreation(List<Account> acc){
        Task firstTask = new Task();
        firstTask.Subject = 'Negotiations with ' + acc[0].Name;
        firstTask.WhatId = acc[0].Id;
        insert firstTask;
    }
}

