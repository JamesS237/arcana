Arcana.Views.Results ||= {}

class Arcana.Views.Results.NewView extends Backbone.View
  template: JST["backbone/templates/results/new"]

  events:
    "submit #new-result": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (result) =>
        @model = result
        window.location.hash = "/#{@model.id}"

      error: (result, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
