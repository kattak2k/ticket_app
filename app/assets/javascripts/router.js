App.Router.map(function() {
  this.resource('projects', { path: '/' });
  this.resource('project', { path: '/projects/:project_id' }, function() {
    this.route('new_ticket');
  });
  this.resource('ticket', { path: '/tickets/:ticket_id' }, function() {
    this.route('edit');
  });
  this.resource('comments', function() {
    this.route('new');
  });
});
