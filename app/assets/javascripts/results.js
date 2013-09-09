var Arcana = Arcana || {};

Arcana.Result = Backbone.Model.extend({
	url: '/results',
	paramRoot: 'result',
  defaults: {
    id: null,
    mark: null,
    student_name: null,
    assessment_name: null,
    assessment_id: null,
    student_id: null
    
  },

  idAttribute: 'id'
});

Arcana.ResultsCollection = Backbone.Collection.extend({
  model: Arcana.Result,
  url: '/results'
});

Arcana.ResultView = Backbone.View.extend({
  tagName: 'tr',
  template: '<td><%= student_name %></td><td><%= assessment_name %></td><td><%= mark %></td><td></td>',

  events: {
    //'dblclick tr': 'editResult'
  },

  deleteResult: function() {
    this.model.destroy();

    this.remove();
  },

  render: function() {
  	
    
    var tmpl = _.template( this.template );
    

    this.$el.html( tmpl( this.model.toJSON() ) );

    return this;
  }
});

Arcana.IndexView = Backbone.View.extend({
  el: $( '#results-special' ),
  
  initialize: function() {
    this.collection = new Arcana.ResultsCollection();
    var that = this;
    this.collection.fetch({success: function(){
   		that.render();
   	}});
 

    //this.listenTo( this.collection, 'add', this.renderResult );
    //this.listenTo( this.collection, 'reset', this.render );
  },

  events: {
    //'click .result-submit': 'addResult'
  },

  addResult: function( e ) {
	newResult =  new Arcana.Result();
	newResult.set( { mark: $('input[name="result[mark]"]').val(), assessment_id: $('#result_assessment_id').val()} );
	newResult.save(null, {success: refreshView});
	return false;
  },

  render: function() {
    this.collection.each(function( item ) {
      this.renderResult( item );
    }, this );
  },

  renderResult: function( item ) {
	console.log(item);
    var resultView = new Arcana.ResultView({
      model: item
    });
    $('.res-table').append( resultView.render().el );
  }
});

$(function (){
  var indView = new Arcana.IndexView();
  $('.result-submit').click(indView.addResult);
});

function refreshView () {
	var indView = new Arcana.IndexView();
}

