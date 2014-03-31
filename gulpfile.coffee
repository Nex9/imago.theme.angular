browserSync     = require('browser-sync')
coffee          = require('gulp-coffee')
coffeelint      = require('gulp-coffeelint')
concat          = require("gulp-concat")
gulp            = require("gulp")
gulpif          = require("gulp-if")
imagemin        = require('gulp-imagemin')
jade            = require("gulp-jade")
minifyCSS       = require("gulp-minify-css")
ngmin           = require("gulp-ngmin")
order           = require("gulp-order")
plumber         = require("gulp-plumber")
prefix          = require("gulp-autoprefixer")
resolveDependencies = require('gulp-resolve-dependencies')
runSequence     = require("run-sequence")
stylus          = require('gulp-stylus')
templateCache   = require("gulp-angular-templatecache")
uglify          = require("gulp-uglify")
uncss           = require("gulp-uncss")
usemin          = require('gulp-usemin')
watch           = require("gulp-watch")


# Defaults

production = false
destinationFolder = 'public'
tmp = 'app/tmp'

# END Defaults

gulp.task "styles", ->
  gulp.src("app/styles/index.styl")
    .pipe(plumber())
    .pipe stylus({
            set:['compress']
    })
    .pipe prefix("last 1 version")
    .pipe gulp.dest("#{tmp}/styles")

gulp.task "coffee", ->
  gulp.src("app/**/*.coffee")
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe coffeelint()
    .pipe(resolveDependencies({
            pattern: /\* @requires [\s-]*(.*?\.js)/g
    }))
    .pipe concat("application.js")
    .pipe gulpif(production, ngmin())
    .pipe gulpif(production, uglify())
    .pipe gulp.dest(tmp)

# gulp.task "scripts", ->
#   gulp.src("app/**/*.js")
#     .pipe(concat("application.js"))
#     .pipe(gulpif(production, ngmin()))
#     .pipe(gulpif(production, uglify()))
#     .pipe gulp.dest(destinationFolder)

gulp.task "usemin", ->
  gulp.src("app/index.html")
    .pipe(usemin(js: [uglify()]))
    .pipe gulp.dest("dist/")

gulp.task "templates", ->
  YOUR_LOCALS = {};
  gulp.src "app/views/*.jade"
    .pipe plumber()
    .pipe jade({locals: YOUR_LOCALS})
    .pipe(templateCache(
      standalone: true
      root: "app/views/"
      module: "templatesApp"
    ))
    .pipe gulp.dest(tmp)

# gulp.task "templates", ->
#   gulp.src("views/*.html")
#     .pipe(templateCache(
#       standalone: true
#       root: "app/views/"
#       module: "templatesApp"
#     ))
#     .pipe gulp.dest(destinationFolder)

gulp.task "images", ->
  gulp.src("app/images/*.*")
    .pipe imagemin()
    .pipe gulp.dest("#{tmp}/images")

gulp.task "uncss", ->
  gulp.src("#{destinationFolder}/index.css")
    .pipe uncss(html: ["index.html"])
    .pipe minifyCSS(keepSpecialComments: 0)
    .pipe gulp.dest(destinationFolder)


## Essentials Task


gulp.task "browser-sync", ->
  browserSync.init ["#{tmp}/**/*.*", "app/index.html"],
    server:
      baseDir: "app"
    # logConnections: false
    debugInfo: false
    notify: false

gulp.task "watch", ['browser-sync'], ->
  watch {glob: "app/styles/*.styl"}, (files) ->
    gulp.start('styles')

  watch {glob: "app/**/*.coffee"}, (files) ->
    gulp.start('coffee')

  watch {glob: "app/views/*.jade"}, (files) ->
    gulp.start('templates')

gulp.task "build", ->
    runSequence "templates", [
        "coffee"
        "styles"
        "images"
    ]

## End essentials tasks
