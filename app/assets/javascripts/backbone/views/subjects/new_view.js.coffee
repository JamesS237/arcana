Arcana.Views.Subjects ||= {}

class Arcana.Views.Subjects.NewView extends Backbone.View
  template: JST["backbone/templates/subjects/new"]

  events:
    "submit #new-subject": "save"

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
      success: (subject) =>
        @model = subject
        window.location.hash = "/#{@model.id}"

      error: (subject, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
