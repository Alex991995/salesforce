@IsTest
public class StudentControllerTest {
  @TestSetup
  static void setup() {
    List<Student__c> testStudents = new List<Student__c>();

    testStudents.add(new Student__c(Name = 'Женя Иванов', Score__c = 5));
    testStudents.add(new Student__c(Name = 'Люся Петрова', Score__c = 12));
    testStudents.add(new Student__c(Name = 'Иван Иванов', Score__c = 95));
    testStudents.add(new Student__c(Name = 'Анна Петрова', Score__c = 82));
    testStudents.add(new Student__c(Name = 'Сергей Сидоров', Score__c = 60));
    insert testStudents;
  }

  @IsTest
  static void getStudents_Test() {
    List<Student__c> students = StudentController.getStudents();

    for (Integer i = 0; i < students.size() - 1; i++) {
      Decimal currentScore = students[i].Score__c;
      Decimal nextScore = students[i + 1].Score__c;

      Assert.isTrue(currentScore >= nextScore);
    }
  }

  @IsTest
  static void getTopStudents_Test() {
    List<Student__c> students = StudentController.getTopStudents(5);

    for (Integer i = 0; i < students.size() - 1; i++) {
      Decimal currentScore = students[i].Score__c;
      Decimal nextScore = students[i + 1].Score__c;
      Assert.isTrue(currentScore >= nextScore);
    }
    Assert.areEqual(5, students.size());
  }
}
