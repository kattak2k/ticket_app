App.ProjectsController = Ember.ArrayController.extend({
  itemController: 'project',
  sortProperties: ['id'],
  actions: {
    createProject: function() {
      var controller = this;
      var name = this.get('newProject') || '';
      $.post('/api/projects.json', { project: { name: name } })
      .done( function(response) {
        controller.store.push('project', response.project);
        controller.set('newProject', '');
      })
      .fail( function(xhr, textStatus, errorThrown) {
        var errors = $.parseJSON(xhr.responseText).errors
        controller.set('errors', errors);
        controller.send('displayErrors');
      });
    }
  }
});
