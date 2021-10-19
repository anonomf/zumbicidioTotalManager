trigger CriaturaTrigger on Criatura__c (after insert, after update, after delete, before update) {
	
    new CriaturaTriggerHandler().run();

}