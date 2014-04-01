browserSync     = require('browser-sync')

clean           = require('gulp-clean')
coffee          = require('gulp-coffee')
coffeelint      = require('gulp-coffeelint')

concat          = require("gulp-concat")

gulp            = require("gulp")
gulpif          = require("gulp-if")

imagemin        = require('gulp-imagemin')
inject          = require("gulp-inject")
jade            = require("gulp-jade")
minifyCSS       = require("gulp-minify-css")
ngmin           = require("gulp-ngmin")
order           = require("gulp-order")
plumber         = require("gulp-plumber")
prefix          = require("gulp-autoprefixer")
rev             = require('gulp-rev')
stylus          = require('gulp-stylus')
templateCache   = require("gulp-angular-templatecache")
uglify          = require("gulp-uglify")
uncss           = require("gulp-uncss")
usemin          = require('gulp-usemin')
watch           = require("gulp-watch")


# Defaults

production = false
destinationFolder = './public'
tmp = './app/_tmp'

# END Defaults

gulp.task "styles", ->
  gulp.src("./app/styles/index.styl")
    .pipe(plumber())
    .pipe stylus({
            set:['compress']
    })
    .pipe prefix("last 1 version")
    .pipe gulp.dest("#{tmp}/styles")

gulp.task "coffee", ->
  gulp.src("./app/**/*.coffee")
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe coffeelint()
    .pipe order([
      "./app/index.js",
      "./app/**/*.js"
    ])
    .pipe concat("./application.js")
    .pipe gulpif(production, ngmin())
    .pipe gulpif(production, uglify())
    .pipe gulp.dest(tmp)

gulp.task "templates", ->
  YOUR_LOCALS = {};
  gulp.src "./app/views/*.jade"
    .pipe plumber()
    .pipe jade({locals: YOUR_LOCALS})
    .pipe(templateCache(
      standalone: true
      root: "./app/views/"
      module: "templatesApp"
    ))
    .pipe gulp.dest(tmp)

gulp.task "images", ->
  gulp.src("./app/images/*.*")
    .pipe imagemin()
    .pipe gulp.dest("#{tmp}/images")

gulp.task "images_build", ->
  gulp.src("./app/images/*.*")
    .pipe imagemin()
    .pipe gulp.dest("#{destinationFolder}/images")

gulp.task "uncss", ->
  gulp.src("#{destinationFolder}/index.css")
    .pipe uncss(html: ["index.html"])
    .pipe minifyCSS(keepSpecialComments: 0)
    .pipe gulp.dest(destinationFolder)

gulp.task "clean", ->
  # gulp.src(tmp, {read: false})
  #   .pipe(clean());
  gulp.src(destinationFolder, {read: false})
    .pipe(clean());


## Essentials Task

gulp.task "browser-sync", ->
  browserSync.init ["#{tmp}/**/*.*", "./app/index.html"],
    server:
      baseDir: "./app"
    # logConnections: false
    debugInfo: false
    notify: false

gulp.task "watch", ['browser-sync'], ->
  watch {glob: "./app/styles/*.styl"}, (files) ->
    gulp.start 'styles'

  watch {glob: "./app/**/*.coffee"}, (files) ->
    gulp.start 'coffee'

  watch {glob: "./app/views/*.jade"}, (files) ->
    gulp.start 'templates'

gulp.task "build", ['clean', 'templates', 'coffee', 'styles'], ->

  gulp.start 'images_build'

  gulp.src("./app/index.html")
    .pipe(usemin(
      css: [
        minifyCSS()
        rev()
      ]
      js: [
        ngmin()
        uglify()
        rev()
      ],
      js_libs: [
        ngmin()
        uglify()
        rev()
      ]))
      .pipe gulp.dest(destinationFolder)
    # runSequence "templates", [
    #     "coffee"
    #     "styles"
    #     "images"
    # ]

## End essentials tasks
