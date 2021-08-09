public with sharing class ContactsUpdateSchedulateWT implements Schedulable {

    public void execute(SchedulableContext context){
        Id contactsIBatchId = Database.executeBatch(new ContactsUpdateIBatchWT()); 
        Id contactsQBatchId = Database.executeBatch(new ContactsUpdateQBatchWT());
    }
}
