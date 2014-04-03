app.factory('widgetImage', function($log) {
  ({
    defaults: {
      align: 'center center',
      sizemode: 'fit',
      hires: true,
      scale: 1,
      lazy: true,
      maxSize: 2560,
      noResize: false,
      mediasize: false,
      width: 'auto',
      height: 'auto'
    }
  });
  angular.forEach(defaults, function(value, key) {
    return this[key] = value;
  });
  if (!this.src) {
    return $log('Error: image widget rquires src');
  }
  if (!this.resolution) {
    return $log('Error: image widget rquires resolution');
  }
});
