# Salesforce Apex trigger framework

## Example of usage

1. First, define the settings for AccountTriggerHandler:
![image](https://user-images.githubusercontent.com/23140402/81467999-39b62c80-91e5-11ea-9884-51f8668186f5.png)

2. Lets choose beforeInsert and afterInsert methods of AccountTriggerHandler as the targets of test. Also, override the beforeInsert by adding a debug statement:
```java  
public class AccountTriggerHandler extends TriggerHandler {
    ...
    public override void beforeInsert() {
        super.beforeInsert();

        System.debug('Overriden beforeInsert method executed!');
    }
}
```
3. Next, add some handlers:
```java  
public class AccountTriggerHandlerMethod_1 implements Callable {
    public Object call(String action, Map<String, Object> args) {
        List<Account> accounts = (List<Account>)args.get('newList');
        System.debug('AccountTriggerHandlerMethod_1 class executed! ' + accounts.size() + ' records passed. - Should be the first method called');
        return null;
    }
}

public class AccountTriggerHandlerMethod_2 implements Callable {
    public Object call(String action, Map<String, Object> args) {
        List<Account> accounts = (List<Account>)args.get('newList');
        System.debug('AccountTriggerHandlerMethod_2 class executed! ' + accounts.size() + ' records passed.');
        return null;
    }
}

public class AccountTriggerHandlerMethod_3 implements Callable {
    public Object call(String action, Map<String, Object> args) {
        List<Account> accounts = (List<Account>)args.get('newList');
        System.debug('AccountTriggerHandlerMethod_3 class executed! ' + accounts.size() + ' records passed. - Should be the last method called (before all overrides)');
        return null;
    }
}

public class AccountTriggerHandlerMethod_4 implements Callable {
    public Object call(String action, Map<String, Object> args) {
        List<Account> accounts = (List<Account>)args.get('newList');
        System.debug('AccountTriggerHandlerMethod_4 class executed! ' + accounts.size() + ' records passed.');
        return null;
    }
}

public class AccountTriggerHandlerMethod_5 implements Callable {
    public Object call(String action, Map<String, Object> args) {
        List<Account> accounts = (List<Account>)args.get('newList');
        System.debug('AccountTriggerHandlerMethod_5 class executed! ' + accounts.size() + ' records passed.');
        return null;
    }
}
```
4. ...and register them as handlers in Custom metadata:
![image](https://user-images.githubusercontent.com/23140402/80419812-78dda700-88e2-11ea-9403-80765621a738.png)

5. To trigger the test just execute this in anonymous:
```java  
Account acc = new Account();
acc.Name = 'Test';
insert acc;
```

6. The results are below:
![image](https://user-images.githubusercontent.com/23140402/80420104-ec7fb400-88e2-11ea-8cf2-a99bfa2bc53b.png)

#### All needed classes and example handlers are included in this branch and can be used for other tests.