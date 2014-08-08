App.ProjectNewTicketRoute = Ember.Route.extend({
  controllerName: 'ticket',
  model: function() {
    var project = this.modelFor('project');
    return this.store.createRecord('ticket', { project: project });
  },
  actions: {
    willTransition: function(transition) {
      if(this.currentModel.get('isNew')) {
        this.currentModel.deleteRecord();
      }
    }
  }
});

