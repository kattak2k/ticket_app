App.Ticket = DS.Model.extend({
  priorities: {
    "low": "Low",
    "medium": "Medium",
    "high": "High"
  },
  statuses: {
    "open": "Open",
    "in_progress": "In Progress",
    "ready_for_review": "Ready For Review",
    "resolved": "Resolved",
    "closed": "Closed"
  },
  subject: DS.attr(),
  description: DS.attr(),
  priority: DS.attr(),
  status: DS.attr(),
  created_at: DS.attr('date'),
  project: DS.belongsTo('project'),
  comments: DS.hasMany('comment', { async: true }),

  priorityDescription: function() {
    return this.priorities[this.get('priority')];
  }.property('priority'),
  statusDescription: function() {
    return this.statuses[this.get('status')];
  }.property('status')
});

