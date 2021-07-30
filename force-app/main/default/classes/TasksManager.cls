public with sharing class TasksManager {
    public TasksManager() {
    }

    @InvocableMethod
    public static void AssignTasks(List<Id> accId){
        
        List<Task> tasksOfAccount = [SELECT OwnerId FROM Task WHERE WhatId = :accId[0]];

        if (tasksOfAccount.size() >= 3){
        User userForTask = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];
        for (Task task: tasksOfAccount)
        {
            task.OwnerId = userForTask.Id;
        }
        update tasksOfAccount;
        }
    }
}
