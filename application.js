var SearchAreaView = Backbone.View.extend({
  el: $('#search'),

  initialize: function() {
    return this;
  }
});

var SearchCollection = Backbone.Collection.extend({
  initialize: function(args) {
    return this;
  }
});

var SearchController = Backbone.Controller.extend({
  routes: {
    "": "welcome"
  },

  initialize: function(options) {
    this.SearchCollection = new SearchCollection();

    this.SearchArea = new SearchAreaView({
      model: this.SearchCollection
    });

    this.SearchArea.render();

    return this;
  },

  welcome: function() {
    return this;
  }
})

$(function(){
	var Controller = new SearchController();

	// Inform Backbone we're ready to start handling routes.
	Backbone.history.start();
	console.log('Started.');
});
