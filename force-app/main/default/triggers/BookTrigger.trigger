trigger BookTrigger on Book__c (before insert, before update) {
	BookTriggerHelper.setAvailability(Trigger.new);
}