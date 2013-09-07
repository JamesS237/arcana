Arcana.Views.Students ||= {}

class Arcana.Views.Students.EditView extends Backbone.View
  template : JST["backbone/templates/students/edit"]

  events :
    "submit #edit-student" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (student) =>
        @model = student
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
