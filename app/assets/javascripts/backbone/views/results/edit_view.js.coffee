Arcana.Views.Results ||= {}

class Arcana.Views.Results.EditView extends Backbone.View
  template : JST["backbone/templates/results/edit"]

  events :
    "submit #edit-result" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (result) =>
        @model = result
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
