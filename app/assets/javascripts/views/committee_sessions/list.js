Modelunitednations.ListCommitteeSessionsView = Ember.View.extend({
    templateName:    'app/templates/committee_sessions/list',
    committeeSessionsBinding: 'App.committeeSessionsController',

    refreshListing: function() {
        App.committeeSessionsController.findAll();
    }
});