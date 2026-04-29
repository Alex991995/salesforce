public class StudentController {
  public static List<Student__c> getStudents() {
    Student__c[] students = [
      SELECT Name, Score__c, Grade__c
      FROM Student__c
      ORDER BY Score__c DESC
      LIMIT 50
    ];
    return students;
  }

  public static List<Student__c> getTopStudents(Integer n) {
    Student__c[] students = [
      SELECT Name, Score__c, Grade__c
      FROM Student__c
      ORDER BY Score__c
      LIMIT :n
    ];
    return students;
  }
}
