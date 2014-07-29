App = Ember.Application.create();

App.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  namespace: 'api'
});

App.Router.map(function() {
  this.resource('projects', { path: '/' });
  this.resource('project', { path: '/projects/:project_id' }, function() {
    this.route('new_ticket');
  });
  this.resource('ticket', { path: '/tickets/:ticket_id' }, function() {
    this.route('edit');
  });
  this.resource('comments', function() {
    this.route('new');
  });
});

App.ApplicationRoute = Ember.Route.extend({
  actions: {
    openModal: function(modalName, model) {
      var buffer = model.toJSON()
      this.controllerFor(modalName).set('model', model);
      this.controllerFor(modalName).set('buffer', buffer);
      return this.render(modalName, {
        into: 'application',
        outlet: 'modal'
      });
    },
    closeModal: function() {
      return this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      });
    }
  }
});

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

App.ModalDialogComponent = Ember.Component.extend({
  actions: {
    close: function() {
      return this.sendAction();
    },
    save: function() {
      return this.sendAction();
    }
  }
});

App.ProjectsRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('project');
  },
  actions: {
    displayErrors: function() {
      return this.render('errors', {
        into: 'projects',
        outlet: 'errors'
      });
    }
  }
});

App.ProjectsController = Ember.ArrayController.extend({
  itemController: 'project',
  sortProperties: ['id'],
  actions: {
    createProject: function() {
      var controller = this;
      var name = this.get('newProject') || '';
      $.post('/api/projects.json', { project: { name: name } })
      .done( function(response) {
        controller.store.push('project', response.project);
        controller.set('newProject', '');
      })
      .fail( function(xhr, textStatus, errorThrown) {
        var errors = $.parseJSON(xhr.responseText).errors
        controller.set('errors', errors);
        controller.send('displayErrors');
      });
    }
  }
});

App.ProjectController = Ember.ObjectController.extend({
  actions: {
    deleteProject: function() {
      if(confirm('Are you sure?')) {
        var project = this.get('model');
        project.destroyRecord();
      }
    }
  }
});

App.TicketsController = Ember.ArrayController.extend({
  itemController: 'ticket',
  sortProperties: ['id']
});

App.TicketController = Ember.ObjectController.extend({
  itemController: 'comment',
  priorities: [
    { id: "low", label: "Low" },
    { id: "medium", label: "Medium" },
    { id: "high", label: "High" }
  ],
  statuses: [
    { id: "open", label: "Open" },
    { id: "in_progress", label: "In Progress" },
    { id: "ready_for_review", label: "Ready For Review" },
    { id: "resolved", label: "Resolved" },
    { id: "closed", label: "Closed" },
  ],
  actions: {
    deleteTicket: function() {
      if(confirm('Are you sure?')) {
        var ticket = this.get('model');
        var project = ticket.get('project');
        project.get('tickets').removeObject(ticket);
        ticket.destroyRecord();
        this.transitionToRoute('project', project);
      }
    },
    saveTicket: function() {
      var controller = this;
      var ticket = this.get('model');
      var isNew = ticket.get('isNew');
      ticket.save().then(function() {
        var project = ticket.get('project');
        if(isNew) {
          project.get('tickets').then(function(tickets) {
            tickets.pushObject(ticket);
            controller.transitionToRoute('project', project);
          });
        } else {
          controller.transitionToRoute('project', project);
        }
      }, function(error) {
      });
    },
    saveComment: function() {
      var controller = this;
      var ticket = this.get('ticket');
      var comment = this.get('comment');
      comment.save().then(function() {
        ticket.get('comments').then(function(comments) {
          comments.pushObject(comment);
          controller.set('comment', controller.store.createRecord('comment', { ticket: ticket }));
        });
      }, function(errors) {
      });
    }
  }
});

App.ProjectNewTicketRoute = Ember.Route.extend({
  controllerName: 'ticket',
  model: function() {
    var project = this.modelFor('project');
    return this.store.createRecord('ticket', { project: project });
  },
  actions: {
    willTransition: function(transition) {
      if(this.currentModel.get('isNew')) {
        this.currentModel.destroyRecord();
      }
    }
  }
});

App.TicketIndexRoute = Ember.Route.extend({
  controllerName: 'ticket',
  model: function() {
    var ticket = this.modelFor('ticket');
    return Ember.RSVP.hash({
      ticket: ticket,
      comment: this.store.createRecord('comment', { ticket: ticket })
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

App.TicketEditRoute = Ember.Route.extend({
  controllerName: 'ticket',
  actions: {
    willTransition: function(transition) {
      if(this.currentModel.get('isDirty')) {
        this.currentModel.rollback();
      }
    }
  }
});

App.TicketPriorityComponent = Em.Component.extend({
  tagName: 'span',
  classNames: ['label'],
  classNameBindings: ['priority'],
  priority: function() {
    return 'label-' + this.get('ticket').get('priority');
  }.property('ticket.priority')
});

App.TicketStatusComponent = Em.Component.extend({
  tagName: 'span',
  classNames: ['label'],
  classNameBindings: ['status'],
  status: function() {
    return 'label-' + this.get('ticket').get('status');
  }.property('ticket.status')
});

App.CommentsController = Ember.ArrayController.extend({
  itemController: 'comment',
  sortProperties: ['created_at'],
  sortAscending: false
});

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

App.Project = DS.Model.extend({
  name: DS.attr(),
  tickets: DS.hasMany('ticket', { async: true })
});

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

App.Comment = DS.Model.extend({
  name: DS.attr(),
  body: DS.attr(),
  created_at: DS.attr('date'),
  ticket: DS.belongsTo('ticket')
});

Ember.Handlebars.registerBoundHelper('datetime', function(date, options) {
  defaults = { format: 'M/DD/YYYY h:mm:ss a'};
  settings = $.extend({}, defaults, options.hash)
  return moment(date).format(settings.format);
});
