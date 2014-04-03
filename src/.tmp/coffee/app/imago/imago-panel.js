app.factory('imagoPanel', function($http, $log, imagoUtils) {
  return {
    getData: function(query) {
      if (!query) {
        return $log("Panel: query is empty, aborting " + query);
      }
      if (angular.isString(query)) {
        this.query = [
          {
            path: query
          }
        ];
      } else if (angular.isArray(query)) {
        this.query = query;
      } else if (iangular.isObject(query)) {
        this.query = [query];
      } else {
        return $log('Panel: no valid query');
      }
      this.promises = [];
      this.data = [];
      return angular.forEach(this.query, function(value, key) {
        return this.promises.push($http.post(this.query));
      });
    }
  };
});
