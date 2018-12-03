class Home extends Controller

  constructor: (promiseData, @$timeout) ->
    return unless promiseData
    if promiseData.length == 1
      for asset in promiseData
        @data = asset
    else
      @data = promiseData


    # calc lat lng cause needs to be assignable on map drag    for asset in @data.asset
    for asset in @data.assets
      if asset.types[0] is 'map'
        # map settings
        if asset.fields.address
          asset.fields.address.latlng =
            latitude:  asset.fields.address.value.lat
            longitude: asset.fields.address.value.lng
        # markers
        asset.markers = []
        for marker in asset.assets
          iconurl = if marker.fields.color?.value is 'green' then 'https://jce.imago.io/jce/latest/i/mapicon-green.png' else 'https://jce.imago.io/jce/latest/i/mapicon-red.png'
          # console.log 'iconurl', iconurl
          asset.markers.push
            latitude:  marker.fields.address.value.lat
            longitude: marker.fields.address.value.lng
            idKey: marker._id
            coords:
              lat: marker.fields.address.value.lat
              lng: marker.fields.address.value.lng
            events:"page.eventsMarker"
            dragable: false
            options:
              animation:4
            icon:
              url: iconurl



  sectionInview: (inview, section) ->
    # console.log 'inview, section', inview, section.name
    return if !inview or section.inview
    section.inview = true


  eventsMarker:
    click: (evt) ->
      alert('open')
      # window.open 'https://goo.gl/maps/fEr9AcE3GQp', '_blank'
