public class AccountProcessBuilderHandler {
    @InvocableMethod(label='Handle Account updates' description='' category='Account')
    public static void handleAccountProcessBuilder(List<Id> accountIds) {
        System.debug(accountIds);
        Task task = new Task();
        task.Subject = 'Negotioations with {Account.Name}';
        task.WhatId = accountIds[0];
        insert task;
    }
}
