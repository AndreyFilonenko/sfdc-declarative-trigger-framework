public class AccountTriggerHandlerMethod_1 implements Callable {
    public Object call(String action, Map<String, Object> args) {
        List<Account> accounts = (List<Account>)args.get('newList');
        System.debug('AccountTriggerHandlerMethod_1 class executed! ' + accounts.size() + ' records passed. - Should be the first method called');
        return null;
    }
}