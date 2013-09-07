class Arcana.Models.Subject extends Backbone.Model
  paramRoot: 'subject'

  defaults:
    name: null
    elective: null

class Arcana.Collections.SubjectsCollection extends Backbone.Collection
  model: Arcana.Models.Subject
  url: '/subjects'
