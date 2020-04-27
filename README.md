# Salesforce Apex trigger framework

<a href="https://githubsfdeploy.herokuapp.com?owner=AndreyFilonenko&repo=sfdc-declarative-trigger-framework&ref=master">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## Overview
A simple and minimal framework for Salesforce Apex triggers with declarative trigger handlers management - in accordance with Salesforce development best practices, defines a single entry point for sObject trigger with dispatching handler functions by a specific trigger event. Also gives an ability to manage trigger handlers with the no-code approach, just managing custom metadata descriptors via point and clicks.

## *TriggerHandler* public API
#### Properties:
* `List<SObject> newList` - readonly, returns the Trigger.new records
* `Map<Id, SObject> newMap` - readonly, returns the Trigger.newMap records
* `List<SObject> oldList` - readonly, returns the Trigger.old records
* `Map<Id, SObject> oldMap` - readonly, returns the Trigger.oldMap records
* `Integer size` - readonly, returns the quantity of trigger records

#### Exceptions
* `TriggerHandlerException` - will be thrown in the next cases:
    1. Call of the `newList` property on `Before Delete` or `After Delete` trigger events.
    2. Call of the `newMap` property on `Before Insert`, `Before Delete` or `After Delete` trigger events.
    3. Call of the `oldList` property on `Before Insert`, `After Insert` or `After Undelete` trigger events.
    4. Call of the `oldMap` property on `Before Insert`, `After Insert` or `After Undelete` trigger events.

## Usage
First, create an Apex trigger for sObject:
```java  
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
```

Then, extend the base **TriggerHandler** class and create a trigger handler for your sObject:
```java
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
}
```

Finally, define the handler with the next pattern:
```java
public class AccountTriggerHandlerMethodBeforeInsert implements TriggerHandler.BeforeInsertHandlerMethod {
    public void execute(List<SObject> newList) {
        // put your logic here...
    }
}
```

... and register it in the Custom metadata by creating the correspondent **Trigger_Handler_Method__mdt** record:
![image](https://user-images.githubusercontent.com/23140402/80317415-5a0ce100-880c-11ea-9cdb-7f5c4f6a8239.png)

## List of Interfaces
#### TriggerHandler.BeforeInsertHandlerMethod
```java
public interface BeforeInsertHandlerMethod {
    void execute(List<SObject> newList);
}
```

#### TriggerHandler.AfterInsertHandlerMethod
```java
public interface AfterInsertHandlerMethod {
    void execute(List<SObject> newList);
}
```

#### TriggerHandler.BeforeUpdateHandlerMethod
```java
public interface BeforeUpdateHandlerMethod {
    void execute(List<SObject> newList, List<SObject> oldList);
}
```

#### TriggerHandler.AfterUpdateHandlerMethod
```java
public interface AfterUpdateHandlerMethod {
    void execute(List<SObject> newList, List<SObject> oldList);
}
```

#### TriggerHandler.BeforeDeleteHandlerMethod
```java
public interface BeforeDeleteHandlerMethod {
    void execute(List<SObject> oldList);
}
```

#### TriggerHandler.AfterDeleteHandlerMethod
```java
public interface AfterDeleteHandlerMethod {
    void execute(List<SObject> oldList);
}
```

#### TriggerHandler.AfterUndeleteHandlerMethod
```java
public interface AfterUndeleteHandlerMethod {
    void execute(List<SObject> newList);
}
```

## List of TriggerHandler overridable methods
Also, you can directly define all your logic in your sObject trigger handler just overriding the next methods

* `beforeInsert()`
* `beforeUpdate()`
* `beforeDelete()`
* `afterInsert()`
* `afterUpdate()`
* `afterDelete()`
* `afterUndelete()`

But keep in mind - your method overrides must include base class method call, also your overriden functionality will be executed after all declarative handler methods.
```java
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

        // put your overriden logic here...
    }
}
```
## References
The idea of this framework was based on the main concepts of [TDTM](https://powerofus.force.com/s/article/EDA-TDTM-Overview "TDTM Overview") framework and Kevin O'Hara`s [sfdc-trigger-framework](https://github.com/kevinohara80/sfdc-trigger-framework "sfdc-trigger-framework").