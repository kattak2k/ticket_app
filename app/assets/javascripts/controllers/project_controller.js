App.ProjectController = Ember.ObjectController.extend({
  actions: {
    deleteProject: function() {
      if(confirm('Are you sure?')) {
        var project = this.get('model');
        project.destroyRecord();
      }
    }
  }
});
