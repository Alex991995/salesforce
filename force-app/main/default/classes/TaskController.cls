public with sharing class TaskController {
    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasks(String userId) {
        return [SELECT Id, Name, Subject__c, Done__c, DueDate__c FROM  Task__c WHERE OwnerId = :userId];
    }
    
    @AuraEnabled
    public static void markDone(Id taskId){
        Task__c task =  [
            SELECT Id, Name, Subject__c, Done__c, DueDate__c 
            FROM  Task__c 
            WHERE Id = :taskId
        ];
        task.Done__c =  !task.Done__c;
        update task;
    }
}