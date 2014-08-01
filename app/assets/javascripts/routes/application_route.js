App.ApplicationRoute = Ember.Route.extend({
  actions: {
    openModal: function(modalName, model) {
      var buffer = model.toJSON()
      this.controllerFor(modalName).set('model', model);
      this.controllerFor(modalName).set('buffer', buffer);
      return this.render(modalName, {
        into: 'application',
        outlet: 'modal'
      });
    },
    closeModal: function() {
      return this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      });
    }
  }
});
