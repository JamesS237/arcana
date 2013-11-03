function ready() {
  $(document).ready(function () {
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
		    student_id: null,
		    subject_name: null,
		    house_name: null,
		    type_name: null	    
		  },
		  idAttribute: 'id'
		});
		
		Arcana.refreshView = function () {
			_.each(indView.childViews, function(childView){ 
				childView.remove();	
			});
	 		indView = new Arcana.IndexView();
			indView.collection.sort();
			indView.render();
			indView.search();
		};	
		
		Arcana.ResultsCollection = Backbone.Collection.extend({
		  model: Arcana.Result,
		  url: '/results',
		  
			search : function(letters){
				if(letters == "") return this;		 
					var pattern = new RegExp(letters,"gi");
				return _(this.filter(function(data) {
				  	return pattern.test(data.get("assessment_name")) || pattern.test(data.get("student_name")) || pattern.test(data.get("subject_name")) || pattern.test(data.get("type_name")) || pattern.test(data.get("house_name") );
				}));
			}
		});
		
		Arcana.ResultView = Backbone.View.extend({
		  tagName: 'tr',
		  template: '<td><%= student_name %></td><td><%= house_name %></td><td><%= subject_name %></td><td><%= type_name %></td><td><%= assessment_name %></td><td id="edit-mark-<%= id %>"><%= mark %></td><td></td>',
		
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
		    this.childViews = [];
		    this.collection.fetch({success: function(){
		   		that.render();
		   	}});
		   	this.search();
		 
		  },
		  
	  	search: function(e) {
				var letters = $('.search-results').val();
				this.renderList(this.collection.search(letters));
			},
			
			renderList : function(results){
				_.each(this.childViews, function(childView){ 
				childView.remove();	
				});
		 		var that = this;
				results.each(function(result){
					that.renderResult(result);
				});
				return this;
			},
		
		  addResult: function( e ) {
			newResult =  new Arcana.Result();
			newResult.set( { mark: $('input[name="result[mark]"]').val(), assessment_id: $('#result_assessment_id').val()} );
			newResult.save(null, {success: Arcana.refreshView});
			$('option[value="' + $('#result_assessment_id').val() + '"]').remove();
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
		    
			var that = this;
		    
		    $('.res-table').append( resultView.render().el );
		    
		    if(item.get('current_user')) {
			    $('#edit-mark-' + item.id).on('dblclick', function () {
			    	var mark = $( this ).text();
					$( this ).html('<input type="text" value="' + mark + '" />'); 
					$( this ).attr('id', 'editing-mark-' + item.id);
					$( this ).children('input').focus();
					
					$('#editing-mark-' + item.id + ' > input').one('blur', function () {
						item.set('mark', $( this ).val());
						item.save(); 
						$( this ).replaceWith($( this ).val());
					});
				});
		    }
		
		  	this.childViews.push(resultView);
		  }
		});
		
		Arcana.ResultsRouter = Backbone.Router.extend({
			routes: {
				"sort/:field" : "sortResults",
				"filter/:value" : "filterResults"
			}
		});
		
		var indView;
		
		$(function (){
		  	indView = new Arcana.IndexView();
			var router = new Arcana.ResultsRouter;
			
			router.on('route:sortResults', function(field){
		  		indView.collection.comparator = function(model) {
		  			if(field == 'mark') {
		  				return -model.get(field);
		  			}
		  			
		  			else {
		  				return model.get(field + '_name');
		  			}
				};
				
				_.each(indView.childViews, function(childView){ 
					childView.remove();	
				});
				
				indView.collection.sort();
				indView.render();
				indView.search();
			});
			
			router.on('route:filterResults', function(value) {
				value = value.replace('-', ' ');
				$('.search-results').val(value);
				window.setTimeout(function () {indView.renderList(indView.collection.search(value));}, 200);
			});
			Backbone.history.start();
		  $('.result-submit').click(indView.addResult);
		
		$('.search-results').keyup(function () {
			indView.search();
		});
	});
	});
}

$(document).ready(ready);
$(document).on('page:load', ready);