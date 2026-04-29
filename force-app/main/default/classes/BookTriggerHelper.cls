public class BookTriggerHelper {
  public static void setAvailability(List<Book__c> books) {
    for (Book__c b : books) {
      if (b.Quantity__c > 0) {
        b.Available__c = true;
      } else {
        b.Available__c = false;
      }
    }
  }
}
