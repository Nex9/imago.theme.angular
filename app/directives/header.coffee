class Header extends Directive

  constructor: ($location, $timeout, $rootScope) ->

    return {
      templateUrl: '/app/directives/views/header.html'
      controller: ($scope, $element, $attrs) ->
        links = $element.find("a")
        onClass = "active"
        currentLink = undefined
        urlMap = {}
        $rootScope.navActive = false

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
          $scope.active = false
          $rootScope.navActive = false
          # console.log pathLink[0]
          if pathLink
            currentLink.removeClass onClass  if currentLink
            currentLink = pathLink
            currentLink.addClass onClass
          else if path is "/" and currentLink
            currentLink.removeClass onClass

      link: (scope, element, attrs) ->

        scope.active = false

        scope.activate = () ->
          scope.active = !scope.active
          $rootScope.navActive = !$rootScope.navActive
    }
