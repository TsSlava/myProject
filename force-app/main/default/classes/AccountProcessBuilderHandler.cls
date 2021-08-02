public class AccountProcessBuilderHandler {
    @InvocableMethod()
    public static void handleAccountProcessBuilder(List<Id> accountIds) {
        List<Account> accts = [SELECT Name, LastModifiedDate, CreatedDate, (SELECT Subject FROM Tasks) FROM Account WHERE ID IN :accountIds];
        User randomUser = getRandomUser();
       
        
        if (accts.size() > 0) {
            Account acct = accts[0];
            if(acct.CreatedDate == acct.LastModifiedDate) {
                insert new Task(
                    Subject = 'Negotioations with ' + acct.Name,
                    WhatId  = acct.Id
                );
            } else {
                if(acct.Tasks.size() > 3) {
                    for(Task task: acct.Tasks) {
                        task.OwnerId = randomUser.Id;
                    }
                    update acct.Tasks;
                }
            }    
        }
        
    }
    
    public static User getRandomUser() {
        List<User> user = [SELECT Id FROM User WHERE IsActive = TRUE];
        Integer num = (Integer)Math.floor(Math.random() * user.size());
        return user[num];
    }
}
