({
    
    carregaBunkers : function( component, event ) {
        
		let action = component.get("c.recuperaBunkers");
        component.set('v.showSpinner', true);

        action.setCallback(this, function(response) {
            let state = response.getState();
            let errors = response.getError();
            if (state === "SUCCESS") {
                component.set('v.showSpinner', false);
                
                var rows = response.getReturnValue();
                for( var i =0; i < rows.length; i++ ){
                    var row = rows[i];
                    row.label     = row.Name;
                    row.value     = row.Id;
                }
                console.log('rows',rows);
                if( rows != null ){
                    component.set('v.options', rows);
                }
            }
        });
        $A.enqueueAction(action); 
	},

    setColumns : function( component ) {
        component.set('v.columns',[

            {label: 'Membro', fieldName: 'nome', type: 'text'},
            {label: 'Tipo de Criatura', fieldName: 'tipo', type: 'text'},
            {label: 'Defesa', fieldName: 'defesa', type: 'percent'},
            {type: "button", typeAttributes: {
                label: 'Ver Criatura',
                name: 'View',
                title: 'Clique aqui para abrir este registro',
                disabled: false,
                value: 'view',
                iconPosition: 'left'
            }},
            {type: "button", typeAttributes: {
                label: 'Editar/Expulsar',
                name: 'Edit',
                title: 'Clique aqui para editar este registro',
                disabled: false,
                value: 'edit',
                iconPosition: 'left'
            }}
        ])
    },

    carregaMembros : function( component, event ) {
        let bunkerSelecionado = event.getParam("value");
        let action = component.get("c.recuperaBunkerMembros");
        component.set("v.bunkerSelecionado",bunkerSelecionado);

        component.set('v.showSpinner', true);

        action.setParams({
            bunkerId : bunkerSelecionado
        });

        action.setCallback(this, function(response) {
            let state = response.getState();
            let errors = response.getError();
            if (state === "SUCCESS") {
                var bunker = response.getReturnValue();

                console.log('>>> return:: ',bunker);
                if( bunker != null ){
                    component.set('v.bunkerInfo', bunker);
                    if( bunker.membrosDoBunker != null ){
                        component.set('v.data', bunker.membrosDoBunker);
                    }
                }
                component.set('v.showSpinner', false);
            }
        });
        $A.enqueueAction(action); 

    },

    viewRecord : function(component, event) {
        var recId = event.getParam('row').sfId;
        var actionName = event.getParam('action').name;
        if ( actionName == 'Edit' ) {

            var editRecordEvent = $A.get("e.force:editRecord");
            editRecordEvent.setParams({
                "recordId": recId
            });
            editRecordEvent.fire();

        } else if ( actionName == 'View') {

            var viewRecordEvent = $A.get("e.force:navigateToURL");
            viewRecordEvent.setParams({
                "url": "/" + recId
            });
            viewRecordEvent.fire();
        }
    },

})