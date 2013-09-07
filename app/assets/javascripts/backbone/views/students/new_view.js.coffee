Arcana.Views.Students ||= {}

class Arcana.Views.Students.NewView extends Backbone.View
  template: JST["backbone/templates/students/new"]

  events:
    "submit #new-student": "save"

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
      success: (student) =>
        @model = student
        window.location.hash = "/#{@model.id}"

      error: (student, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
