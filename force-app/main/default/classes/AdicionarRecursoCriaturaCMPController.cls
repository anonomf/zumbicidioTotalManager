public class AdicionarRecursoCriaturaCMPController {
	
    @AuraEnabled
    public static List<Recurso__c> recuperaRecursos( String recordId ){
        List<Recurso__c> recursosToReturn  = new List<Recurso__c>();
        Set<Id> recursosIds = new Set<Id>();
        
        for( RecursoCriatura__c recursoCriatura : [SELECT Id, Recurso__c 
                                                   FROM RecursoCriatura__c
                                                   WHERE Criatura__c =:recordId ] ){
            recursosIds.add(recursoCriatura.Recurso__c);
        }
        
        recursosToReturn = [select Id, Name from Recurso__c where Id NOT IN: recursosIds limit 200];
               
        return recursosToReturn;
    }
    
    @AuraEnabled
    public static void adicionarRecursoCriatura( String criaturaId, String recursoId ){
        RecursoCriatura__c recursoCriatura = new RecursoCriatura__c();
        recursoCriatura.Criatura__c = criaturaId;
        recursoCriatura.Recurso__c 	= recursoId;
        
        insert recursoCriatura; 
    }
    
}