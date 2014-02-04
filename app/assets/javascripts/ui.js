$(document).ready(function () {
	$(document).keyup(function (e) {
		if(e.which === 191) {
			$('#search-main').focus();
		}
	});
	if ($('ul[data-type="assessments"]').children().length > $('ul[data-type="subjects"]').children().length
	 && $('ul[data-type="assessments"]').children().length > $('ul[data-type="students"]').children().length) {
		var longest = 'assessments';
	} else if ($('ul[data-type="subjects"]').children().length > $('ul[data-type="assessments"]').children().length &&
			   $('ul[data-type="subjects"]').children().length > $('ul[data-type="students"]').children().length) {
		var longest = 'subjects'; //if guides is the longest search result, set it
	} else {
		var longest = 'students'; //if messages is the longest search result, set it
	}

	$('ul[data-type]').hide(); //hide all search result types
	$('ul[data-type=' + longest + ']').show(); //show the type that has the most results
	$("a[data-view-type=" + longest + "]").addClass('link-highlight'); //add the active color to that type's link

	$("a[data-view-type]").on('click', function() { //when a type link is clicked
		$('ul[data-type]').hide(); //hide all search result types
		$("a[data-view-type]").removeClass('link-highlight'); //remove the active color from all type links
		$('ul[data-type=' + $(this).data('view-type') + ']').show(); //display the correct search result type
		$(this).addClass('link-highlight'); //add the active color to that the clicked link
	});
});

$(window).load(function(){
  $('.select2_assessment_chooser').select2({
      placeholder: "Select an assessment",
      allowClear: true
  });
});

$(window).keydown(function(e) {
  if(e.which == 191) {
    $("#search").focus()
  }
});
