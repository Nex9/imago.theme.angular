app.controller('HelloWorld', function($scope, $http, imagoUtils, imagoPanel) {
  var mockup;
  $scope.message = 'Test';
  mockup = [
    {
      "serving_url": "http://lh5.ggpht.com/tWQC6pDQlM5_T10ffd2mI3Evg8SXtDsZQtwHPtFu4r1RJPjDmpCdG3kossSRtbChXllEU0JidR4mlgmtmA",
      "kind": "Image",
      "name": "BILLY BOB THORTON LIFE COVER",
      "normname": "billy-bob-thorton-life-cover",
      "contained_in": [],
      "meta": {
        "headline": {
          "value": ""
        },
        "title": {
          "value": ""
        },
        "description": {
          "value": ""
        },
        "creator": {
          "value": ""
        }
      },
      "path": "/portraits/billy-bob-thorton/billy-bob-thorton-life-cover",
      "date_created": "1390254856",
      "variants": [],
      "canonical": "Collection-34645e4b-5607-1c93-ec67-b98d78e3c897",
      "resolution": "836x1026",
      "id": "32167622-a5a2-6958-b1c6-30f2c96a16ab",
      "localsettings": {}
    }, {
      "serving_url": "http://lh4.ggpht.com/plJiN08IZRrHwDHdP4euAfHxpHVwnWKDahl-TurUljEnOUkNXH4gZ_mV2R7BkktJjCaNRGWIcFxjZ54hf9w",
      "kind": "Image",
      "name": "BILLY BOB THORTON LIFE COVER",
      "normname": "billy-bob-thorton-life-cover",
      "contained_in": [],
      "meta": {
        "headline": {
          "value": ""
        },
        "title": {
          "value": ""
        },
        "description": {
          "value": ""
        },
        "creator": {
          "value": ""
        }
      },
      "path": "/portraits/billy-bob-thorton/billy-bob-thorton-life-cover",
      "date_created": "1390254856",
      "variants": [],
      "canonical": "Collection-34645e4b-5607-1c93-ec67-b98d78e3c897",
      "resolution": "836x1026",
      "id": "32167622-a5a2-6958-b1c6-30f2c96a16ab",
      "localsettings": {}
    }, {
      "serving_url": "http://lh6.ggpht.com/e2TWWzOPwwCE6QSoo-YZHo_sQ7fk7cdhO13sRnjtVCP0sLVYCkDIyiyjemkZHxz8Mvqcboj_pPUg1XGZ8A",
      "kind": "Image",
      "name": "BILLY BOB THORTON LIFE COVER",
      "normname": "billy-bob-thorton-life-cover",
      "contained_in": [],
      "meta": {
        "headline": {
          "value": ""
        },
        "title": {
          "value": ""
        },
        "description": {
          "value": ""
        },
        "creator": {
          "value": ""
        }
      },
      "path": "/portraits/billy-bob-thorton/billy-bob-thorton-life-cover",
      "date_created": "1390254856",
      "variants": [],
      "canonical": "Collection-34645e4b-5607-1c93-ec67-b98d78e3c897",
      "resolution": "836x1026",
      "id": "32167622-a5a2-6958-b1c6-30f2c96a16ab",
      "localsettings": {}
    }
  ];
  $scope.assets = mockup;
  return imagoPanel.getData({
    'path': '/exhibitions'
  });
});
