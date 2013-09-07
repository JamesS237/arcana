Arcana.Views.Results ||= {}

class Arcana.Views.Results.IndexView extends Backbone.View
  template: JST["backbone/templates/results/index"]

  initialize: () ->
    @options.results.bind('reset', @addAll)

  addAll: () =>
    @options.results.each(@addOne)

  addOne: (result) =>
    view = new Arcana.Views.Results.ResultView({model : result})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(results: @options.results.toJSON() ))
    @addAll()

    return this
