public class CriaturaTriggerHandler extends TriggerHandler{
    /*
    public override void afterInsert(){
        this.AtualizaPopulacaoBunker(trigger.new, new Map<id,Bunker__c>());
    }
    public override void afterUpdate(){
        this.AtualizaPopulacaoBunker(trigger.new, trigger.oldMap);
    }
    public override void afterDelete(){
        this.AtualizaPopulacaoBunker(new List<Criatura__c>, trigger.oldMap);
    }

    private AtualizaPopulacaoBunker(List<Criatura__c> triggerNew, Map<Id, Criatura__c> triggerOldMap){
        Map<id,Bunker__c> bunkersUpdateMap = new Map<id,Bunker__c>();
        for(Criatura__c cr : triggerNew){
            Id idBunker = this.AlterouBunker(cri, triggerOldMap.get(cri.id));
            if (idBunker != null) {
                bunkersUpdateMap.put(idBunker, new Bunker__c(id = nova.Bunker__c));
            } 
        }
        for(Criatura__c cr : trigger.old){
            if(trigger.isDelete && cr.Bunker__c!= null){
                bunkersUpdateMap.put(cr.Bunker__c,new Bunker__c(id = cr.bunker__c));
            }
        }
    }

    private id AlterouBunker(Criatura__c criNew, Criatura__c criOld){
        if (criOld == null) {
            return null;
        }
        if(criNew.Bunker__c != criOld.Bunker__c){
            if(criNew.Bunker__c != null){
                return criNew.Bunker__c;
            }
            if(criOld.Bunker__c != null){
                return criOld.Bunker__c;
            }
        }
        return null;
    }*/
    
}
/*
    //Identificar os Bunkers
    Map<id,Bunker__c> bunkersUpdateMap = new Map<id,Bunker__c>();
    for(Criatura__c cr : trigger.new){
        Criatura__c nova = cr;
        Criatura__c antiga = trigger.oldMap.get(nova.id);
        if(nova.Bunker__c != antiga.Bunker__c){
            if(nova.Bunker__c != null){
                bunkersUpdateMap.put(nova.Bunker__c,new Bunker__c(id = nova.bunker__c));
            }
            if(antiga.Bunker__c != null){
                bunkersUpdateMap.put(antiga.Bunker__c,new Bunker__c(id = antiga.bunker__c));
            }
        }
    }
    
    for(Criatura__c cr : trigger.old){
        if(trigger.isDelete && cr.Bunker__c!= null)
            bunkersUpdateMap.put(cr.Bunker__c,new Bunker__c(id = cr.bunker__c));
    }

    //Totalizar todas as criaturas dos Bunkers identificados
    system.debug(bunkersUpdateMap);
    List<Bunker__c> bkList = [select id, (Select id from Criaturas__r) from Bunker__c where id in : bunkersUpdateMap.keySet()];
    for(Bunker__c bk : bkList){
        bunkersUpdateMap.get(bk.id).Populacao__c = bk.Criaturas__r.size();
    }

    //Atualizar os Bunkers
    update bunkersUpdateMap.values();
    */