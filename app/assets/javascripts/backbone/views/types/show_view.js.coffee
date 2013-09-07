Arcana.Views.Types ||= {}

class Arcana.Views.Types.ShowView extends Backbone.View
  template: JST["backbone/templates/types/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
