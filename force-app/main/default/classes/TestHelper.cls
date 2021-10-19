@IsTest
public class TestHelper {
    
    public static Criatura__c CriaCriatura(integer count) {
        return new Criatura__c(name = 'Criatura '+count);
    }

    public static Bunker__c CriaBunker(integer count){
        new Bunker__c(name = 'Bunker '+count);
    }

}