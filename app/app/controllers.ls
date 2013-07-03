angular.module 'app.controllers' <[ui.state leaflet-directive]>
.controller AppCtrl: <[$scope $location $rootScope $timeout]> ++ (s, $location, $rootScope, $timeout) ->

  s <<< {$location}
  s.$watch '$location.path()' (activeNavId or '/') ->
    s <<< {activeNavId}

  s.getClass = (id) ->
    if s.activeNavId.substring 0 id.length is id
      'active'
    else
      ''

  <- $timeout _, 10s * 1000ms
  $rootScope.hideGithubRibbon = true

.controller Home: <[$scope $http]> ++ ($scope, $http) ->
  $scope <<< do
    markers: {}
    aggregate: 'price'
    defaults: do
      maxZoom: 17
      tileLayer: 'http://{s}.tile.cloudmade.com/ae2dc46faa384973b408b2467d727490/998/256/{z}/{x}/{y}.png'
    center: do
      lat: 25.05
      lng: 121.55
      zoom: 13
  data <- $http.get '/data/compact.json'
  .error -> console.log \err ...arguments
  .success
  console.log data.length
  map = delete $scope.$$childHead.leaflet.map
  markers = L.markerClusterGroup do
    singleMarkerMode: true
    iconCreateFunction: (cluster) ->
      childCount = cluster.getChildCount();
      children = cluster.getAllChildMarkers!
      avg = (children.map (.options.price) .reduce (+)) / childCount
      unitavg = (children.map (.options.unitprice) .reduce (+)) / childCount

      c = ' marker-cluster-';
      if childCount < 10
        c += 'small';
      else if childCount < 100
        c += 'medium';
      else
        c += 'large';

      avg = Math.round(avg / 10000)
      unitavg = Math.round(unitavg / 10000)
      new L.DivIcon do
        html: """<div class="aggregate-marker"><span class="price">#avg</span><span class="unitprice">#unitavg</span></div>"""
        className: 'marker-cluster' + c,
        iconSize: new L.Point(40, 40)
  markerList = []

  data.forEach ({address,pos,price,unitprice}) ->
    marker = L.marker (L.latLng ...pos), {title: address, price, unitprice}
    marker.bindPopup address
    markerList.push marker
    null

  markers.addLayers markerList

  map.addLayer markers

.directive 'resize' <[$window]> ++ ($window) ->
  (scope, element, attrs) ->
    refresh-size = ->
      scope.width = $window.innerWidth
      scope.height = $window.innerHeight
      scope.content-height = $window.innerHeight - $ element .offset!top

    angular.element $window .bind 'resize' ->
      scope.$apply refresh-size
      scope.$apply refresh-size

    refresh-size!
