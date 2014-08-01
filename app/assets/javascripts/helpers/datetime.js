Ember.Handlebars.registerBoundHelper('datetime', function(date, options) {
  defaults = { format: 'M/DD/YYYY h:mm:ss a'};
  settings = $.extend({}, defaults, options.hash)
  return moment(date).format(settings.format);
});

