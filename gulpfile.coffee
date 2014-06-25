browserSync     = require 'browser-sync'

clean           = require 'gulp-clean'
coffee          = require 'gulp-coffee'
coffeelint      = require 'gulp-coffeelint'

concat          = require 'gulp-concat'

gulp            = require 'gulp'
gulpif          = require 'gulp-if'

imagemin        = require 'gulp-imagemin'

jade            = require 'gulp-jade'
minifyCSS       = require 'gulp-minify-css'
ngmin           = require 'gulp-ngmin'

protractor      = require("gulp-protractor").protractor
webdriver_standalone = require("gulp-protractor").webdriver_standalone

order           = require 'gulp-order'
plumber         = require 'gulp-plumber'
prefix          = require 'gulp-autoprefixer'
runSequence     = require 'run-sequence'

sass            = require 'gulp-ruby-sass'
templateCache   = require 'gulp-angular-templatecache'
uglify          = require 'gulp-uglify'
uncss           = require 'gulp-uncss'
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
  stylus: ['css/index.styl']
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
    "#{src}/bower_components/angular-route/angular-route.js"
    "#{src}/bower_components/imago.widgets.angular/dist/imago.widgets.angular.js"
  ]

# END Defaults

# customNotify = notify.withReporter (options, callback) ->
#   # console.log options
#   console.log "Title:", options.title
#   console.log "Message:", options.message
#   callback()

# generateCss = (production = false) ->
#   gulp.src paths.stylus
#     .pipe plumber
#       errorHandler: reportError
#     .pipe stylus({errors: true, use: ['nib'], set:["compress"]})
#     .pipe prefix("last 1 version")
#     .pipe concat targets.css
#     .pipe gulp.dest dest

# gulp.task "stylus", generateCss

generateSass = () ->
  gulp.src paths.sass
    .pipe plumber
      errorHandler: reportError
    .pipe sass
      sourcemap: true
      trace: true
    .pipe prefix("last 2 versions")
    .pipe concat targets.css
    .pipe gulp.dest dest
    .pipe browserSync.reload({stream:true})

generateSassWMaps = () ->
  gulp.src paths.sass
    .pipe plumber
      errorHandler: reportError
    .pipe sass
      sourcemap: false
      style: 'compressed'
    .pipe prefix("last 2 versions")
    .pipe concat targets.css
    .pipe gulp.dest dest


gulp.task "sass", generateSass

gulp.task "coffee", ->
  gulp.src paths.coffee
    .pipe plumber(
      errorHandler: reportError
    )
    .pipe coffee(
      bare: true
    ).on('error', reportError)
    .pipe coffeelint()
    .pipe concat targets.coffee
    .pipe gulp.dest dest

gulp.task "jade", ->
  YOUR_LOCALS = {};
  gulp.src paths.jade
    .pipe plumber(
      errorHandler: reportError
    )
    .pipe jade({locals: YOUR_LOCALS}).on('error', reportError)
    .pipe templateCache(
      standalone: true
      root: "/#{src}/"
      module: "templatesApp"
    )
    .pipe concat targets.jade
    .pipe gulp.dest dest

gulp.task "scripts", ->
  gulp.src paths.libs
    .pipe plumber(
      errorHandler: reportError
    )
    .pipe concat targets.scripts
    .pipe gulp.dest dest

gulp.task "images", ->
  gulp.src("#{src}/static/*.*")
    .pipe imagemin()
    .pipe gulp.dest("#{dest}/static")

gulp.task "uncss", ->
  gulp.src("#{dest}/application.css")
    .pipe uncss(html: ["index.html"])
    .pipe minifyCSS(keepSpecialComments: 0)
    .pipe gulp.dest(destinationFolder)

gulp.task "usemin", ->
  gulp.src("#{src}/index.html")
    .pipe usemin(
      css: [
        minifyCSS()
      ]
      js: [
        ngmin()
        uglify()
      ])
    .pipe gulp.dest(destinationFolder)
    .pipe notify
      message: "Build complete",
      title: "gulp"

minify = ->
  gulp.src "#{dest}/#{targets.js}"
    .pipe uglify()
    .pipe concat targets.jsMin
    .pipe gulp.dest dest

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

gulp.task "combine", combineJs

gulp.task "js", ["scripts", "coffee", "jade"], (next) ->
  next()

gulp.task "prepare", ["js"], ->
  generateSass()
  combineJs()

gulp.task "webdriver_standalone", webdriver_standalone

gulp.task "test", ["webdriver_standalone"], ->
  gulp.src(["test/e2e/**/*.spec.coffee"])
    .pipe(protractor(
      configFile: "test/protractor.config.js"
      args: [
        "--baseUrl"
        "http://localhost:3002"
      ]
    )).on "error", (e) ->
      reportError e

gulp.task "build", ["js"], ->
  generateSassWMaps()
  combineJs()

gulp.task "b", ["build"]

gulp.task "deploy", ["build"], ->
  exec "deploy .", (error, stdout, stderr) ->
    console.log "result: " + stdout
    console.log "exec error: " + error  if error isnt null


## Essentials Task

gulp.task "browser-sync", ->
  browserSync.init ["#{dest}/index.html"],
    server:
      baseDir: "#{dest}"
      middleware: [
        modRewrite ['^([^.]+)$ /index.html [L]']
      ]
    # logConnections: false
    debugInfo: false
    notify: false

gulp.task "watch", ["prepare", "browser-sync"], ->
  watch
    glob: "./css/*.sass"
  , ->
    gulp.start('sass')

  watch
    glob: paths.jade
  , ->
    gulp.start('jade')

  watch
    glob: paths.js
  , ->
    gulp.start('scripts')

  watch
    glob: paths.coffee
  , ->
    gulp.start('coffee')

  files = [targets.scripts, targets.jade, targets.coffee]
  sources = ("#{dest}/#{file}" for file in files)

  watch
    glob: sources
  , ->
    gulp.start('combine')

reportError = (err) ->
  gutil.beep()
  notifier.notify
    title: "Error running Gulp"
    message: err.message
  gutil.log err.message
  @emit 'end'


# gulp.task "build", ->

#   runSequence [
#         "templates"
#         "concat"
#         "styles"
#         "images"
#     ],
#     "copy",
#     "usemin"

## End essentials tasks

gulp.task "default", ["watch"]
