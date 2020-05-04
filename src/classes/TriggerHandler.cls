public virtual class TriggerHandler {
    @TestVisible
    private System.TriggerOperation triggerOperation;
    @TestVisible
    private TriggerHandlerMetadataProvider metadataProvider = new TriggerHandlerMetadataProvider();
    private String triggerHandlerName;
    private Trigger_Handler_Settings__mdt triggerHandlerSettings;

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
        if (isTriggerEnabled()) {
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
    }

    @TestVisible
    protected virtual void beforeInsert() {
        executeHandlerMethods(this.triggerOperation.name(), this.newList, null);
    }

    @TestVisible
    protected virtual void afterInsert() {
        executeHandlerMethods(this.triggerOperation.name(), this.newList, null);
    }

    @TestVisible
    protected virtual void beforeUpdate() {
        executeHandlerMethods(this.triggerOperation.name(), this.newList, this.oldList);
    }

    @TestVisible
    protected virtual void afterUpdate() {
        executeHandlerMethods(this.triggerOperation.name(), this.newList, this.oldList);
    }

    @TestVisible
    protected virtual void beforeDelete() {
        executeHandlerMethods(this.triggerOperation.name(), null, this.oldList);
    }

    @TestVisible
    protected virtual void afterDelete() {
        executeHandlerMethods(this.triggerOperation.name(), null, this.oldList);
    }

    @TestVisible
    protected virtual void afterUndelete() {
        executeHandlerMethods(this.triggerOperation.name(), this.newList, null);
    }

    private Boolean isTriggerEnabled() {
        Boolean isTriggerEnabled = true;
        List<Trigger_Handler_Settings__mdt> handlerSettings = this.metadataProvider.getHandlerSettings(this.triggerHandlerName);
        if (!handlerSettings.isEmpty()) {
            isTriggerEnabled = false;
            Trigger_Handler_Settings__mdt currentHandlerSettings = handlerSettings.get(0);
            if (currentHandlerSettings.Is_Globally_Enabled__c) {
                isTriggerEnabled = true;
                switch on this.triggerOperation {
                    when BEFORE_INSERT {
                        isTriggerEnabled = currentHandlerSettings.Is_Before_Insert_Enabled__c;
                    }
                    when AFTER_INSERT {
                        isTriggerEnabled = currentHandlerSettings.Is_After_Insert_Enabled__c;
                    }
                    when BEFORE_UPDATE {
                        isTriggerEnabled = currentHandlerSettings.Is_Before_Update_Enabled__c;
                    }
                    when AFTER_UPDATE {
                        isTriggerEnabled = currentHandlerSettings.Is_After_Update_Enabled__c;
                    }
                    when BEFORE_DELETE {
                        isTriggerEnabled = currentHandlerSettings.Is_Before_Delete_Enabled__c;
                    }
                    when AFTER_DELETE {
                        isTriggerEnabled = currentHandlerSettings.Is_After_Delete_Enabled__c;
                    }
                    when AFTER_UNDELETE {
                        isTriggerEnabled = currentHandlerSettings.Is_After_Undelete_Enabled__c;
                    }
                }
            }
        }
        
        return isTriggerEnabled;
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

    private void executeHandlerMethods(String context, List<sObject> newList, List<sObject> oldList) {
        List<String> handlerMethodNames = getHandlerMethodNames();
        
        if (!handlerMethodNames.isEmpty()) {
            for (Integer i = 0; i < handlerMethodNames.size(); i++) {
                if (Type.forName(handlerMethodNames[i]) != null) {
                    Map<String, Object> argsMap = new Map<String, Object>();
                    if (newList != null) {
                        argsMap.put('newList', newList);
                    }                    
                    if (oldList != null) {
                        argsMap.put('oldList', oldList);
                    }

                    Type handlerMethodType = Type.forName(handlerMethodNames[i]);
                    Callable currentHandlerMethod = (Callable)handlerMethodType.newInstance();
                    currentHandlerMethod.call(context, argsMap);
                }
            }
        }
    }

    public class TriggerHandlerException extends Exception {}

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