Arcana.Views.Assessments ||= {}

class Arcana.Views.Assessments.AssessmentView extends Backbone.View
  template: JST["backbone/templates/assessments/assessment"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
