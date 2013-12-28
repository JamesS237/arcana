$(document).ready(function () {	
	$(document).keyup(function (e) {
		if(e.which === 191) {
			$('#search-main').focus();
		}
	});
	if ($('div[data-type="assessments"]').children().length > $('div[data-type="subjects"]').children().length 
	 && $('div[data-type="assessments"]').children().length > $('div[data-type="students"]').children().length) {
		var longest = 'assessments'; 
	} else if ($('div[data-type="subjects"]').children().length > $('div[data-type="assessments"]').children().length && 
			   $('div[data-type="subjects"]').children().length > $('div[data-type="students"]').children().length) {
		var longest = 'subjects'; //if guides is the longest search result, set it
	} else {
		var longest = 'students'; //if messages is the longest search result, set it
	}

	$('div[data-type]').hide(); //hide all search result types
	$('div[data-type=' + longest + ']').show(); //show the type that has the most results
	$("a[data-view-type=" + longest + "]").addClass('link-highlight'); //add the active color to that type's link

	$("a[data-view-type]").on('click', function() { //when a type link is clicked
	$('div[data-type]').hide(); //hide all search result types
	$("a[data-view-type]").removeClass('link-highlight'); //remove the active color from all type links
	$('div[data-type=' + $(this).data('view-type') + ']').show(); //display the correct search result type
	$(this).addClass('link-highlight'); //add the active color to that the clicked link
	});
});