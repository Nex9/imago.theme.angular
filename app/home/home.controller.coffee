class Home extends Controller

  constructor: (promiseData) ->
    for asset in promiseData
      @data = asset
      for asset in @data.assets
        if asset.types[0] is 'map'
          if asset.fields.address
            console.log 'asset.fields.address', asset.fields.address
            asset.fields.address.latlng =
              latitude:  asset.fields.address.value.lat
              longitude: asset.fields.address.value.lng
            asset.fields.address.center = _.clone asset.fields.address.latlng

      break


  eventsMarker:
    click: (evt) ->
      alert('open')
      # window.open 'https://goo.gl/maps/fEr9AcE3GQp', '_blank'
