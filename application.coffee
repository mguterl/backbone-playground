SearchApp = ->

  templateFor = (name) ->
    _.template($("#template-" + name).html())

  SearchModel = Backbone.Model.extend(
    defaults:
      page: 1
      total: null
      results: []

    url: ->
      "/results?page=" + this.get('page')
  )

  SearchAreaTemplate = templateFor('search-area')

  SearchAreaView = Backbone.View.extend(
    el: $('#search')

    initialize: ->
      this.render = _.bind(this.render, this)
      this.model.bind('change', this.render)
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
      this.instance = new SearchModel()

      this.SearchArea = new SearchAreaView(
        model: this.instance
      )

      this.SearchArea.render()
      this

    welcome: ->
      this

    page: (pageNumber) ->
      this.instance.set(page: pageNumber)
      this.instance.fetch()
      this
  )

  init: ->
    Controller = new SearchController()
    Backbone.history.start()
    console.log('Started')

$ ->
  SearchApp().init()
