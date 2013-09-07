class Arcana.Routers.TypesRouter extends Backbone.Router
  initialize: (options) ->
    @types = new Arcana.Collections.TypesCollection()
    @types.reset options.types

  routes:
    "new"      : "newType"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newType: ->
    @view = new Arcana.Views.Types.NewView(collection: @types)
    $("#types").html(@view.render().el)

  index: ->
    @view = new Arcana.Views.Types.IndexView(types: @types)
    $("#types").html(@view.render().el)

  show: (id) ->
    type = @types.get(id)

    @view = new Arcana.Views.Types.ShowView(model: type)
    $("#types").html(@view.render().el)

  edit: (id) ->
    type = @types.get(id)

    @view = new Arcana.Views.Types.EditView(model: type)
    $("#types").html(@view.render().el)
