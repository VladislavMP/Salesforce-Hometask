public with sharing class TasksUpdateSchedulate implements Schedulable {

    public void execute(SchedulableContext context){
        Id tasksBatchId = Database.executeBatch(new TasksUpdateBatch()); 
        Id contactsBatchId = Database.executeBatch(new ContactsUpdateBatch());
    }
}
