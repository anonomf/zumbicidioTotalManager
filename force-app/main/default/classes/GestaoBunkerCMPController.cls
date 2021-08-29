public with sharing class GestaoBunkerCMPController {
    
    @AuraEnabled
    public static List<Bunker__c> recuperaBunkers(){
        return [SELECT Id, Name FROM Bunker__c limit 200];
    }

    @AuraEnabled
    public static Bunker recuperaBunkerMembros( String bunkerId ){
        Bunker bunkerToReturn = new Bunker();

        List<Criatura__c> criaturas = [SELECT id, Name, RecordType.name, Bunker__r.name, Bunker__r.Capacidade__c, Bunker__r.Ativo__c, Bunker__r.DefesaBunker__c, Bunker__r.AcrescimoDefesa__c, Bunker__r.Populacao__c, (SELECT AcrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c WHERE Bunker__c = :bunkerId limit 200];
        if( !criaturas.isEmpty() ){
            bunkerToReturn.ativo        = criaturas[0].Bunker__r.Ativo__c;
            bunkerToReturn.nome         = criaturas[0].Bunker__r.name;
            bunkerToReturn.capacidade   = Integer.valueOf( criaturas[0].Bunker__r.Capacidade__c );
            bunkerToReturn.populacao    = Integer.valueOf( criaturas[0].Bunker__r.Populacao__c );
            bunkerToReturn.defesa       = criaturas[0].Bunker__r.DefesaBunker__c;

            bunkerToReturn.percentHumanos   = getPercentualHumanos( criaturas );
            bunkerToReturn.percentZumbis    = getPercentualZumbis( criaturas );
            bunkerToReturn.percentLotacao   = criaturas[0].Bunker__r.Populacao__c.divide( criaturas[0].Bunker__r.Capacidade__c, 2) * 100;
            bunkerToReturn.membrosDoBunker  = getMembrosBunker( criaturas );
        }
        
        return bunkerToReturn;
    }

    @AuraEnabled
    public static List<Criatura__c> criSelecionada( String bunkerId ){
        return [SELECT id, name FROM Criatura__c limit 200];
    }

    @AuraEnabled
    public static void incluirCriBunker (String bunkerId, String criaturaId){
        Criatura__c criatura    = new Criatura__c();
        criatura.Id             = criaturaId;
        criatura.Bunker__c      = bunkerId;
        update criatura;
    }

    private static Decimal getPercentualHumanos( List<Criatura__c> criaturas ){
        Decimal percentHumano = 0;
        Decimal totalCriaturas  = criaturas.size();
        Decimal totalHumano     = 0;
        for( Criatura__c criatura : criaturas ){
            if( criatura.recordtype.Name == 'Humano' ){
                totalHumano = totalHumano + 1;
            }
        }
        percentHumano = totalHumano.divide( totalCriaturas, 2) * 100;
        return percentHumano;
    }
    
    private static Decimal getPercentualZumbis( List<Criatura__c> criaturas ){
        Decimal percentZumbi    = 0;
        Decimal totalCriaturas  = criaturas.size();
        Decimal totalZumbi      = 0;
        for( Criatura__c criatura : criaturas ){
            if( criatura.recordtype.Name == 'Zumbi' ){
                totalZumbi++;
            }
        }
        percentZumbi = totalZumbi.divide( totalCriaturas, 2) * 100;
        return percentZumbi;
    }

    private static List<MembroDoBunker> getMembrosBunker( List<Criatura__c> criaturas ){
        List<MembroDoBunker> membros = new List<MembroDoBunker>();
        for( Criatura__c criatura : criaturas ){
            System.debug('>>> criatura.Name :: '+criatura.Name);
            MembroDoBunker membro = new MembroDoBunker();
                membro.sfId     = criatura.Id;
                membro.nome     = criatura.Name;
                membro.tipo     = criatura.RecordType.name;
                membro.defesa   = calculaDefesaCriatura( criatura.RecursosCriatura__r );
            membros.add(membro);
        }
        return membros;
    }

    private static Decimal calculaDefesaCriatura( List<RecursoCriatura__c> recursosCriatura ){
        Decimal defesa = 0;
        for( RecursoCriatura__c recursoCriatura : recursosCriatura ){
            Decimal acrescimo = recursoCriatura.AcrescimoDefesa__c;
            defesa = defesa + acrescimo;
        }
        return defesa/100;
    }
    
    public class Bunker{
        @AuraEnabled
        public Boolean ativo;
        @AuraEnabled
        public Id sfId;
        @AuraEnabled
        public String nome;
        @AuraEnabled
        public Integer capacidade;
        @AuraEnabled
        public Integer populacao;
        @AuraEnabled
        public Decimal defesa;
        @AuraEnabled
        public Decimal percentHumanos;
        @AuraEnabled
        public Decimal percentZumbis;
        @AuraEnabled
        public Decimal percentLotacao;
        @AuraEnabled
        public List<MembroDoBunker> membrosDoBunker; 
    }
    
    public class MembroDoBunker{
        @AuraEnabled
        public Id sfId;
        @AuraEnabled
        public String nome;
        @AuraEnabled
        public String tipo;
        @AuraEnabled
        public Decimal defesa;
    }
    
}