public class TriggerHandlerMetadataProvider {
    public List<Trigger_Handler_Method__mdt> getHandlerMethods(String triggerHandlerName,
                                                               System.TriggerOperation triggerOperation) {
        return [
            SELECT Id,
                   DeveloperName
            FROM Trigger_Handler_Method__mdt
            WHERE Trigger_Handler_Name__c = :triggerHandlerName
            AND Trigger_Event_Type__c = :triggerOperation.name()
            AND Is_Enabled__c = true
            ORDER BY Order_of_execution__c
        ];
    }
}