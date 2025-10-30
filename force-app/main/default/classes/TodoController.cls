public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsadsa
        return [
            SELECT Id, Name, Completed__c, CreatedDatedsad
            FROM Todo__cadsa
            ORDER BY Completed__c ASC, CreatedDate DESCsads
            LIMIT 200đá
        ];
    }
đasa
    @AuraEnabled
    public static Todo__c markComplete(Id recordId) {
        if (recordId == null) {
            throw new AuraHandledException('recordId is required');
        }dsadsa
        Todo__c t = [SELECT Id, Completed__c FROM Todo__c WHERE Id = :recordId LIMIT 1];
        if (t.Completed__c == true) {
            return t;
        }
        t.Completed__c = true;
        update t;
        return t;
    }
}
dsaadsadsadsa