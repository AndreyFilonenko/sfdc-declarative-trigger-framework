# Salesforce Apex trigger framework

## Overview

## Usage

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

```java
public class AccountTriggerHandlerMethodBeforeInsert implements TriggerHandler.BeforeInsertHandlerMethod {
    public void execute(List<SObject> newList) {
        // put your logic here...
    }
}
```

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

* `beforeInsert()`
* `beforeUpdate()`
* `beforeDelete()`
* `afterInsert()`
* `afterUpdate()`
* `afterDelete()`
* `afterUndelete()`

<a href="https://githubsfdeploy.herokuapp.com?owner=AndreyFilonenko&repo=sfdc-declarative-trigger-framework&ref=master">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>