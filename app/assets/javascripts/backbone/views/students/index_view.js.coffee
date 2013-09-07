Arcana.Views.Students ||= {}

class Arcana.Views.Students.IndexView extends Backbone.View
  template: JST["backbone/templates/students/index"]

  initialize: () ->
    @options.students.bind('reset', @addAll)

  addAll: () =>
    @options.students.each(@addOne)

  addOne: (student) =>
    view = new Arcana.Views.Students.StudentView({model : student})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(students: @options.students.toJSON() ))
    @addAll()

    return this
