class Arcana.Routers.AssessmentsRouter extends Backbone.Router
  initialize: (options) ->
    @assessments = new Arcana.Collections.AssessmentsCollection()
    @assessments.reset options.assessments

  routes:
    "new"      : "newAssessment"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAssessment: ->
    @view = new Arcana.Views.Assessments.NewView(collection: @assessments)
    $("#assessments").html(@view.render().el)

  index: ->
    @view = new Arcana.Views.Assessments.IndexView(assessments: @assessments)
    $("#assessments").html(@view.render().el)

  show: (id) ->
    assessment = @assessments.get(id)

    @view = new Arcana.Views.Assessments.ShowView(model: assessment)
    $("#assessments").html(@view.render().el)

  edit: (id) ->
    assessment = @assessments.get(id)

    @view = new Arcana.Views.Assessments.EditView(model: assessment)
    $("#assessments").html(@view.render().el)
