@isTest
public class TaskControllerTest {
  @TestSetup
  static void setup() {
    List<Task__c> testTasks = new List<Task__c>();
    for (Integer i = 0; i < 5; i++) {
      testTasks.add(
        new Task__c(
          Name = 'Тестовая задача ' + i,
          Subject__c = 'Описание ' + i,
          Done__c = false,
          DueDate__c = Date.today().addDays(i),
          OwnerId = UserInfo.getUserId()
        )
      );
    }
    insert testTasks;
  }
  @isTest
  static void getTasks_Test() {
    String id = UserInfo.getUserId();
    Test.startTest();
    List<Task__c> testTasks = TaskController.getTasks(id);
    Test.stopTest();

    Assert.areEqual(5, testTasks.size());
    for (Task__c t : testTasks) {
      Assert.areEqual(UserInfo.getUserId(), t.OwnerId);
      Assert.isFalse(t.Done__c);
    }
  }

  @isTest
  static void markDone_Test() {
    Task__c firstTask = [
      SELECT Id, Name, Subject__c, Done__c, DueDate__c, OwnerId
      FROM Task__c
      WHERE OwnerId = :UserInfo.getUserId()
      LIMIT 1
    ];

    Test.startTest();
    TaskController.markDone(firstTask.Id);
    Test.stopTest();

    Task__c updatedTask = [
      SELECT Id, Name, Subject__c, Done__c, DueDate__c, OwnerId
      FROM Task__c
      WHERE Id = :firstTask.Id
    ];
    Assert.isTrue(updatedTask.Done__c);
  }
}
