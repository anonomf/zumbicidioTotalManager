@IsTest
public class CriaturaTriggerHandler_Test {
    
    @IsTest public static void CriaturaAfterInsertComBunker() {
        
        Criatura__c cri = TestHelper.CriaCriatura(1);
        Bunker__c bk = TestHelper.CriaBunker(1);
        insert bk;
        cri.Bunker__c = bk.id;
        system.assertEquals(0, [SELECT id, populacao__c FROM Bunker__c WHERE id = : bk.id].populacao);
        test.startTest();
        insert cri;
        test.stopTest();
        system.assertEquals(1, [SELECT id, populacao__c FROM Bunker__c WHERE id = : bk.id].populacao);

    }

    @IsTest public static void CriaturaAfterUpdateComBunker() {
        
        Criatura__c cri = TestHelper.CriaCriatura(1);
        Bunker__c bk = TestHelper.CriaBunker(1);
        insert bk;
        insert cri;
        system.assertEquals(0, [SELECT id, populacao__c FROM Bunker__c WHERE id = : bk.id].populacao);
        test.startTest();
            cri.Bunker__c = bk.id;
            update cri;
        test.stopTest();
        system.assertEquals(1, [SELECT id, populacao__c FROM Bunker__c WHERE id = : bk.id].populacao);

    }

    @IsTest public static void CriaturaAfterDeleteComBunker() {
        
        Criatura__c cri = TestHelper.CriaCriatura(1);
        Bunker__c bk = TestHelper.CriaBunker(1);
        insert bk;
        cri.Bunker__c = bk.id;
        insert cri;
        system.assertEquals(0, [SELECT id, populacao__c FROM Bunker__c WHERE id = : bk.id].populacao);
        test.startTest();
            delete cri;
        test.stopTest();
        system.assertEquals(1, [SELECT id, populacao__c FROM Bunker__c WHERE id = : bk.id].populacao);

    }

}
