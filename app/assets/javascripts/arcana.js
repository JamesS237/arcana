var arcana = angular.module('arcana', ['ngRoute', 'ngResource']);

arcana.controller('ResultsCtrl', function ($scope, $resource) {
	var Result = $resource('/results/:resultId.json', {resultId:'@id'});
	$scope.results = Result.query();
});