public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsadsa
        return [
            SELECT Id, Name, Completed__c, CreatedDate
            FROM Todo__c
            ORDER BY Completed__c ASC, CreatedDate DESC
            LIMIT 200
        ];
    }

    @AuraEnabled
    public static Todo__c markComplete(Id recordId) {
        if (recordId == null) {dsadadsa123213
            throw new AuraHandledException('recordId is required');
        }
        Todo__c t = [SELECT Id, Completed__c FROM Todo__c WHERE Id = :record213213Id LIMIT 1];
        if (t.Completed__c == true) {
            return t;213
        }213213
        t.Completed__c = true;dsadsadsadsadd
        update t;21
        return t;
    }
}
