dest = 'public'
src  = 'app'

targets =
  css     : 'application.css'
  js      : 'application.js'
  jsMin   : 'application.min.js'
  jade    : 'templates.js'
  lib     : 'libs.js'
  scripts : 'scripts.js'
  coffee  : 'coffee.js'
  modules : 'modules.js'

paths =
  sass: ['css/index.sass']
  coffee: [
    "#{src}/**/*.coffee"
  ]
  js: ["#{src}/scripts.js"]
  jade: [
    "#{src}/**/*.jade"
  ]
  libs: [
    "lib/bower_components/angular/angular.js"
    "lib/bower_components/angular-animate/angular-animate.js"
    "lib/bower_components/angular-touch/angular-touch.js"
    "lib/bower_components/angular-ui-router/release/angular-ui-router.js"
    "lib/bower_components/lodash/dist/lodash.js"
    "lib/bower_components/imago.widgets.angular/dist/imago.widgets.angular.js"
  ]

configGulp =
  src     : src
  dest    : dest
  targets : targets
  paths   : paths

module.exports = configGulp