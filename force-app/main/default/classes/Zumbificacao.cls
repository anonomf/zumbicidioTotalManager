public class Zumbificacao {
    
	@InvocableMethod (label='Transforma Zumbi')
    public static void zumbificar(List<id> ids){
        List<Criatura__c> crilist = [SELECT id, bunker__r.name, bunker__c, (SELECT id FROM RecursosCriatura__r) FROM criatura__c WHERE id in : ids];
        List<RecursoCriatura__c> rcDeleteList = new List<RecursoCriatura__c>();
        for(Criatura__c cr : criList){
            String tipoZumbi = '';
            integer rand = Math.mod(Integer.valueOf(Math.random()*100000), 100);
            if(rand < 50){
                tipoZumbi = 'Lerdo';
            }
            else if (rand < 80){
                tipoZumbi = 'Rápido';
            }
            else{
                tipoZumbi = 'Gordo';
            }
            cr.tipoZumbi__c = tipoZumbi;
            if(cr.RecursosCriatura__r != null)
            	rcDeleteList.addAll(cr.RecursosCriatura__r);
        }
        update crilist;
        delete rcDeleteList;
    }
    
}