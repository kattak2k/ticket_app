App.TicketIndexRoute = Ember.Route.extend({
  controllerName: 'ticket',
  model: function() {
    var ticket = this.modelFor('ticket');
    return Ember.RSVP.hash({
      ticket: ticket,
      comment: this.store.createRecord('comment')
    });
  },
  setupController: function(controller, model) {
    controller.set('ticket', model.ticket);
    controller.set('comment', model.comment);
  },
  actions: {
    willTransition: function(transition) {
      var comment = this.controller.get('comment');
      if(comment.get('isNew')) {
        comment.destroyRecord();
      }
    }
  }
});

