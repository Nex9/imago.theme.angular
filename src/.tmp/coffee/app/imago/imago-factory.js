app.factory('imagoPanel', function($http, imagoUtils) {
  return {
    getData: function(query) {
      if (!query) {
        return console.log("Panel: query is empty, aborting " + query);
      }
      if (imagoUtils.toType(query) === 'string') {
        return this.query = [
          {
            path: query
          }
        ];
      } else if (imagoUtils.toType(query) === 'array') {
        return this.query = query;
      } else if (imagoUtils.toType(query) === 'object') {
        return this.query = [query];
      } else {
        return console.log('Panel: no valid query');
      }
    }
  };
});
