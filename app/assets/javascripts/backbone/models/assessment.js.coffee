class Arcana.Models.Assessment extends Backbone.Model
  paramRoot: 'assessment'

  defaults:
    subject_id: null
    type_id: null
    title: null
    exam: null

class Arcana.Collections.AssessmentsCollection extends Backbone.Collection
  model: Arcana.Models.Assessment
  url: '/assessments'
