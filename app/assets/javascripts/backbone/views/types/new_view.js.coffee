Arcana.Views.Types ||= {}

class Arcana.Views.Types.NewView extends Backbone.View
  template: JST["backbone/templates/types/new"]

  events:
    "submit #new-type": "save"

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
      success: (type) =>
        @model = type
        window.location.hash = "/#{@model.id}"

      error: (type, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
