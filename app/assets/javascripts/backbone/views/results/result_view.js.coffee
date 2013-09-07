Arcana.Views.Results ||= {}

class Arcana.Views.Results.ResultView extends Backbone.View
  template: JST["backbone/templates/results/result"]

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
