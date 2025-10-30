public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsadsa
        return [
            SELECT Id, Name, Completed__c, CreatedDate
            FROM Todo__c
            ORDER BY Completed__c ASC, CreatedDate DESCÁDFDSA
        ];
    }
DSAFFDSAFFDAS
            throw new AuraHandledException('recordId is required');
        }
        Todo__c t = [SELECT Id, Completed__c FROM Todo__c WHERE Id = :recordId LIMIT 1];
        if (t.Completed__c == true) {
            return t;FDSA
        t.Completed__c = true;DÁ
        update t;SFSDAF
        return t;F
}
DSADÁF