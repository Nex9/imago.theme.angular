class SimplePage extends Controller

  constructor: (promiseData) ->
    for asset in promiseData
      console.log '@data SimplePage', @data = asset
      break
