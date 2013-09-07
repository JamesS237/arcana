Arcana.Views.Students ||= {}

class Arcana.Views.Students.ShowView extends Backbone.View
  template: JST["backbone/templates/students/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
