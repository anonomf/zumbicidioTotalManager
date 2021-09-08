public with sharing class EditarCriaturaRecursoPAGEExtension {
    
    private Criatura__c criatura;

    public EditarCriaturaRecursoPAGEExtension(ApexPages.StandardController controller) {
        this.criatura = (Criatura__c) controller.getRecord();
    }

    public Pagereference cancelar(){
        Pagereference pg = new Pagereference( '/'+this.criatura.id );
        pg.setRedirect(true);
        return pg;
    }

}