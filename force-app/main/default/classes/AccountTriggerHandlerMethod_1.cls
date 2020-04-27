public class AccountTriggerHandlerMethod_1 implements TriggerHandler.BeforeInsertHandlerMethod {
    public void execute(List<SObject> newList) {
        List<Account> accounts = (List<Account>)newList;
        System.debug('AccountTriggerHandlerMethod_1 class executed! ' + accounts.size() + ' records passed. - Should be the first method called');
    }
}