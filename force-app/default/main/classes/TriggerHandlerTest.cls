@isTest
public class TriggerHandlerTest {
    private static final String TRIGGER_HANDLER_NAME = 'TestTriggerHandler';
    private static String lastMethodCalled;
    private static TriggerHandlerTest.TestTriggerHandler handler = new TriggerHandlerTest.TestTriggerHandler();

    @isTest
    private static void testPropertyNewList() {
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
    private static void testPropertyNewMap() {
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
    private static void testPropertyOldList() {
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
    private static void testPropertyOldMap() {
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
    private static void testPropertySize() {
        Integer size = handler.size;
        System.assertEquals(10, size);
    }

    @isTest
    private static void testDispatch() {
        handler.triggerOperation = System.TriggerOperation.AFTER_UNDELETE;

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals(null, lastMethodCalled);
    }

    @isTest
    private static void testBeforeInsert() {
        handler.triggerOperation = System.TriggerOperation.BEFORE_INSERT;
        handler.metadataProvider = (TriggerHandlerMetadataProvider)Test.createStub(
            TriggerHandlerMetadataProvider.class,
            new TriggerHandlerMetadataProviderStub()
        );

        Test.startTest();
        handler.dispatch();
        Test.stopTest();

        System.assertEquals('beforeInsert3', lastMethodCalled);
    }

    @isTest
    private static void testAfterInsert() {
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
    private static void testBeforeUpdate() {
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
    private static void testAfterUpdate() {
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
    private static void testBeforeDelete() {
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
    private static void testAfterDelete() {
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
    private static void testAfterUndelete() {
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
            Object returnObject;
            switch on stubbedMethodName {
                when 'getHandlerMethods' {
                    returnObject = getHandlerMethodsStub((System.TriggerOperation)listOfArgs[1]);
                }
                when 'getHandlerSettings' {
                    returnObject = getHandlerSettingsStub();
                }
                when else {
                    returnObject = null;
                }
            }
            return returnObject;
        }

        private List<Trigger_Handler_Method__mdt> getHandlerMethodsStub(System.TriggerOperation triggerOperation) {
            List<Trigger_Handler_Method__mdt> testTriggerHandlerMethods = new List<Trigger_Handler_Method__mdt>();
            if (triggerOperation == System.TriggerOperation.BEFORE_INSERT) {
                Trigger_Handler_Method__mdt testHandlerMethod1 = new Trigger_Handler_Method__mdt();
                testHandlerMethod1.DeveloperName = 'TriggerHandlerTest.' + TRIGGER_HANDLER_NAME + triggerOperation.name() + '2';
                testHandlerMethod1.Is_Enabled__c = true;
                testHandlerMethod1.Order_of_execution__c = 2;
                testHandlerMethod1.Trigger_Event_Type__c = triggerOperation.name();
                testHandlerMethod1.Trigger_Handler_Name__c = TRIGGER_HANDLER_NAME;
                testTriggerHandlerMethods.add(testHandlerMethod1);

                Trigger_Handler_Method__mdt testHandlerMethod2 = new Trigger_Handler_Method__mdt();
                testHandlerMethod2.DeveloperName = 'TriggerHandlerTest.' + TRIGGER_HANDLER_NAME + triggerOperation.name() + '1';
                testHandlerMethod2.Is_Enabled__c = true;
                testHandlerMethod2.Order_of_execution__c = 1;
                testHandlerMethod2.Trigger_Event_Type__c = triggerOperation.name();
                testHandlerMethod2.Trigger_Handler_Name__c = TRIGGER_HANDLER_NAME;
                testTriggerHandlerMethods.add(testHandlerMethod2);

                Trigger_Handler_Method__mdt testHandlerMethod3 = new Trigger_Handler_Method__mdt();
                testHandlerMethod3.DeveloperName = 'TriggerHandlerTest.' + TRIGGER_HANDLER_NAME + triggerOperation.name() + '3';
                testHandlerMethod3.Is_Enabled__c = true;
                testHandlerMethod3.Order_of_execution__c = 3;
                testHandlerMethod3.Trigger_Event_Type__c = triggerOperation.name();
                testHandlerMethod3.Trigger_Handler_Name__c = TRIGGER_HANDLER_NAME;
                testTriggerHandlerMethods.add(testHandlerMethod3);
            } else {
                Trigger_Handler_Method__mdt testHandlerMethod = new Trigger_Handler_Method__mdt();
                testHandlerMethod.DeveloperName = 'TriggerHandlerTest.' + TRIGGER_HANDLER_NAME + triggerOperation.name();
                testHandlerMethod.Is_Enabled__c = true;
                testHandlerMethod.Order_of_execution__c = 1;
                testHandlerMethod.Trigger_Event_Type__c = triggerOperation.name();
                testHandlerMethod.Trigger_Handler_Name__c = TRIGGER_HANDLER_NAME;
                testTriggerHandlerMethods.add(testHandlerMethod);
            }
            return testTriggerHandlerMethods;
        }

        private List<Trigger_Handler_Settings__mdt> getHandlerSettingsStub() {
            return new List<Trigger_Handler_Settings__mdt> {
                new Trigger_Handler_Settings__mdt(
                    DeveloperName = TRIGGER_HANDLER_NAME,
                    Is_Globally_Enabled__c = true,
                    Is_Before_Insert_Enabled__c = true,
                    Is_After_Insert_Enabled__c = true,
                    Is_Before_Update_Enabled__c = true,
                    Is_After_Update_Enabled__c = true,
                    Is_Before_Delete_Enabled__c = true,
                    Is_After_Delete_Enabled__c = true,
                    Is_After_Undelete_Enabled__c = true
                )
            };
        }
    }

    public class TestTriggerHandlerBEFORE_INSERT1 implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'beforeInsert1';
            return null;
        }
    }
    
    public class TestTriggerHandlerBEFORE_INSERT2 implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'beforeInsert2';
            return null;
        }
    }
    
    public class TestTriggerHandlerBEFORE_INSERT3 implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'beforeInsert3';
            return null;
        }
    }

    public class TestTriggerHandlerAFTER_INSERT implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'afterInsert';
            return null;
        }
    }

    public class TestTriggerHandlerBEFORE_UPDATE implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'beforeUpdate';
            return null;
        }
    }

    public class TestTriggerHandlerAFTER_UPDATE implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'afterUpdate';
            return null;
        }
    }

    public class TestTriggerHandlerBEFORE_DELETE implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'beforeDelete';
            return null;
        }
    }

    public class TestTriggerHandlerAFTER_DELETE implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'afterDelete';
            return null;
        }
    }

    public class TestTriggerHandlerAFTER_UNDELETE implements Callable {
        public Object call(String action, Map<String, Object> args) {
            TriggerHandlerTest.lastMethodCalled = 'afterUndelete';
            return null;
        }
    }
}