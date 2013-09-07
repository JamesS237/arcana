class Arcana.Models.Result extends Backbone.Model
  paramRoot: 'result'

  defaults:
    student_id: null
    assessment_id: null
    mark: null

class Arcana.Collections.ResultsCollection extends Backbone.Collection
  model: Arcana.Models.Result
  url: '/results'
