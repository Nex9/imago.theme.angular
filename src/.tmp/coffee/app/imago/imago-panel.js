app.factory('imagoPanel', function($http, imagoUtils) {
  return {
    search: function(query) {
      var params;
      params = this.objListToDict(query);
      return $http.post(this.getSearchUrl(), angular.toJson(params));
    },
    getData: function(query) {
      if (!query) {
        return console.log("Panel: query is empty, aborting " + query);
      }
      this.query = query;
      if (imagoUtils.toType(query) === 'string') {
        this.query = [
          {
            path: query
          }
        ];
      }
      this.query = this.toArray(this.query);
      this.promises = [];
      this.data = [];
      return angular.forEach(this.query, (function(_this) {
        return function(value, key) {
          return _this.promises.push(_this.search(_this.query).then((function(data) {
            console.log(data);
            return console.log(_this.promises);
          }), function(error) {
            return console.log(error);
          }));
        };
      })(this));
    },
    toArray: function(elem) {
      var type;
      type = imagoUtils.toType(elem);
      if (type !== 'object' && type !== 'string' && type !== ' array') {
        return console.log('Panel: no valid query');
      }
      if (imagoUtils.toType(elem) === 'array') {
        return elem;
      } else {
        return [elem];
      }
    },
    objListToDict: function(obj_or_list) {
      var querydict;
      querydict = {};
      if (angular.isArray(obj_or_list)) {
        angular.forEach(obj_or_list, function(elem, key) {
          return angular.forEach(elem, function(value, key) {
            value = elem[key];
            querydict[key] || (querydict[key] = []);
            return querydict[key].push(value);
          });
        });
      } else {
        angular.forEach(obj_or_list, function(value, key) {
          value = obj_or_list[key];
          return querydict[key] = angular.isArray(value) ? value : [value];
        });
      }
      angular.forEach(['page', 'pagesize'], function(value, key) {
        if (querydict.hasOwnProperty(key)) {
          return querydict[key] = querydict[key][0];
        }
      });
      return querydict;
    },
    getSearchUrl: function() {
      if (data === 'online' && debug) {
        return "http://" + tenant + ".ng.imagoapp.com/api/v2/search";
      } else {
        return "/api/v2/search";
      }
    }
  };
});
