@MainController = ($scope) ->
  window.scope = $scope

  $scope.controller = new Controller($scope)
  $scope.connected = false

  $scope.requestInfo = -> $scope.controller.requestPresentationInfo()
