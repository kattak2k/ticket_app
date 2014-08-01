App.Comment = DS.Model.extend({
  name: DS.attr(),
  body: DS.attr(),
  created_at: DS.attr('date'),
  ticket: DS.belongsTo('ticket')
});

