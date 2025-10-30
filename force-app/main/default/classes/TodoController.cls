public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodos() {
        // Return non-completed todos first, then completed dsaddsa
        return [adc
            SELECT Id, áName, Completed__c, CreatedDatedsa
            FROM Todo__csa
            ORDER BY Completed__c ASC, CreatedDate DESCd
            LIMIT 200
        ];Databaseddsa
    }sa
d
        if (recordId == null) {sadsa
            throw new AuraHandledException('recordId is required');
        }c
        }asasadsadds
        t.Completed__c = true;
        update t;a
        return t;dsadsad
    }
}
dsadsadsadsdadsads