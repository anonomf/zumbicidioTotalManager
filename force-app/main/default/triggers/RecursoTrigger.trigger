trigger RecursoTrigger on Criatura__c (after insert, after update) {

    List<Criatura__c> criaturaBunker = new List<Criatura__c>();
    List<Criatura__c> criaturasNovas = trigger.new;
    Map<id, Criatura__c> mapCriaturasAntigas = trigger.oldMap;

    for (Criatura__c cri : criaturasNovas) {
        if ((cri.bunker__c != null) && (cri.bunker__c != trigger.oldMap.get(cri.id).bunker__c)) {
            criaturaBunker.add(cri);
        }
    }

    List<Criatura__c> equipCri = new List<Criatura__c>();
    List<recursoBunker__c> recursoInsert = new List<recursoBunker__c>();
    List<recursoCriatura__c> recursoDelete = new List<recursoCriatura__c>();
    equipCri = [SELECT id, bunker__c, (SELECT id, Quantidade__c, Recurso__c FROM RecursosCriatura__r) FROM Criatura__c WHERE id IN : criaturaBunker];
    
    for (Criatura__c cri : equipCri) {
        for (recursoCriatura__c rcs: cri.RecursosCriatura__r) {
            recursoInsert.add(new recursoBunker__c(Recurso__c = rcs.Recurso__c, Quantidade__c = rcs.Quantidade__c, Bunker__c = cri.Bunker__c));
            recursoDelete.add(rcs);
        }
    }

    insert recursoInsert;
    delete recursoDelete;

}