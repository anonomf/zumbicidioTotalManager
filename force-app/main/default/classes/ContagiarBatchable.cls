public class ContagiarBatchable implements Database.Batchable<SObject>{
    
    private String zumbieId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Zumbi').getRecordTypeId();
    private String humanId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Humano').getRecordTypeId();

    static final integer ZumbieSpread = 2;

    public ContagiarBatchable() {}
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT id, Criatura__c.RecordTypeId, bunker__r.defesaBunker__c, bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c');

    }

    public void execute(Database.BatchableContext BC, List<criatura__c> scope){

        List<criatura__c> criList = (List<criatura__c>) scope;
        Map<id, criatura__c> criUpdateList = new Map<id, criatura__c>();
        List<Criatura__c> humList = preencheListaCriaturaRecordtype(humanId, criList);
        List<Criatura__c> zumList = preencheListaCriaturaRecordtype(zumbieId, criList);
        for(Criatura__c zum : zumList){
            for (integer i =0; i<ZumbieSpread; i++) {
                Criatura__c cri = (Criatura__c) Util.GetRamdomItem(humList);
                Decimal defesa = this.getDefense(cri);
                Integer DiceRoll = Math.mod(Integer.valueOf(Math.random()*100000), 100)+1;
                if(DiceRoll > defesa){
                    cri.recordtypeId = zumbieId;
                    cri.DatadeZumbificao__c = Date.today();
                    criUpdateList.put(cri.id, cri);
                }
            }
        }
        update criUpdateList.values();
    }

    private Decimal getDefense(Criatura__c hmn1){
        Decimal defesa = 0;
        if(hmn1.RecordTypeId != zumbieId){
            if(hmn1.bunker__c != null){
                defesa += hmn1.bunker__r.defesaBunker__c;
            }if(hmn1.RecursosCriatura__r != null){
                for(recursoCriatura__c recCri : hmn1.RecursosCriatura__r){
                    defesa += recCri.acrescimoDefesa__c;
                }
            }
        }
        return defesa;
    }

    private List<Criatura__c> preencheListaCriaturaRecordtype(id recordtype,  List<Criatura__c> listaP){
        List<Criatura__c> cri = new List<Criatura__c>();
        for(Criatura__c crip : listaP){
            if (crip.recordTypeId == recordtype) {
                cri.add(crip);
            }
        }
        return cri;
    }

    public void finish(Database.BatchableContext BC){

    }
}