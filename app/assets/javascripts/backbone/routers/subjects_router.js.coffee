class Arcana.Routers.SubjectsRouter extends Backbone.Router
  initialize: (options) ->
    @subjects = new Arcana.Collections.SubjectsCollection()
    @subjects.reset options.subjects

  routes:
    "new"      : "newSubject"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSubject: ->
    @view = new Arcana.Views.Subjects.NewView(collection: @subjects)
    $("#subjects").html(@view.render().el)

  index: ->
    @view = new Arcana.Views.Subjects.IndexView(subjects: @subjects)
    $("#subjects").html(@view.render().el)

  show: (id) ->
    subject = @subjects.get(id)

    @view = new Arcana.Views.Subjects.ShowView(model: subject)
    $("#subjects").html(@view.render().el)

  edit: (id) ->
    subject = @subjects.get(id)

    @view = new Arcana.Views.Subjects.EditView(model: subject)
    $("#subjects").html(@view.render().el)
