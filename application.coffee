SearchApp = ->
  SearchModel = Backbone.Model.extend

  SearchAreaTemplate = _.template(
    "<a class='previous' href='#!/page/<%= parseInt(page) - 1 %>'>Previous page</a> " +
      "<span class='page'>Page: <%= page %></span> " +
      "<a class='next' href='#!/page/<%= parseInt(page) + 1 %>'>Next page</a>"
  )

  SearchAreaView = Backbone.View.extend(
    el: $('#search')

    initialize: ->
      this.render = _.bind(this.render, this)
      this.model.bind('change:page', this.render)
      this.layout = SearchAreaTemplate
      this

    render: ->
      content = this.layout(this.model.toJSON())

      $(this.el)
        .empty()
        .html(content)

      if parseInt(this.model.get('page')) > 1
        this.$(".previous").show()

      this
  )

  SearchCollection = Backbone.Collection.extend(
    initialize: (args) ->
      this
  )

  SearchController = Backbone.Controller.extend(
    routes:
      "": "welcome",
      "!/page/:pageNumber" : "page"

    initialize: (options) ->
      this.instance = new SearchModel(
        id: 1,
        page: 1
      )

      this.SearchArea = new SearchAreaView(
        model: this.instance
      )

      this.SearchArea.render()
      this

    welcome: ->
      this

    page: (pageNumber) ->
      this.instance.set(page: pageNumber)
      this
  )

  init: ->
    Controller = new SearchController()
    Backbone.history.start()
    console.log('Started')

$ ->
  SearchApp().init()
