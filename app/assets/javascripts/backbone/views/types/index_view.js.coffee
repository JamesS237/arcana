Arcana.Views.Types ||= {}

class Arcana.Views.Types.IndexView extends Backbone.View
  template: JST["backbone/templates/types/index"]

  initialize: () ->
    @options.types.bind('reset', @addAll)

  addAll: () =>
    @options.types.each(@addOne)

  addOne: (type) =>
    view = new Arcana.Views.Types.TypeView({model : type})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(types: @options.types.toJSON() ))
    @addAll()

    return this
