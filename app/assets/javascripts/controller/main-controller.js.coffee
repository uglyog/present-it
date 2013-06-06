@MainController = ($scope) ->
  window.scope = $scope

  $scope.controller = new Controller($scope)
  $scope.connected = false

  $scope.requestInfo = -> $scope.controller.requestPresentationInfo()

  $scope.startPresentation = -> $scope.controller.startPresentation()
  $scope.backSlide = -> $scope.controller.backSlide()
  $scope.forwardSlide = -> $scope.controller.forwardSlide()
