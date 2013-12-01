var arcana = angular.module('arcana', ['ngRoute', 'ngResource']);

arcana.controller('ResultsCtrl', function ($scope, $resource) {
	var Result = $resource('/results/:resultId.json', {resultId:'@id'});
	$scope.results = Result.query();
	$scope.markBetween = function (result) {
		if($scope.maxMark && $scope.minMark) {
			return result.mark <= $scope.maxMark && result.mark >= $scope.minMark;			
		} else if ($scope.maxMark) {
			return result.mark <= $scope.maxMark;			
		} else if ($scope.minMark) {
			return result.mark >= $scope.minMark;			
		} else {
			return true;
		}
	};
});