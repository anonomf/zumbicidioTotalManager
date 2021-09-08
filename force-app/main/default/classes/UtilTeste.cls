@isTest
public class UtilTeste {
    
    private String zumbieId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Zumbi').getRecordTypeId();
    private String humanId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Humano').getRecordTypeId();

    @isTest static void GetRamdomItemTest() {
        List<Criatura__c> creatureList = new List<Criatura__c>();
        for (integer i=0; i <= 200; i++) {
            creatureList.add(new criatura__c(name = 'Criatura '+i));
        }

        test.startTest();
        Criatura__c cri = (Criatura__c) Util.GetRamdomItem(creatureList);
        test.stopTest();

        Boolean flag = false;
        for (Criatura__c criFor : creatureList) {
            if (criFor.name == cri.name) {
                flag = true;
            }
        }

        System.assert(flag, 'O item randomico não esxiste na lista');

    }
}
