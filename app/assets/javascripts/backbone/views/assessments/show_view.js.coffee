Arcana.Views.Assessments ||= {}

class Arcana.Views.Assessments.ShowView extends Backbone.View
  template: JST["backbone/templates/assessments/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
