$(document).ready(function() {
  $(window).keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
});

var arcana = angular.module('arcana', ['ngRoute', 'ngResource']);

arcana.controller('ResultsCtrl', ['$scope', '$resource', 'focus', function ($scope, $resource, focus) {
	var Result = $resource('/results/:id.json', {id:'@id'});
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
		Result.save($scope.result, function(data) {
		  window.location.reload();
		}, function(err) {
		  alert("Error: \"" + e.message + "\" occured when trying to delete the result!")
		});
	};

  $scope.deleteResult = function(result) {
    $scope.results.splice($scope.results.indexOf(result), 1);
    Result.delete({id: result.id});
  };

	$scope.showEditor = function (clickedResult) {
		if(clickedResult.student.id === $scope.userId) {
			$scope.results[$scope.results.indexOf(clickedResult)].editMode = true;
    		focus('focusMe');
		}
	};
	$scope.hideEditor = function (clickedResult) {
		$scope.results[$scope.results.indexOf(clickedResult)].editMode = false;
		$scope.results[$scope.results.indexOf(clickedResult)].$save();
	};
}]).directive('ngBlur', function() {
  return function( scope, elem, attrs ) {
    elem.bind('blur', function() {
      scope.$apply(attrs.ngBlur);
    });
  };
}).directive('focusOn', function() {
   return function(scope, elem, attr) {
      scope.$on('focusOn', function(e, name) {
        if(name === attr.focusOn) {
          elem[0].focus();
        }
      });
   };
}).factory('focus', ['$rootScope', '$timeout', function ($rootScope, $timeout) {
  return function(name) {
    $timeout(function (){
      $rootScope.$broadcast('focusOn', name);
    });
  }
}]).controller('AssessmentsCtrl', ['$scope', '$resource', 'focus', function ($scope, $resource, focus) {
	var Assessment = $resource('/assessments/:assessmentId.json', {assessmentId:'@id'});
	$scope.assessments = Assessment.query();
	$scope.averageBetween = function (assessment) {
		if($scope.maxAverage && $scope.minAverage) {
			return assessment.average <= $scope.maxAverage && assessment.average >= $scope.minAverage;
		} else if ($scope.maxAverage) {
			return assessment.average <= $scope.maxAverage;
		} else if ($scope.minAverage) {
			return assessment.average >= $scope.minAverage;
		} else {
			return true;
		}
	};
}]);

