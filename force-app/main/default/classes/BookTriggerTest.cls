@IsTest
public class BookTriggerTest {
  @IsTest
  static void checkQuantityIfAvailableTrueOrNot(){
    
    List<Book__c> mockBooks = new List<Book__c>();
    for(Integer i = 0; i < 5; i++) {
      Integer quantity = (i < 3) ? 10 + i : 0;
      
      mockBooks.add(new Book__c(
        Name = 'Test Book ' + i,
      Title__c = 'Title ' + i,
      Quantity__c = quantity,
      Price__c = 100
        ));
    }
    
    
    Test.startTest();
    insert mockBooks;
    Test.stopTest();
    
    
    List<Book__c> results = [SELECT Quantity__c, Available__c FROM Book__c];
    
    
    for(Book__c b : results){
      if(b.Quantity__c  > 0){
        Assert.isTrue(b.Available__c);
      }
      else {
        Assert.isFalse(b.Available__c);
      }
    }
    
    
  }
}