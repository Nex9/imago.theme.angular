class Shop extends Controller

  constructor: (promiseData) ->

    for data in promiseData
      @data = data
      break
