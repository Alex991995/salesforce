@IsTest
public class BookTriggerTest {
  @IsTest
  static void setAvailabilityBeforeInsert() {
    List<Book__c> mockBooks = createMockData();

    Test.startTest();
    insert mockBooks;
    Test.stopTest();

    List<Book__c> results = [
      SELECT Quantity__c, Available__c
      FROM Book__c
      WHERE Name LIKE 'Test Book%'
    ];

    for (Book__c b : results) {
      if (b.Quantity__c > 0) {
        Assert.isTrue(b.Available__c);
      } else {
        Assert.isFalse(b.Available__c);
      }
    }
  }
  @IsTest
  static void setAvailabilityBeforeUpdate() {
    List<Book__c> mockBooks = createMockData();
    insert mockBooks;

    for (Book__c b : mockBooks) {
      b.Quantity__c = 0;
    }
    Test.startTest();
    update mockBooks;
    Test.stopTest();

    List<Book__c> updatedBook = [
      SELECT Quantity__c, Available__c
      FROM Book__c
    ];
    for (Book__c b : updatedBook) {
      Assert.isFalse(b.Available__c);
    }
  }

  private static List<Book__c> createMockData() {
    List<Book__c> mockBooks = new List<Book__c>();
    for (Integer i = 0; i < 5; i++) {
      Integer quantity = (i < 3) ? 10 + i : 0;

      mockBooks.add(
        new Book__c(
          Name = 'Test Book ' + i,
          Title__c = 'Title ' + i,
          Quantity__c = quantity,
          Price__c = 100
        )
      );
    }
    return mockBooks;
  }
}
