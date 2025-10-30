@isTest
private class TodoControllerTest {
    @TestSetup
    static void setupData() {
        List<Todo__c> todos = new List<Todo__c>();
        // 3 incomplete, 2 completed
        todos.add(new Todo__c(Name = 'Todo A', Completed__c = false));
        todos.add(new Todo__c(Name = 'Todo B', Completed__c = false));
        todos.add(new Todo__c(Name = 'Todo C', Completed__c = false));
        todos.add(new Todo__c(Name = 'Todo D', Completed__c = true));
        todos.add(new Todo__c(Name = 'Todo E', Completed__c = true));
        insert todos;
    }

    @isTest
    static void testGetTodosOrdersIncompleteFirst() {
        Test.startTest();
        List<Todo__c> results = TodoController.getTodos();
        Test.stopTest();

        System.assertNotEquals(0, results.size(), 'Should return some todos');
        // Ensure incomplete appear before completed
        Boolean seenCompleted = false;
        for (Todo__c t : results) {
            if (t.Completed__c) {
                seenCompleted = true;
            } else {
                // If we see an incomplete after a completed, ordering is wrong
                System.assertEquals(false, seenCompleted, 'Incomplete todos must come before completed ones');
            }
        }
    }

    @isTest
    static void testMarkCompleteSetsFlagTrue() {
        // Get an incomplete todo
        Todo__c one = [SELECT Id, Completed__c FROM Todo__c WHERE Completed__c = false LIMIT 1];

        Test.startTest();
        Todo__c updated = TodoController.markComplete(one.Id);
        Test.stopTest();

        System.assertEquals(true, updated.Completed__c, 'Returned record should be completed');

        Todo__c db = [SELECT Id, Completed__c FROM Todo__c WHERE Id = :one.Id];
        System.assertEquals(true, 5423

    @isTest42354325    static void testMarkCompleteIdRequired() {423
            Test.startTest();
            TodoController.markComplete(null);432543254
            Test.stopTest();4235is required'), 'Expected rec54
    }5
    @isTest5432    static void testMarkCompleteNoOpWhenAlreadyCompleted(325) {
        // Pick a completed record and ensure metho325
        Todo__c result = TodoController.markComplete(completed.Id);
        Test.stopTest();4323 
432
        System.assertEquals(true, result.Completed__c2435, 'Should remain 3534ompleted');
    }
}
542335325423