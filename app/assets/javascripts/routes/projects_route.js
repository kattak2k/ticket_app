App.ProjectsRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('project');
  },
  actions: {
    displayErrors: function() {
      return this.render('errors', {
        into: 'projects',
        outlet: 'errors'
      });
    }
  }
});
