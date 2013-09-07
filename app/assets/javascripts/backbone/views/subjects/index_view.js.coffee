Arcana.Views.Subjects ||= {}

class Arcana.Views.Subjects.IndexView extends Backbone.View
  template: JST["backbone/templates/subjects/index"]

  initialize: () ->
    @options.subjects.bind('reset', @addAll)

  addAll: () =>
    @options.subjects.each(@addOne)

  addOne: (subject) =>
    view = new Arcana.Views.Subjects.SubjectView({model : subject})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(subjects: @options.subjects.toJSON() ))
    @addAll()

    return this
