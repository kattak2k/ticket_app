App.TicketController = Ember.ObjectController.extend({
  itemController: 'comment',
  priorities: [
    { id: "low", label: "Low" },
    { id: "medium", label: "Medium" },
    { id: "high", label: "High" }
  ],
  statuses: [
    { id: "open", label: "Open" },
    { id: "in_progress", label: "In Progress" },
    { id: "ready_for_review", label: "Ready For Review" },
    { id: "resolved", label: "Resolved" },
    { id: "closed", label: "Closed" },
  ],
  actions: {
    deleteTicket: function() {
      if(confirm('Are you sure?')) {
        var ticket = this.get('model');
        var project = ticket.get('project');
        project.get('tickets').removeObject(ticket);
        ticket.destroyRecord();
        this.transitionToRoute('project', project);
      }
    },
    saveTicket: function() {
      var controller = this;
      var ticket = this.get('model');
      var isNew = ticket.get('isNew');
      ticket.save().then(function() {
        var project = ticket.get('project');
        if(isNew) {
          project.get('tickets').then(function(tickets) {
            tickets.pushObject(ticket);
            controller.transitionToRoute('project', project);
          });
        } else {
          controller.transitionToRoute('project', project);
        }
      }, function(error) {
      });
    },
    saveComment: function() {
      var controller = this;
      var ticket = this.get('ticket');
      var comment = this.get('comment');
      comment.save().then(function() {
        ticket.get('comments').then(function(comments) {
          comments.pushObject(comment);
          controller.set('comment', controller.store.createRecord('comment', { ticket: ticket }));
        });
      }, function(errors) {
      });
    }
  }
});

