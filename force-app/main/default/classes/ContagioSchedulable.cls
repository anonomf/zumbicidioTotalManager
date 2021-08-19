global class ContagioSchedulable implements Schedulable{
    
    global void execute(SchedulableContext SC){
        this.contagiar();
    }
    
    private void contagiar (){
        List<Criatura__c> humanList = [SELECT id FROM Criatura__c where RecordTypeId = '0125e000000NT21AAG'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c where RecordTypeId = '0125e000000NT2BAAW'];
        
        for(Criatura__c zb : zombieList){
            if(humanList.size() == 0) break;
            Criatura__c hmn1 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000),humanList.size()));
            hmn1.RecordTypeId = '0125e000000NT2BAAW';
            hmn1.DatadeZumbificao__c = Date.today();
            Criatura__c hmn2 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000),humanList.size()));
            hmn2.RecordTypeId = '0125e000000NT2BAAW';
            hmn2.DatadeZumbificao__c = Date.today();
        }
        
        Update humanList;
        
    }
}