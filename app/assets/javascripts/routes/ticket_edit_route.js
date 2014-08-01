App.TicketEditRoute = Ember.Route.extend({
  controllerName: 'ticket',
  actions: {
    willTransition: function(transition) {
      if(this.currentModel.get('isDirty')) {
        this.currentModel.rollback();
      }
    }
  }
});

