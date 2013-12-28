$(document).ready(function () {	
	$(document).keyup(function (e) {
		if(e.which === 191)
		{
			$('#search-main').focus();
		}
	});
});