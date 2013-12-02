var arcana = angular.module('arcana', ['ngRoute', 'ngResource']);

arcana.controller('ResultsCtrl', function ($scope, $resource) {
	var Result = $resource('/results/:resultId.json', {resultId:'@id'});
	var Assessment = $resource('/assessments/:assessmentId.json', {assessmentId:'@id'});
	$scope.results = Result.query();
	$scope.userId = CURRENT_USER_ID
	$scope.authenticity_token = AUTH_TOKEN;
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
	$scope.addResult = function() {
		$scope.result.authenticity_token = $scope.authenticity_token
		Result.save($scope.result);
		setTimeout(function() {
			$scope.results = Result.query();
			$scope.result.mark = '';
			$scope.result.assessmentId = 0;
		}, 1000);
	}
});