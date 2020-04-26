@isTest
public class TriggerHandlerTest {
    private static final String TRIGGER_HANDLER_NAME = 'TestTriggerHandler';
    private static String lastMethodCalled;
    private static TriggerHandlerTest.TestTriggerHandler handler = new TriggerHandlerTest.TestTriggerHandler();

    @isTest
    static void testPropertyNewList() {
        List<SObject> newList;
        handler.triggerOperation = System.TriggerOperation.BEFORE_DELETE;
        try {
            newList = handler.newList;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.AFTER_DELETE;
        try {
            newList = handler.newList;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.BEFORE_INSERT;
        newList = handler.newList;        
        System.assertNotEquals(null, newList);
    }

    @isTest
    static void testPropertyNewMap() {
        Map<Id, SObject> newMap;
        handler.triggerOperation = System.TriggerOperation.BEFORE_INSERT;
        try {
            newMap = handler.newMap;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.BEFORE_DELETE;
        try {
            newMap = handler.newMap;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.AFTER_DELETE;
        try {
            newMap = handler.newMap;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.BEFORE_UPDATE;
        newMap = handler.newMap;        
        System.assertNotEquals(null, newMap);
    }

    @isTest
    static void testPropertyOldList() {
        List<SObject> oldList;
        handler.triggerOperation = System.TriggerOperation.BEFORE_INSERT;
        try {
            oldList = handler.oldList;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.AFTER_INSERT;
        try {
            oldList = handler.oldList;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }        

        handler.triggerOperation = System.TriggerOperation.AFTER_UNDELETE;
        try {
            oldList = handler.oldList;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.BEFORE_UPDATE;
        oldList = handler.oldList;        
        System.assertNotEquals(null, oldList);
    }

    @isTest
    static void testPropertyOldMap() {
        Map<Id, SObject> oldMap;
        handler.triggerOperation = System.TriggerOperation.BEFORE_INSERT;
        try {
            oldMap = handler.oldMap;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.AFTER_INSERT;
        try {
            oldMap = handler.oldMap;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.AFTER_UNDELETE;
        try {
            oldMap = handler.oldMap;
        } catch (TriggerHandler.TriggerHandlerException ex) {
            System.assertNotEquals(null, ex.getMessage());
        }

        handler.triggerOperation = System.TriggerOperation.BEFORE_UPDATE;
        oldMap = handler.oldMap;
        System.assertNotEquals(null, oldMap);
    }

    @isTest
    static void testPropertySize() {
        Integer size = handler.size;
        System.assertEquals(10, size);
    }

    @isTest
    static void testDispatch() {
        handler.triggerOperation = System.TriggerOperation.AFTER_UNDELETE;

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals(null, lastMethodCalled);
    }

    @isTest
    static void testBeforeInsert() {
        handler.triggerOperation = System.TriggerOperation.BEFORE_INSERT;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('beforeInsert', lastMethodCalled);
    }

    @isTest
    static void testAfterInsert() {
        handler.triggerOperation = System.TriggerOperation.AFTER_INSERT;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('afterInsert', lastMethodCalled);
    }

    @isTest
    static void testBeforeUpdate() {
        handler.triggerOperation = System.TriggerOperation.BEFORE_UPDATE;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('beforeUpdate', lastMethodCalled);
    }

    @isTest
    static void testAfterUpdate() {
        handler.triggerOperation = System.TriggerOperation.AFTER_UPDATE;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('afterUpdate', lastMethodCalled);
    }

    @isTest
    static void testBeforeDelete() {
        handler.triggerOperation = System.TriggerOperation.BEFORE_DELETE;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('beforeDelete', lastMethodCalled);
    }

    @isTest
    static void testAfterDelete() {
        handler.triggerOperation = System.TriggerOperation.AFTER_DELETE;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('afterDelete', lastMethodCalled);
    }

    @isTest
    static void testAfterUndelete() {
        handler.triggerOperation = System.TriggerOperation.AFTER_UNDELETE;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('afterUndelete', lastMethodCalled);
    }

    private class TestTriggerHandler extends TriggerHandler {
        public TestTriggerHandler() {
            super(
                null,
                new List<SObject>(),
                new Map<Id, SObject>(),
                new List<SObject>(),
                new Map<Id, SObject>(),
                10
            );
        }
    }

    private class TriggerHandlerMetadataProviderStub implements System.StubProvider {
        public Object handleMethodCall(Object stubbedObject,
                                       String stubbedMethodName,
                                       Type returnType,
                                       List<Type> listOfParamTypes,
                                       List<String> listOfParamNames, 
                                       List<Object> listOfArgs) {
            System.TriggerOperation triggerOperation = (System.TriggerOperation)listOfArgs[1];
            Trigger_Handler_Method__mdt testHandlerMethod = new Trigger_Handler_Method__mdt();
            testHandlerMethod.DeveloperName = 'TriggerHandlerTest.' + TRIGGER_HANDLER_NAME + triggerOperation.name();
            testHandlerMethod.Is_Enabled__c = true;
            testHandlerMethod.Order_of_execution__c = 1;
            testHandlerMethod.Trigger_Event_Type__c = triggerOperation.name();
            testHandlerMethod.Trigger_Handler_Name__c = TRIGGER_HANDLER_NAME;
            return new List<Trigger_Handler_Method__mdt> { testHandlerMethod };
        }
    }

    public class TestTriggerHandlerBEFORE_INSERT implements TriggerHandler.BeforeInsertHandlerMethod {
        public void execute(List<SObject> newList) {
            TriggerHandlerTest.lastMethodCalled = 'beforeInsert';
        }
    }

    public class TestTriggerHandlerAFTER_INSERT implements TriggerHandler.AfterInsertHandlerMethod {
        public void execute(List<SObject> newList) {
            TriggerHandlerTest.lastMethodCalled = 'afterInsert';
        }
    }

    public class TestTriggerHandlerBEFORE_UPDATE implements TriggerHandler.BeforeUpdateHandlerMethod {
        public void execute(List<SObject> newList, List<SObject> oldList) {
            TriggerHandlerTest.lastMethodCalled = 'beforeUpdate';
        }
    }

    public class TestTriggerHandlerAFTER_UPDATE implements TriggerHandler.AfterUpdateHandlerMethod {
        public void execute(List<SObject> newList, List<SObject> oldList) {
            TriggerHandlerTest.lastMethodCalled = 'afterUpdate';
        }
    }

    public class TestTriggerHandlerBEFORE_DELETE implements TriggerHandler.BeforeDeleteHandlerMethod {
        public void execute(List<SObject> oldList) {
            TriggerHandlerTest.lastMethodCalled = 'beforeDelete';
        }
    }

    public class TestTriggerHandlerAFTER_DELETE implements TriggerHandler.AfterDeleteHandlerMethod {
        public void execute(List<SObject> oldList) {
            TriggerHandlerTest.lastMethodCalled = 'afterDelete';
        }
    }

    public class TestTriggerHandlerAFTER_UNDELETE implements TriggerHandler.AfterUndeleteHandlerMethod {
        public void execute(List<SObject> newList) {
            TriggerHandlerTest.lastMethodCalled = 'afterUndelete';
        }
    }
}