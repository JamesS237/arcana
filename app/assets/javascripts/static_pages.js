$(document).ready(function () {	
	$('#custom-search-form').submit(function () {
		window.location = '/results#/filter/' + $('#search-main').val();
		return false;
	});
	$(document).keyup(function (e) {
		if(e.which === 191)
		{
			$('#search-main').focus();
		}
	});
});