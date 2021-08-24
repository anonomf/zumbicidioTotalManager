public with sharing class ContagiarBatchabble implements Database.Batchable<Criatura__c>{
    
    public ContagiarBatchabble() {}
    
    public Database.QueryLocator start(Database.Batchable BC){
        return Database.getQueryLocator('SELECT id, Criatura__c.RecordTypeId, bunker__r.defesaBunker__c, bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c');

    }

    public void execute(Database.Batchable BC, List<Criatura__c> scope){
        List<Criatura__c> hum = preencheListaCriaturaRecordtype('0125e000000NT21AAG');
        List<Criatura__c> zom = new List<Criatura__c>();

    }

    private List<Criatura__c> preencheListaCriaturaRecordtype(id recordtype,  List<sObject> listaP){
        List<Criatura__c> cri = new List<Criatura__c>();
        for(Criatura__c crip : listaP){
            if (crip.recordTypeId == recordtype) {
                cri.add(crip);
            }
        }
        return cri;
    }

    public void finish(Database.Batchable BC){

    }

}
