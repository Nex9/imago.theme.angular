class Home extends Controller

  constructor: (promiseData) ->
    return unless promiseData
    if promiseData.length == 1
      for asset in promiseData
        @data = asset
    else
      @data = promiseData
    # calc lat lng cause needs to be assignable on map drag    for asset in @data.asset
    for asset in @data.assets
      if asset.types[0] is 'map'
        if asset.fields.address
          asset.fields.address.latlng =
            latitude:  asset.fields.address.value.lat
            longitude: asset.fields.address.value.lng




  eventsMarker:
    click: (evt) ->
      alert('open')
      # window.open 'https://goo.gl/maps/fEr9AcE3GQp', '_blank'
