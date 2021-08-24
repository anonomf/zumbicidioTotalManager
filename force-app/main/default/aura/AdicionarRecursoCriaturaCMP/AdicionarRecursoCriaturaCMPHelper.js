({
	getRecursos : function(component, event) {
		let recordId = component.get("v.recordId");
        let action = component.get("c.recuperaRecursos");
        
        action.setParams({
            recordId : recordId
        });
        
        action.setCallback(this, function(response){
        	let state = response.getState();
        	let errors = response.getError();
            
            if( state === "SUCCESS" ) {
                let rows = response.getReturnValue();
                
                for( var i =0; i < rows.length; i++ ){
                    var row = rows[i];
                    row.label = row.Name;
                    row.value = row.Id;
                }
                console.log('rows ::',rows);    
                
                if( rows ){
                    component.set("v.recursosLst", rows);
                    component.set("v.recursoSelecionado", null);
                }
                	
                
            } else {
                console.log('>>> errors:: ', errors);
            }
            
            
        });
        $A.enqueueAction(action);
    },
    
    adicionaRecurso : function(component, event) {
		let recordId 	= component.get("v.recordId");
    	let recursoId 	= component.get("v.recursoSelecionado");
        
        console.log('>>> adicionaRecurso <<<');
        
        let action = component.get("c.adicionarRecursoCriatura");
        
        action.setParams({
            criaturaId : recordId,
    		recursoId : recursoId
        });
        
        action.setCallback(this, function(response) {
        	let state = response.getState();
        	let errors = response.getError();
            
            console.log('>>> state ::',state);
            console.log('>>> errors ::',errors);
            
            if( state === "SUCCESS" ) {
                console.log('>>> Success');
   				this.showToast( component, event );
                this.getRecursos( component, event );
            }else {
                console.log('>>> errors:: ', errors);
            }
        });
        $A.enqueueAction(action); 
    },
    
    showToast : function(component, event) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Sucesso!",
            "message": "Recurso foi edicionado com sucesso.",
            "type":"success"
        });
        toastEvent.fire();
    }
})