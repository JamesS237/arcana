Arcana.Views.Assessments ||= {}

class Arcana.Views.Assessments.NewView extends Backbone.View
  template: JST["backbone/templates/assessments/new"]

  events:
    "submit #new-assessment": "save"

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
      success: (assessment) =>
        @model = assessment
        window.location.hash = "/#{@model.id}"

      error: (assessment, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
