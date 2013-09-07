Arcana.Views.Assessments ||= {}

class Arcana.Views.Assessments.EditView extends Backbone.View
  template : JST["backbone/templates/assessments/edit"]

  events :
    "submit #edit-assessment" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (assessment) =>
        @model = assessment
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
