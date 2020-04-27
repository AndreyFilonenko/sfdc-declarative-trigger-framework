public class AccountTriggerHandlerMethod_4 implements TriggerHandler.AfterInsertHandlerMethod {
    public void execute(List<SObject> newList) {
        List<Account> accounts = (List<Account>)newList;
        System.debug('AccountTriggerHandlerMethod_4 class executed! ' + accounts.size() + ' records passed.');
    }
}