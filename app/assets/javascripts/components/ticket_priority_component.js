App.TicketPriorityComponent = Em.Component.extend({
  tagName: 'span',
  classNames: ['label'],
  classNameBindings: ['priority'],
  priority: function() {
    return 'label-' + this.get('ticket').get('priority');
  }.property('ticket.priority')
});

