@MainController = ($scope) ->
  window.scope = $scope

  $scope.controller = new Controller($scope)
  $scope.connected = false

  $scope.requestInfo = -> $scope.controller.requestPresentationInfo()

  $scope.startPresentation = -> $scope.controller.startPresentation()
  $scope.backSlide = -> $scope.controller.backSlide()
  $scope.forwardSlide = -> $scope.controller.forwardSlide()
  $scope.gotoSlide = -> $scope.controller.gotoSlide($scope.jumpToPage)

  $scope.$watch 'controller.presentationInfo.selectedPresentation', (value) -> $scope.controller.selectPresentation() if value?

