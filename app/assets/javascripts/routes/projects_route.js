App.ProjectsRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('project');
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
