class Shop extends Controller

  constructor: ($scope, @imagoModel, @$location, @$state) ->

    @imagoModel.getData({path: "/shop", recursive: true}).then (response) =>
      for data in response
        @data = data
        console.log '@data', @data
        break

  # gotoProduct: (path) ->
  #   @$location.path(path)