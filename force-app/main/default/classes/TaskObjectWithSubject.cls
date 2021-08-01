public with sharing class TaskObjectWithSubject {

    @InvocableMethod
    public static void taskObjectWithSubject() {
        ID accountID = account.Id;
        Task task = new Task();
        task.Subject = 'Negotioations with {account.Name}';
        task.WhatId = accountID;
        insert task;

        Integer count = 0;

        for(Account[] acct: [SELECT Name, (SELECT Subject FROM Tasks) FROM Account]) {
            count++;
        }

        if (!String.isBlank(accountID) && count > 3) {
            List<Account> acc = [SELECT Name, (SELECT OwnerId FROM Tasks) FROM Account];
            List<Account> accToUpdate = new List<Account>();
            for(Account acc2: acc) {
                acc2.Tasks.OwnerId = 'Slava Tsytskovsky';
                accToUpdate.add(acc2);
            }
            update accToUpdate;
        }
        
    }
}
