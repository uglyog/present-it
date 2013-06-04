@ConnectFormController = ($scope) ->
  $scope.channelAddress ?= ''
  $scope.connectDescription = 'Connect'

  $scope.connectChannel = ->
    if $scope.connectDescription == 'Disconnect'
      $scope.controller.disconnect()
      $scope.connecting = false
      $scope.connectDescription = 'Connect'
    else
      $scope.connecting = true
      $scope.controller.connectToPresentation($scope.channelAddress)
        .done ->
          $scope.connecting = false
          $scope.connectDescription = 'Disconnect'
          $scope.$digest()
        .fail ->
          $scope.connecting = false
          $scope.connectDescription = 'Connect'
          $scope.$digest()
          $('.alerts').append('<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">&times;</button><strong>Error!</strong> Failed to connect to ' +
            $scope.channelAddress + '.</div>')
