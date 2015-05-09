class Instagram extends Directive

  constructor: ($http, $parse, imagoSettings) ->

    return {

      templateUrl: '/app/directives/views/instagram.html'
      controllerAs: 'instagram'
      controller: ($scope, $element, $attrs) ->

        request = =>
          options = $scope.$eval($attrs.instagram)
          $http.post("#{imagoSettings.host}/api/social/instagram/feed", options).then (response) =>
            @data = response.data
            console.log '@data.length', @data.length
            for item in @data
              item.style =
                'background-image' : "url(#{item.images.standard_resolution.url})"
                'top'              : "#{_.random(-150, 150)}px"
                'left'             : "#{_.random(-150, 150)}px"

        watcher = $scope.$watch $attrs.instagram, (news, old) ->
          return if angular.equals news, old
          request()
          watcher()

    }