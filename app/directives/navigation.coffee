class Navigation extends Directive

  constructor: ($location, $timeout, $urlRouter) ->

    return {
      replace: true
      transclude: true
      restrict: 'AE'
      templateUrl: '/app/directives/views/navigation.html'
      controller: ($scope, $element, $attrs, $transclude) ->
        links = $element.find("a")
        onClass = "active"
        currentLink = undefined
        urlMap = {}

        for l, i in links
          link = angular.element(links[i])
          url = link.attr("href")
          if $location.$$html5
            urlMap[url] = link
          else
            urlMap[url.replace("/^#[^/]*/", "")] = link

        $scope.$on "$locationChangeSuccess", ->
          path = $location.path()
          pathLink = urlMap[$location.path()]
          # console.log pathLink[0]
          if pathLink
            currentLink.removeClass onClass  if currentLink
            currentLink = pathLink
            currentLink.addClass onClass
          else if path is "/" and currentLink
            currentLink.removeClass onClass

        # $timeout(->
        #   $scope.showNav = true;
        # , 300)
        # $scope.showNav = true

        # $scope.hideNav = () ->
        #   $scope.showNav = false;
    }
