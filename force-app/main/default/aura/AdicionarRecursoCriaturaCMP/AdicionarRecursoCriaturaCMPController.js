({
	doInit : function( component, event, helper ){
        helper.getRecursos( component, event );
    },
    
	handleChange: function (component, event) {
        var selectedOptionValue = event.getParam("value");
        component.set("v.recursoSelecionado",selectedOptionValue);
    },
    
    salvar : function( component, event, helper ){
        helper.adicionaRecurso( component, event );
    }
})