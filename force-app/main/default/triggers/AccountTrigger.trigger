trigger AccountTrigger on Account (before insert,
                                   before update,
                                   before delete,
                                   after insert,
                                   after update,
                                   after delete,
                                   after undelete) {
    new AccountTriggerHandler(
        Trigger.operationType,
        Trigger.new,
        Trigger.newMap,
        Trigger.old,
        Trigger.oldMap,
        Trigger.size
    ).dispatch();
}