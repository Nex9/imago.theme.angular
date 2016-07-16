class Instagram extends Directive

  constructor: ->

    return {
      templateUrl: '/app/social/instagram.html'
      controller: 'instagramController as instagram'
    }

class InstagramController extends Controller

  constructor: ($http, $scope, $attrs, imagoModel) ->

    request = =>
      options = $scope.$eval($attrs.instagram)
      $http.post("#{imagoModel.host}/api/social/instagram/feed", options).then (response) =>
        @data = response.data
        # console.log '@data.instagram', @data
        for item in @data
          item.style =
            'background-image' : "url(#{item.images.standard_resolution.url})"
            # 'top'              : "#{_.random(-150, 150)}px"
            # 'left'             : "#{_.random(-150, 150)}px"

    if $attrs.instagram
      request()
    else
      watcher = $scope.$watch $attrs.instagram, (news, old) ->
        return if angular.equals news, old
        request()
        watcher()
