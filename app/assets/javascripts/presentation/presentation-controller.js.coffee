@PresentationController = ($scope, $http) ->
  $scope.presentation = new Presentation('192.168.0.6:8080',
    'http://192.168.0.6:9292/presentations/integration-tests/', $http)
  $scope.presentation.initPresentation()