class Arcana.Models.Student extends Backbone.Model
  paramRoot: 'student'

  defaults:
    house: null
    admin: null
    first_name: null
    last_name: null

class Arcana.Collections.StudentsCollection extends Backbone.Collection
  model: Arcana.Models.Student
  url: '/students'
