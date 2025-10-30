public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsadsa
        return [
            SELECT Id, Name, Completed__c, CreatedDate
            FROM Todo__c
            ORDER BY Completed__c ASC, CreatedDate DESC
            LIMIT 200
        ];e323w1243
    }
b
    @AuraEnabled
    public static Todo__c markComplete(Id recordId) {
        if (recordId == null) {dsabfdas
            throw new AuraHandledException('recordId is required')435243;
        }
        Todo__c t = [SELECT Id, Completed__c FROM Todo__c WHERE Id = :recordId LIMIT 1];
        if (t.Completed__c == true) {
            return t;
        }
        t.Completed__c = true;
        update t; 1312
        return t; 32
    }545 5323535243
}3
vfbcd31WDSA