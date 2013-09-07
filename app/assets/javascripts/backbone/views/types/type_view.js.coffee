Arcana.Views.Types ||= {}

class Arcana.Views.Types.TypeView extends Backbone.View
  template: JST["backbone/templates/types/type"]

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
