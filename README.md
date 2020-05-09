# Salesforce Apex trigger framework

[![CircleCI](https://circleci.com/gh/AndreyFilonenko/sfdc-declarative-trigger-framework.svg?style=svg)](https://circleci.com/gh/AndreyFilonenko/sfdc-declarative-trigger-framework) [![codecov](https://codecov.io/gh/AndreyFilonenko/sfdc-declarative-trigger-framework/branch/master/graph/badge.svg)](https://codecov.io/gh/AndreyFilonenko/sfdc-declarative-trigger-framework)

<a href="https://githubsfdeploy.herokuapp.com?owner=AndreyFilonenko&repo=sfdc-declarative-trigger-framework&ref=master">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## Overview
A simple and minimal framework for Salesforce Apex triggers with declarative trigger handlers management - in accordance with Salesforce development best practices, defines a single entry point for sObject trigger with dispatching handler functions by a specific trigger event. Also gives an ability to manage trigger handlers with the no-code approach, just managing custom metadata definitions via point and clicks.


There are three main blocks of functionality:
* Trigger handler backbone with event handlers and dispatcher logic.
* Trigger enablement logic, which allows you to disable the trigger hanler globally or by for a specific event (optionally).
* Trigger handler logic management for determining the handlers and order of their execution for specific event (optionally).


## *TriggerHandler* public API
#### Properties:
* `List<SObject> newList` - readonly, returns the Trigger.new records.
* `Map<Id, SObject> newMap` - readonly, returns the Trigger.newMap records.
* `List<SObject> oldList` - readonly, returns the Trigger.old records.
* `Map<Id, SObject> oldMap` - readonly, returns the Trigger.oldMap records.
* `Integer size` - readonly, returns the quantity of trigger records.

#### Exceptions
* `TriggerHandlerException` - will be thrown in the next cases:
    1. Call of the `newList` property on `Before Delete` or `After Delete` trigger events.
    2. Call of the `newMap` property on `Before Insert`, `Before Delete` or `After Delete` trigger events.
    3. Call of the `oldList` property on `Before Insert`, `After Insert` or `After Undelete` trigger events.
    4. Call of the `oldMap` property on `Before Insert`, `After Insert` or `After Undelete` trigger events.

#### Overridable methods
Also, you can directly define all your logic in your sObject trigger handler just overriding the next methods:

* `beforeInsert()`
* `beforeUpdate()`
* `beforeDelete()`
* `afterInsert()`
* `afterUpdate()`
* `afterDelete()`
* `afterUndelete()`

But keep in mind - to prevent blocking of other features your method overrides must include base class method call, also your overriden functionality will be executed after all declarative handler methods ([see here](#Override-example)).

## Usage
### Main functionality
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

Finally, override the base methods with logic you need:
###### Override example
```java
public class AccountTriggerHandler extends TriggerHandler {
    ...

    public override void beforeInsert() {
        // base method call
        super.beforeInsert();

        // put your overriden logic here...
    }
}
```
### Trigger enablement management (optionally)
Create a **Trigger_Handler_Settings__mdt** record to describe the sObject trigger behavior globally or on the specific event:
![image](https://user-images.githubusercontent.com/23140402/81047299-cf3e7d00-8ec2-11ea-9ba0-1990d573fa88.png)
By default the trigger handler enabled globally with all events.

### Trigger handlers management (optionally)
Define the handler with the next pattern (implement the [Callable interface](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_interface_System_Callable.htm)):
```java

public class AccountTriggerHandlerMethodBeforeInsert implements Callable {
    /** 
     * See possible params values below:
     * @param action - will contain the string name of TriggerOperation enum value for the current context
     * @param args - will contain a map of Trigger props with the prop names as keys
     *               For example, you can retrieve newList by the key 'newList' for BEFORE_INSERT event handler
     */
    Object call(String action, Map<String, Object> args) {
        // put your logic here...
    }
}
```

... and register it in the Custom metadata by creating the correspondent **Trigger_Handler_Method__mdt** record:
![image](https://user-images.githubusercontent.com/23140402/80317415-5a0ce100-880c-11ea-9cdb-7f5c4f6a8239.png)

#### Please see the detailed example of the usage [here!](https://github.com/AndreyFilonenko/sfdc-declarative-trigger-framework/tree/example-of-usage)

## Change log
Please see [CHANGELOG](CHANGELOG.md) for more information what has changed recently.

## References
The idea of this framework was based on the main concepts of [TDTM](https://powerofus.force.com/s/article/EDA-TDTM-Overview "TDTM Overview") framework and Kevin O'Hara`s [sfdc-trigger-framework](https://github.com/kevinohara80/sfdc-trigger-framework "sfdc-trigger-framework").

## License
The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
