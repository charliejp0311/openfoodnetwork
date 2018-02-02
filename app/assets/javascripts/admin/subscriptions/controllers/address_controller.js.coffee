angular.module("admin.standingOrders").controller "AddressController", ($scope, $filter, StatusMessage, availableCountries) ->
  $scope.countries = availableCountries
  $scope.statesFor = (country_id) ->
    return [] unless country_id
    $filter('filter')(availableCountries, {id: country_id})[0].states
  $scope.billStates = $scope.statesFor($scope.standingOrder.bill_address.country_id)
  $scope.shipStates = $scope.statesFor($scope.standingOrder.ship_address.country_id)

  $scope.registerNextCallback 'address', ->
    $scope.standing_order_form.$submitted = true
    if $scope.standing_order_address_form.$valid
      $scope.standing_order_form.$setPristine()
      StatusMessage.clear()
      $scope.setView('products')
    else
      StatusMessage.display 'failure', t('admin.standing_orders.details.invalid_error')

  $scope.registerBackCallback 'address', ->
    StatusMessage.clear()
    $scope.setView('details')

  $scope.$watch 'standingOrder.bill_address.country_id', (newValue, oldValue) ->
    $scope.billStates = $scope.statesFor(newValue) if newValue?

  $scope.$watch 'standingOrder.ship_address.country_id', (newValue, oldValue) ->
    $scope.shipStates = $scope.statesFor(newValue) if newValue?