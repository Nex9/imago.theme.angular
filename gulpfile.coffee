browserSync     = require 'browser-sync'

coffee          = require 'gulp-coffee'
coffeelint      = require 'gulp-coffeelint'

concat          = require 'gulp-concat'

gulp            = require 'gulp'

imagemin        = require 'gulp-imagemin'

jade            = require 'gulp-jade'
ngmin           = require 'gulp-ngmin'
ngClassify      = require('gulp-ng-classify')

protractor      = require("gulp-protractor").protractor
webdriver_standalone = require("gulp-protractor").webdriver_standalone

order           = require 'gulp-order'
plumber         = require 'gulp-plumber'
prefix          = require 'gulp-autoprefixer'

sass            = require 'gulp-ruby-sass'
templateCache   = require 'gulp-angular-templatecache'
uglify          = require 'gulp-uglify'
watch           = require 'gulp-watch'
gutil           = require 'gulp-util'
modRewrite      = require 'connect-modrewrite'
Notification    = require 'node-notifier'
notifier        = new Notification()


# Defaults

dest = 'public'
src = 'app'

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
    "!#{src}/bower_components/**/*.coffee"
    "#{src}/**/*.coffee"
  ]
  js: ["#{src}/scripts.js"]
  jade: [
    "!#{src}/bower_components/**/*.jade"
    "#{src}/**/*.jade"
  ]
  libs: [
    "#{src}/bower_components/angular/angular.js"
    "#{src}/bower_components/angular-animate/angular-animate.js"
    "#{src}/bower_components/angular-touch/angular-touch.js"
    "#{src}/bower_components/angular-ui-router/release/angular-ui-router.js"
    "#{src}/bower_components/underscore/underscore.js"
    "#{src}/bower_components/imago.widgets.angular/dist/imago.widgets.angular.js"
  ]

# END Defaults

generateSass = () ->
  gulp.src paths.sass
    .pipe plumber
      errorHandler: reportError
    .pipe sass
      quiet: true
      trace: true
    .pipe prefix 'last 2 versions'
    .pipe concat targets.css
    .pipe plumber.stop()
    .pipe gulp.dest dest
    .pipe browserSync.reload({stream:true})


gulp.task 'sass', generateSass

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe plumber(
      errorHandler: reportError
    )
    .pipe ngClassify(
      animation:
        format: '*'
        prefix: ''
      constant:
        format: '*'
        prefix: ''
      controller:
        prefix: ''
      factory:
        format: '*'
      filter:
        format: '*'
      provider:
        format: '*'
        prefix: ''
      service:
        prefix: ''
      value:
        format: '*'
      )
    .pipe coffeelint()
    .pipe coffee(
      bare: true
    ).on('error', reportError)
    .pipe concat targets.coffee
    .pipe gulp.dest dest

gulp.task 'jade', ->
  YOUR_LOCALS = {};
  gulp.src paths.jade
    .pipe plumber(
      errorHandler: reportError
    )
    .pipe jade({locals: YOUR_LOCALS}).on('error', reportError)
    .pipe templateCache(
      standalone: true
      root: "/#{src}/"
      module: 'templatesApp'
    )
    .pipe concat targets.jade
    .pipe gulp.dest dest

gulp.task 'scripts', ->
  gulp.src paths.libs
    .pipe plumber(
      errorHandler: reportError
    )
    .pipe concat targets.scripts
    .pipe gulp.dest dest

gulp.task 'images', ->
  gulp.src("#{src}/static/*.*")
    .pipe imagemin()
    .pipe gulp.dest("#{dest}/static")

minify = ->
  gulp.src "#{dest}/#{targets.js}"
    .pipe uglify()
    .pipe ngmin()
    .pipe concat targets.js
    .pipe gulp.dest dest

gulp.task 'minify', ['build'], minify

combineJs = (production = false) ->
  # We need to rethrow jade errors to see them
  rethrow = (err, filename, lineno) -> throw err

  files = [
    targets.scripts
    targets.coffee
    targets.jade
  ]
  sources = files.map (file) -> "#{dest}/#{file}"

  gulp.src sources
    .pipe concat targets.js
    .pipe gulp.dest dest
    .pipe browserSync.reload({stream:true})

gulp.task 'combine', combineJs

gulp.task 'js', ['scripts', 'coffee', 'jade'], (next) ->
  next()

# gulp.task "prepare", ["js"], ->
#   generateSass()
#   combineJs()

gulp.task 'webdriver_standalone', webdriver_standalone

gulp.task 'test', ['webdriver_standalone'], ->
  gulp.src(['test/e2e/**/*.spec.coffee'])
    .pipe(protractor(
      configFile: 'test/protractor.config.js'
      args: [
        '--baseUrl'
        'http://localhost:3002'
      ]
    )).on 'error', (e) ->
      reportError e

gulp.task 'prepare', ['js'], ->
  generateSass()
  combineJs()

gulp.task 'build', ['js'], ->
  generateSass()
  combineJs()

gulp.task 'b', ['build']

gulp.task 'deploy', ['build'], ->
  exec 'deploy .', (error, stdout, stderr) ->
    console.log 'result: ' + stdout
    console.log 'exec error: ' + error  if error isnt null


## Essentials Task

gulp.task 'browser-sync', ->
  browserSync.init ["#{dest}/index.html"],
    server:
      baseDir: "#{dest}"
      middleware: [
        modRewrite ['^([^.]+)$ /index.html [L]']
      ]
    # logConnections: false
    debugInfo: false
    notify: false

gulp.task 'watch', ['prepare', 'browser-sync'], ->
  watch
    glob: 'css/*.sass', emitOnGlob: false
  , ->
    gulp.start('sass')

  watch
    glob: paths.jade, emitOnGlob: false
  , ->
    gulp.start('jade')

  watch
    glob: paths.js, emitOnGlob: false
  , ->
    gulp.start('scripts')

  watch
    glob: "#{src}/bower_components/imago.widgets.angular/dist/imago.widgets.angular.js", emitOnGlob: false
  , ->
    gulp.start('scripts')

  watch
    glob: paths.coffee, emitOnGlob: false
  , ->
    gulp.start('coffee')

  files = [targets.scripts, targets.jade, targets.coffee]
  sources = ("#{dest}/#{file}" for file in files)

  watch
    glob: sources, emitOnGlob: false
  , ->
    gulp.start('combine')

reportError = (err) ->
  gutil.beep()
  notifier.notify
    title: "Error running Gulp"
    message: err.message
  gutil.log err.message
  @emit 'end'

## End essentials tasks

gulp.task 'default', ['watch']
