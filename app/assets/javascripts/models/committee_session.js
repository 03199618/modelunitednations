Modelunitednations.CommitteeSession  = Ember.Resource.extend({
    resourceUrl: '/committee_sessions',

    fullTitle: Ember.computed(function() {
        return this.get('title');
    }).property('title')
});