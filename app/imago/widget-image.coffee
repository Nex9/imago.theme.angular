app.factory 'widgetImage', ($log) ->

  defaults:
    align     : 'center center'
    sizemode  : 'fit'              # fit, crop
    hires     : true
    scale     : 1
    lazy      : true
    maxSize   : 2560
    noResize  : false
    mediasize : false
    width     : 'auto'
    height    : 'auto'

  angular.forEach defaults, (value, key) ->
    @[key] = value

  return $log 'Error: image widget rquires src' unless @src
  return $log 'Error: image widget rquires resolution' unless @resolution