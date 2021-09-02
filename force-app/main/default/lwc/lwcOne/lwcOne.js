import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Bunker__c.Name',
    'Bunker__c.Ativo__c'
]

export default class LwcOne extends LightningElement {

    @api recordId;

    @wire( getRecord, { recordId : '$recordId', fields : FIELDS } )
    bunker;
    
    get name(){
        return this.bunker.data.fields.name.value();
    }

}