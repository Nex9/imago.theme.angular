browserSync     = require("browser-sync")

clean           = require("gulp-clean")
coffee          = require("gulp-coffee")
coffeelint      = require("gulp-coffeelint")

concat          = require("gulp-concat")

gulp            = require("gulp")
gulpif          = require("gulp-if")

imagemin        = require("gulp-imagemin")
inject          = require("gulp-inject")
jade            = require("gulp-jade")
minifyCSS       = require("gulp-minify-css")
ngmin           = require("gulp-ngmin")
notify          = require("gulp-notify")
order           = require("gulp-order")
plumber         = require("gulp-plumber")
prefix          = require("gulp-autoprefixer")
runSequence     = require("run-sequence")
stylus          = require("gulp-stylus")
templateCache   = require("gulp-angular-templatecache")
uglify          = require("gulp-uglify")
uncss           = require("gulp-uncss")
usemin          = require("gulp-usemin")
watch           = require("gulp-watch")


# Defaults

destinationFolder = "./public"
src = "./src"
tmp = "#{src}/.tmp"

# END Defaults

gulp.task "styles", ->
  gulp.src("#{src}/styles/index.styl")
    .pipe(plumber())
    .pipe stylus({
            set:["compress"]
    })
    .pipe prefix("last 1 version")
    .pipe gulp.dest("#{tmp}/styles")

gulp.task "coffee", ->
  gulp.src("#{src}/**/*.coffee")
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe coffeelint()
    .pipe gulp.dest("#{tmp}/coffee")

gulp.task "concat", ["coffee"], ->
  gulp.src("#{tmp}/coffee/**/*.js")
    .pipe(order([
      "**/index.*",
      "**/*.*"
    ]))
    .pipe concat("./application.js")
    .pipe gulp.dest(tmp)

gulp.task "templates", ->
  YOUR_LOCALS = {};
  gulp.src "#{src}/**/*.jade"
    .pipe plumber()
    .pipe jade({locals: YOUR_LOCALS})
    .pipe templateCache(
      standalone: true
      root: "/#{src}/"
      module: "templatesApp"
    )
    .pipe gulp.dest(tmp)

gulp.task "images", ->
  gulp.src("#{src}/static/*.*")
    .pipe imagemin()
    .pipe gulp.dest("#{tmp}/static")

gulp.task "uncss", ->
  gulp.src("#{destinationFolder}/index.css")
    .pipe uncss(html: ["index.html"])
    .pipe minifyCSS(keepSpecialComments: 0)
    .pipe gulp.dest(destinationFolder)

gulp.task "clean", ->
  gulp.src(destinationFolder, {read: false})
    .pipe(clean());
  gulp.src(tmp, {read: false})
    .pipe(clean());

gulp.task "copy", ->
  gulp.src("#{src}/static/**/*.*")
    .pipe gulp.dest("#{destinationFolder}/static")
  gulp.src("./theme.yaml")
    .pipe gulp.dest("#{destinationFolder}")

gulp.task "usemin", ->
  gulp.src("#{src}/index.html")
    .pipe(usemin(
      css: [
        minifyCSS()
      ]
      js: [
        ngmin()
        uglify()
      ]))
    .pipe gulp.dest(destinationFolder)
    .pipe notify
      message: "Build complete",
      title: "gulp"


## Essentials Task

gulp.task "browser-sync", ->
  browserSync.init ["#{tmp}/**/*.*", "#{src}/index.html"],
    server:
      baseDir: "#{src}"
    # logConnections: false
    debugInfo: false
    notify: false

gulp.task "watch", ["browser-sync"], ->
  watch {glob: "#{src}/**/*.styl"}, (files) ->
    gulp.start "styles"

  watch {glob: "#{src}/**/*.coffee"}, (files) ->
    gulp.start "concat"

  watch {glob: "#{src}/**/*.jade"}, (files) ->
    gulp.start "templates"

gulp.task "build", ["clean"], ->

  runSequence [
        "templates"
        "concat"
        "styles"
        "images"
    ],
    "copy",
    "usemin"

## End essentials tasks
