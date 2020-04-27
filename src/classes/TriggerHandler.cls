public virtual class TriggerHandler {
    @TestVisible
    private System.TriggerOperation triggerOperation;
    @TestVisible
    private TriggerHandlerMetadataProvider metadataProvider = new TriggerHandlerMetadataProvider();
    private String triggerHandlerName;

    protected TriggerHandler(System.TriggerOperation triggerOperation,
                             List<SObject> newList,
                             Map<Id, SObject> newMap,
                             List<SObject> oldList,
                             Map<Id, SObject> oldMap,
                             Integer size) {
        this.triggerOperation = triggerOperation;
        this.newList = newList;
        this.newMap = newMap;
        this.oldList = oldList;
        this.oldMap = oldMap;
        this.size = size;
        this.triggerHandlerName = String.valueOf(this).substring(0, String.valueOf(this).indexOf(':'));
    }

    @testVisible
    protected List<SObject> newList {
        get {
            if (triggerOperation == System.TriggerOperation.BEFORE_DELETE ||
                triggerOperation == System.TriggerOperation.AFTER_DELETE) {
                throw new TriggerHandlerException('Trigger.new is not available for current operation: ' + triggerOperation.name());
            }
            return this.newList;
        }
        private set;
    }

    @testVisible
    protected Map<Id, SObject> newMap {
        get {
            if (triggerOperation == System.TriggerOperation.BEFORE_INSERT ||
                triggerOperation == System.TriggerOperation.BEFORE_DELETE ||
                triggerOperation == System.TriggerOperation.AFTER_DELETE) {
                throw new TriggerHandlerException('Trigger.newMap is not available for current operation: ' + triggerOperation.name());
            }
            return this.newMap;
        }
        private set;
    }

    @testVisible
    protected List<SObject> oldList {
        get {
            if (triggerOperation == System.TriggerOperation.BEFORE_INSERT ||
                triggerOperation == System.TriggerOperation.AFTER_INSERT ||
                triggerOperation == System.TriggerOperation.AFTER_UNDELETE) {
                throw new TriggerHandlerException('Trigger.old is not available for current operation: ' + triggerOperation.name());
            }
            return this.oldList;
        }
        private set;
    }

    @testVisible
    protected Map<Id, SObject> oldMap {
        get {
            if (triggerOperation == System.TriggerOperation.BEFORE_INSERT ||
                triggerOperation == System.TriggerOperation.AFTER_INSERT ||
                triggerOperation == System.TriggerOperation.AFTER_UNDELETE) {
                throw new TriggerHandlerException('Trigger.oldMap is not available for current operation: ' + triggerOperation.name());
            }
            return this.oldMap;
        }
        private set;
    }

    @testVisible
    protected Integer size { protected get; private set; }

    public void dispatch() {
        switch on this.triggerOperation {
            when BEFORE_INSERT {
                this.beforeInsert();
            }
            when AFTER_INSERT {
                this.afterInsert();
            }
            when BEFORE_UPDATE {
                this.beforeUpdate();
            }
            when AFTER_UPDATE {
                this.afterUpdate();
            }
            when BEFORE_DELETE {
                this.beforeDelete();
            }
            when AFTER_DELETE {
                this.afterDelete();
            }
            when AFTER_UNDELETE {
                this.afterUndelete();
            }
        }
    }

    @TestVisible
    protected virtual void beforeInsert() {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Type t = Type.forName(handlerMethodNames[i]);
                    BeforeInsertHandlerMethod currentHandlerMethod = (BeforeInsertHandlerMethod)t.newInstance();
                    currentHandlerMethod.execute(this.newList);
                }
            }
        }
    }

    @TestVisible
    protected virtual void afterInsert() {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Type t = Type.forName(handlerMethodNames[i]);
                    AfterInsertHandlerMethod currentHandlerMethod = (AfterInsertHandlerMethod)t.newInstance();
                    currentHandlerMethod.execute(this.newList);
                }
            }
        }
    }

    @TestVisible
    protected virtual void beforeUpdate() {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Type t = Type.forName(handlerMethodNames[i]);
                    BeforeUpdateHandlerMethod currentHandlerMethod = (BeforeUpdateHandlerMethod)t.newInstance();
                    currentHandlerMethod.execute(this.newList, this.oldList);
                }
            }
        }
    }

    @TestVisible
    protected virtual void afterUpdate() {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Type t = Type.forName(handlerMethodNames[i]);
                    AfterUpdateHandlerMethod currentHandlerMethod = (AfterUpdateHandlerMethod)t.newInstance();
                    currentHandlerMethod.execute(this.newList, this.oldList);
                }
            }
        }
    }

    @TestVisible
    protected virtual void beforeDelete() {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Type t = Type.forName(handlerMethodNames[i]);
                    BeforeDeleteHandlerMethod currentHandlerMethod = (BeforeDeleteHandlerMethod)t.newInstance();
                    currentHandlerMethod.execute(this.oldList);
                }
            }
        }
    }

    @TestVisible
    protected virtual void afterDelete() {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Type t = Type.forName(handlerMethodNames[i]);
                    AfterDeleteHandlerMethod currentHandlerMethod = (AfterDeleteHandlerMethod)t.newInstance();
                    currentHandlerMethod.execute(this.oldList);
                }
            }
        }
    }

    @TestVisible
    protected virtual void afterUndelete() {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Type t = Type.forName(handlerMethodNames[i]);
                    AfterUndeleteHandlerMethod currentHandlerMethod = (AfterUndeleteHandlerMethod)t.newInstance();
                    currentHandlerMethod.execute(this.newList);
                }
            }
        }
    }

    private List<String> getHandlerMethodNames() {
        List<Trigger_Handler_Method__mdt> handlerMethods = this.metadataProvider.getHandlerMethods(this.triggerHandlerName, this.triggerOperation);
        List<TriggerHandlerMethodWrapper> handlerMethodWrappers = new List<TriggerHandlerMethodWrapper>();
        for (Trigger_Handler_Method__mdt handlerMethod : handlerMethods) {
            handlerMethodWrappers.add(new TriggerHandlerMethodWrapper(
                handlerMethod.DeveloperName,
                handlerMethod.Order_of_execution__c
            ));
        }

        handlerMethodWrappers.sort();

        List<String> handlerMethodNames = new List<String>();
        for (Integer i = 0; i < handlerMethodWrappers.size(); i++) {
            handlerMethodNames.add(handlerMethodWrappers[i].handlerMethodName);
        }
        
        return handlerMethodNames;
    }

    public class TriggerHandlerException extends Exception {}

    public interface BeforeInsertHandlerMethod {
        void execute(List<SObject> newList);
    }

    public interface AfterInsertHandlerMethod {
        void execute(List<SObject> newList);
    }

    public interface BeforeUpdateHandlerMethod {
        void execute(List<SObject> newList, List<SObject> oldList);
    }

    public interface AfterUpdateHandlerMethod {
        void execute(List<SObject> newList, List<SObject> oldList);
    }

    public interface BeforeDeleteHandlerMethod {
        void execute(List<SObject> oldList);
    }

    public interface AfterDeleteHandlerMethod {
        void execute(List<SObject> oldList);
    }

    public interface AfterUndeleteHandlerMethod {
        void execute(List<SObject> newList);
    }

    private class TriggerHandlerMethodWrapper implements Comparable {
        TriggerHandlerMethodWrapper(String handlerMethodName, Decimal executionOrder) {
            this.handlerMethodName = handlerMethodName;
            this.executionOrder = Integer.valueOf(executionOrder);
        }

        public String handlerMethodName { get; private set; }
        public Integer executionOrder { get; private set; }

        public Integer compareTo(Object compareTo) {
            TriggerHandlerMethodWrapper compareToMethodWrapper = (TriggerHandlerMethodWrapper)compareTo;
            Integer returnValue = 0;
            if (executionOrder > compareToMethodWrapper.executionOrder) {
                returnValue = 1;
            } else if (executionOrder < compareToMethodWrapper.executionOrder) {
                returnValue = -1;
            }
            
            return returnValue;
        }
    }
}