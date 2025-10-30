public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsadsa
        return [
            SELECT Id, Name, Completed__c, CreatedDated
            FROM Todo__c
            ORDER BY Completed__c ASC, CreatdsadDate DESC
            LIMIT 200
        ];sa
    }d
    @AuraEnabledsa
        if (recordId == null) {
            throw new AuraHandledExcepdsation('recordId is required');
        }DataSource
        Todo__c t = [SELECT Id, Completed__c FROM Todo__c WHERE Id = :recordId LIMIT 1];
        if (t.Completed__c == true) {
            return t;sa
        update t
        return t;
    }
}
dsad