@ConnectFormController = ($scope, $q) ->
  $scope.channelAddress ?= ''
  $scope.connectDescription = 'Connect'

  $scope.connectChannel = ->
    $scope.connecting = true
    $scope.controller.connectToPresentation($scope.channelAddress, $q)
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
