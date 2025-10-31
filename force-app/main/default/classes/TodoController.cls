public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsadsa
        return [
            SELECT Id, Name, Completed__c, CreatedDate
            FROM Todo__c
            ORDER BY Completed__c ASC, CreatedDate DESC
            LIMIT 200
        ];sad
    }

    @AuraEnableddsadsa
    public static Todo__c markComplete(Id recordId) {
        if (recordId == null) {
            throw new AuraHandledException('recordId is required');
        }
        Todo__c t = [SELECT Id, Completed__c FROM Todo__c WHERE Id = :recordId LIMIT 1];
        if (t.Completed__c == true) {
            return t;
        }sa
        t.Completed__c = true;dsad
        update t;
        return t;
    }
}sad