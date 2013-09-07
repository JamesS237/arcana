Arcana.Views.Assessments ||= {}

class Arcana.Views.Assessments.IndexView extends Backbone.View
  template: JST["backbone/templates/assessments/index"]

  initialize: () ->
    @options.assessments.bind('reset', @addAll)

  addAll: () =>
    @options.assessments.each(@addOne)

  addOne: (assessment) =>
    view = new Arcana.Views.Assessments.AssessmentView({model : assessment})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(assessments: @options.assessments.toJSON() ))
    @addAll()

    return this
