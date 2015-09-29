dest = 'public'
src  = 'app'

targets =
  css     : 'application.css'
  customCss : 'custom.css'
  js      : 'application.js'
  jade    : 'templates.js'
  scripts : 'scripts.js'
  coffee  : 'coffee.js'

paths =
  index: 'public/index.jade'
  sketch: 'app/*.sketch'
  sass: ['app/index.sass']
  customSass : 'app/custom.sass'
  coffee: [
    "#{src}/**/*.coffee"
  ]
  js: ["#{src}/scripts.js"]
  jade: [
    "#{src}/**/*.jade"
  ]
  libs: [
    # required
    "bower_components/fastclick/lib/fastclick.js"
    "bower_components/polyfill-Number.toLocaleString-with-Locales/polyfill.number.toLocaleString.js"
    "bower_components/lodash/lodash.js"
    "bower_components/bowser/bowser.js"
    "bower_components/angular/angular.js"
    "bower_components/angular-animate/angular-animate.js"
    "bower_components/angular-touch/angular-touch.js"
    "bower_components/angular-ui-router/release/angular-ui-router.js"
    "bower_components/angulartics/dist/angulartics.min.js"
    "bower_components/angulartics-google-analytics/lib/angulartics-google-analytics.js"
    "bower_components/angular-elastic/elastic.js"
    "bower_components/angular-inview/angular-inview.js"

    # imago
    "bower_components/imago/dist/core.js"
    "bower_components/imago/dist/events.js"
    "bower_components/imago/dist/imago-image.js"
    "bower_components/imago/dist/imago-video.js"
    "bower_components/imago/dist/imago-slider.js"
    "bower_components/imago/dist/imago-blog.js"
    "bower_components/imago/dist/imago-social.js"
    "bower_components/imago/dist/imago-filters.js"
    "bower_components/imago/dist/imago-submit.js"
    "bower_components/imago/dist/imago-form.js"
    "bower_components/imago/dist/imago-ecommerce.js"
    "bower_components/imago/dist/imago-contact.js"

    # cutsom
    "bower_components/moment/moment.js"
    "bower_components/angular-moment/angular-moment.js"
    "bower_components/headroom.js/dist/headroom.js"
    "bower_components/headroom.js/dist/angular.headroom.js"
    "bower_components/angular-scroll/angular-scroll.js"
  ]

configGulp =
  src     : src
  dest    : dest
  targets : targets
  paths   : paths

module.exports = configGulp
