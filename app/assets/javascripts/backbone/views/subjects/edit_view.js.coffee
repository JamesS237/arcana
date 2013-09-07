Arcana.Views.Subjects ||= {}

class Arcana.Views.Subjects.EditView extends Backbone.View
  template : JST["backbone/templates/subjects/edit"]

  events :
    "submit #edit-subject" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (subject) =>
        @model = subject
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
