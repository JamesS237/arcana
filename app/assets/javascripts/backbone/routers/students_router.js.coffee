class Arcana.Routers.StudentsRouter extends Backbone.Router
  initialize: (options) ->
    @students = new Arcana.Collections.StudentsCollection()
    @students.reset options.students

  routes:
    "new"      : "newStudent"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newStudent: ->
    @view = new Arcana.Views.Students.NewView(collection: @students)
    $("#students").html(@view.render().el)

  index: ->
    @view = new Arcana.Views.Students.IndexView(students: @students)
    $("#students").html(@view.render().el)

  show: (id) ->
    student = @students.get(id)

    @view = new Arcana.Views.Students.ShowView(model: student)
    $("#students").html(@view.render().el)

  edit: (id) ->
    student = @students.get(id)

    @view = new Arcana.Views.Students.EditView(model: student)
    $("#students").html(@view.render().el)
