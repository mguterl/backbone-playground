(function() {
  var SearchApp;
  SearchApp = function() {
    var SearchAreaTemplate, SearchAreaView, SearchCollection, SearchController, SearchModel;
    SearchModel = Backbone.Model.extend({});
    SearchAreaTemplate = _.template("<a class='previous' href='#!/page/<%= parseInt(page) - 1 %>'>Previous page</a> " + "<span class='page'>Page: <%= page %></span> " + "<a class='next' href='#!/page/<%= parseInt(page) + 1 %>'>Next page</a>");
    SearchAreaView = Backbone.View.extend({
      el: $('#search'),
      initialize: function() {
        this.render = _.bind(this.render, this);
        this.model.bind('change:page', this.render);
        this.layout = SearchAreaTemplate;
        return this;
      },
      render: function() {
        var content;
        content = this.layout(this.model.toJSON());
        $(this.el).empty().html(content);
        if (parseInt(this.model.get('page')) > 1) {
          this.$(".previous").show();
        }
        return this;
      }
    });
    SearchCollection = Backbone.Collection.extend({
      initialize: function(args) {
        return this;
      }
    });
    SearchController = Backbone.Controller.extend({
      routes: {
        "": "welcome",
        "!/page/:pageNumber": "page"
      },
      initialize: function(options) {
        this.instance = new SearchModel({
          id: 1,
          page: 1
        });
        this.SearchArea = new SearchAreaView({
          model: this.instance
        });
        this.SearchArea.render();
        return this;
      },
      welcome: function() {
        return this;
      },
      page: function(pageNumber) {
        this.instance.set({
          page: pageNumber
        });
        return this;
      }
    });
    return {
      init: function() {
        var Controller;
        Controller = new SearchController();
        Backbone.history.start();
        return console.log('Started');
      }
    };
  };
  $(function() {
    return SearchApp().init();
  });
}).call(this);
