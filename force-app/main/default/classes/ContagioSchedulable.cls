global class ContagioSchedulable implements Schedulable{
    
    global void execute(SchedulableContext SC){
        this.contagiar();
    }
    
    private void contagiar (){
        List<Criatura__c> humanList = [SELECT id, Criatura__c.RecordTypeId, bunker__r.defesaBunker__c, bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c where RecordTypeId = '0125e000000NT21AAG'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c where RecordTypeId = '0125e000000NT2BAAW'];
        
        for(Criatura__c zb : zombieList){
            if(humanList.size() == 0) break;
            Criatura__c hmn1 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000),humanList.size()));
            Decimal defesa = 0;
            if(hmn1.RecordTypeId != '0125e000000NT2BAAW'){
                if(hmn1.RecordTypeId != null){
                    defesa += hmn1.bunker__r.defesaBunker__c;
                }if(hmn1.RecursosCriatura__r != null){
                    for(recursoCriatura__c recCri : hmn1.RecursosCriatura__r){
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            Integer DiceRoll1 = Math.mod(Integer.valueOf(Math.random()*100000),100)+1;
            if(DiceRoll1 > defesa){
                hmn1.RecordTypeId = '0125e000000NT2BAAW';
                hmn1.DatadeZumbificao__c = Date.today();
            }
            defesa = 0;
            Criatura__c hmn2 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000),humanList.size()));
            if(hmn2.RecordTypeId != '0125e000000NT2BAAW'){
                if(hmn2.bunker__c != null){
                    defesa += hmn2.bunker__r.defesaBunker__c;
                }if(hmn2.RecursosCriatura__r != null){
                    for(recursoCriatura__c recCri : hmn2.RecursosCriatura__r){
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            Integer DiceRoll2 = Math.mod(Integer.valueOf(Math.random()*100000),100)+1;
            if(DiceRoll2 > defesa){
                hmn2.RecordTypeId = '0125e000000NT2BAAW';
            	hmn2.DatadeZumbificao__c = Date.today();
            }
        }
        
        Update humanList;
        
    }
}