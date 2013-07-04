angular.module('partials', [])
.run(['$templateCache', function($templateCache) {
  return $templateCache.put('/partials/about.html', [
'<div class="about"><h1>This is pre-alpha!</h1></div>',''].join("\n"));
}])
.run(['$templateCache', function($templateCache) {
  return $templateCache.put('/partials/home.html', [
'<h1>成交均價(萬)</h1><div class="btn-group"><a ng-model="aggregate" btn-radio="\'price\'" class="btn">成交價</a><a ng-model="aggregate" btn-radio="\'unitprice\'" class="btn">單價</a></div><div resize="resize" class="leaflet aggregate-{{aggregate}}"><leaflet center="center" markers="markers" defaults="defaults" ng-style="{width:$parent.width,height:$parent.contentHeight}" height="800" testing="testing"></leaflet></div>',''].join("\n"));
}])
.run(['$templateCache', function($templateCache) {
  return $templateCache.put('/partials/nav.html', [
'<ul class="nav"><li><a ng-href="/">Home</a></li></ul><ul class="nav pull-right"><li ng-class="{ active: $state.includes(\'about\') }"><a ng-href="/about">About</a></li></ul>',''].join("\n"));
}]);