App.ModalController = Ember.ObjectController.extend({
  actions: {
    close: function() {
      var model = this.get('model');
      model.rollback();
      return this.send('closeModal');
    },
    save: function() {
      var self = this;
      var model = this.get('model');
      var buffer = this.get('buffer');
      model.eachAttribute(function(name, attribute) {
        if (buffer[name]) {
            model.set(name, buffer[name]);
        }
      });
      model.save().then(function () {
        self.send('closeModal');
      }, function (error) {
      });
    }
  }
});
