App.CommentController = Ember.ObjectController.extend({
  actions: {
    deleteComment: function() {
      if(confirm('Are you sure?')) {
        var comment = this.get('model');
        var ticket = comment.get('ticket');
        ticket.get('comments').removeObject(comment);
        comment.destroyRecord();
      }
    },
  }
});

