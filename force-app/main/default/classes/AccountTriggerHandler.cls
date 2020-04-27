public class AccountTriggerHandler extends TriggerHandler {
    public AccountTriggerHandler(System.TriggerOperation triggerOperation,
                                 List<Account> newList,
                                 Map<Id, Account> newMap,
                                 List<Account> oldList,
                                 Map<Id, Account> oldMap,
                                 Integer size) {
        super(
            triggerOperation,
            newList,
            newMap,
            oldList,
            oldMap,
            size
        );
    }    

    public override void beforeInsert() {
        super.beforeInsert();

        System.debug('Overriden beforeInsert method executed!');
    }
}