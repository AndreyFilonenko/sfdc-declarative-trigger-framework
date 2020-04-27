public class AccountTriggerHandlerMethod_2 implements TriggerHandler.BeforeInsertHandlerMethod {
    public void execute(List<SObject> newList) {
        List<Account> accounts = (List<Account>)newList;
        System.debug('AccountTriggerHandlerMethod_2 class executed! ' + accounts.size() + ' records passed.');
    }
}