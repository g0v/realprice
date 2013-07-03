angular.module 'app.controllers' <[ui.state]>
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

