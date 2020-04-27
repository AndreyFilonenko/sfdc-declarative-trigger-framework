public class AccountTriggerHandlerMethod_3 implements TriggerHandler.BeforeInsertHandlerMethod {
    public void execute(List<SObject> newList) {
        List<Account> accounts = (List<Account>)newList;
        System.debug('AccountTriggerHandlerMethod_3 class executed! ' + accounts.size() + ' records passed. - Should be the last method called (before all overrides)');
    }
}