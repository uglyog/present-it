@ConnectFormController = ($scope, $location) ->
  $scope.channelAddress ?= $location.host() + ':8080'
  $scope.connectDescription = 'Connect'

  $scope.connectChannel = ->
    if $scope.$parent.connected
      $scope.controller.disconnect()
      $scope.connecting = false
      $scope.$parent.connected = false
      $scope.connectDescription = 'Connect'
    else
      $scope.connecting = true
      $scope.controller.connectToPresentation($scope.channelAddress)
        .done ->
          $scope.connecting = false
          $scope.$parent.connected = true
          $scope.connectDescription = 'Disconnect'
          $scope.$parent.$digest()
        .fail ->
          $scope.connecting = false
          $scope.$parent.connected = false
          $scope.connectDescription = 'Connect'
          $scope.$digest()
          $('.alerts').append(
            """<div class="alert alert-error">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Error!</strong>
                Failed to connect to #{$scope.channelAddress}.
              </div>
            """)
