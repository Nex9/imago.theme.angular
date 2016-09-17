class Locations extends Controller

  constructor: (promiseData, $timeout) ->

    @mapCenter =
      latitude:  40.719211
      longitude: -74.005135

    @markerOptions =
      icon: "https://lh3.googleusercontent.com/hvXzeYLmmrVV1Qq_2rotjOqb_g_qCctwDU3oKJaHWdbrdd9lSU1m_KKLFyMYpW2ghSd3gQSE892K7298UYBybns=s32"

    @loaded = false
    @getCurrentLocation()

    @markers = []

    # @loaded = true


    for asset in promiseData
      @data = asset
      for loc in @data.assets
        if loc.fields.address
          @markers.push
            id:          loc._id
            title:       loc.fields.title.value
            description: loc.fields.description.value
            coords:
              latitude:    loc.fields.address.value.lat
              longitude:   loc.fields.address.value.lng
      break

    $timeout =>
      @loaded = true
    , 1000

  getCurrentLocation: =>
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (loc) =>
        @mapCenter =
          latitude:  loc.coords.latitude
          longitude: loc.coords.longitude




  eventsMarker:
    click: (evt) ->
      window.open evt.map.mapUrl, '_blank'
