public with sharing class StudentController {
  public static List<Student__c> getStudents() {
    List<Student__c> students = [
      SELECT Name, Score__c, Grade__c
      FROM Student__c
      ORDER BY Score__c DESC
    ];
    return students;
  }

  public static List<Student__c> getTopStudents(Integer n) {
    List<Student__c> students = [
      SELECT Name, Score__c, Grade__c
      FROM Student__c
      ORDER BY Score__c DESC
      LIMIT :n
    ];
    return students;
  }
}
