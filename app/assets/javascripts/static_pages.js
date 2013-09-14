$(document).ready(function () {	
	$('#custom-search-form').submit(function () {
		window.location = '/results#/filter/' + $('#search-main').val();
		return false;
	});
});