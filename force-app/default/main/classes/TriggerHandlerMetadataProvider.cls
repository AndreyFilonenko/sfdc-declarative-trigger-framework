public class TriggerHandlerMetadataProvider {
    public List<Trigger_Handler_Method__mdt> getHandlerMethods(String triggerHandlerName,
                                                               System.TriggerOperation triggerOperation) {
        return [
            SELECT Id,
                   DeveloperName,
                   Order_of_execution__c
            FROM Trigger_Handler_Method__mdt
            WHERE Trigger_Handler_Name__c = :triggerHandlerName
            AND Trigger_Event_Type__c = :triggerOperation.name()
            AND Is_Enabled__c = true
        ];
    }

    public List<Trigger_Handler_Settings__mdt> getHandlerSettings(String triggerHandlerName) {
        return [
            SELECT Id,
                   Is_Globally_Enabled__c,
                   Is_Before_Insert_Enabled__c,
                   Is_After_Insert_Enabled__c,
                   Is_Before_Update_Enabled__c,
                   Is_After_Update_Enabled__c,
                   Is_Before_Delete_Enabled__c,
                   Is_After_Delete_Enabled__c,
                   Is_After_Undelete_Enabled__c
            FROM Trigger_Handler_Settings__mdt
            WHERE DeveloperName = :triggerHandlerName
        ];
    }
}