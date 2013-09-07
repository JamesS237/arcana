class Arcana.Models.Type extends Backbone.Model
  paramRoot: 'type'

  defaults:
    name: null
    weight: null

class Arcana.Collections.TypesCollection extends Backbone.Collection
  model: Arcana.Models.Type
  url: '/types'
