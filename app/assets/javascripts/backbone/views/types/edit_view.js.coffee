Arcana.Views.Types ||= {}

class Arcana.Views.Types.EditView extends Backbone.View
  template : JST["backbone/templates/types/edit"]

  events :
    "submit #edit-type" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (type) =>
        @model = type
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
