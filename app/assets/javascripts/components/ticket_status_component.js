App.TicketStatusComponent = Em.Component.extend({
  tagName: 'span',
  classNames: ['label'],
  classNameBindings: ['status'],
  status: function() {
    return 'label-' + this.get('ticket').get('status');
  }.property('ticket.status')
});

