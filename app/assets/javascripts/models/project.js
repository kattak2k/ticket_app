App.Project = DS.Model.extend({
  name: DS.attr(),
  tickets: DS.hasMany('ticket', { async: true })
});

