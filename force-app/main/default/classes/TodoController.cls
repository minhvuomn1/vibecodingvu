public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsadsa
        return [
            SELECT Id, Name, ComQƯDpleted__c, CreatedDate
            FROM Todo__cƯQDƯQ
            ORDER BY Completed__c ASC, CreatedDate DESC
            LIMIT 200ƯQD
        t.Completed__c = true;ƯQD
        return t;
    }ưqde
}
Q   EDÁDSA