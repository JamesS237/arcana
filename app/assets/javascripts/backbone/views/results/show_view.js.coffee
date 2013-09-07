Arcana.Views.Results ||= {}

class Arcana.Views.Results.ShowView extends Backbone.View
  template: JST["backbone/templates/results/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
