({
    
    init : function(component, event, helper) {
        console.log('>>> INIT <<<');
		helper.carregaBunkers(component, event);
        helper.setColumns(component);
	},

    handleChange: function (component, event, helper) {
        helper.carregaMembros(component, event);
    },
    
    handleChangeCri: function (component, event, helper) {
        helper.carregaCri(component, event);
    },

    viewRecord : function(component, event, helper) {
        helper.viewRecord( component, event );
	},

    showModal : function(component, event, helper) {
        component.set("v.showModal",true);
        helper.carregaCriaturas( component, event );
	},
    
    closeModal : function(component, event, helper) {
        component.set("v.showModal",false);
	}

})