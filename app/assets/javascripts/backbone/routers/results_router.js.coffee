class Arcana.Routers.ResultsRouter extends Backbone.Router
  initialize: (options) ->
    @results = new Arcana.Collections.ResultsCollection()
    @results.reset options.results

  routes:
    "new"      : "newResult"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newResult: ->
    @view = new Arcana.Views.Results.NewView(collection: @results)
    $("#results").html(@view.render().el)

  index: ->
    @view = new Arcana.Views.Results.IndexView(results: @results)
    $("#results").html(@view.render().el)

  show: (id) ->
    result = @results.get(id)

    @view = new Arcana.Views.Results.ShowView(model: result)
    $("#results").html(@view.render().el)

  edit: (id) ->
    result = @results.get(id)

    @view = new Arcana.Views.Results.EditView(model: result)
    $("#results").html(@view.render().el)
