App.CommentsController = Ember.ArrayController.extend({
  itemController: 'comment',
  sortProperties: ['created_at'],
  sortAscending: false
});

