gulp = require("gulp")
stylus = require('gulp-stylus')
plumber = require("gulp-plumber")
coffee  = require('gulp-coffee')
coffeelint = require('gulp-coffeelint')
watch   = require("gulp-watch")
prefix  = require("gulp-autoprefixer")
concat  = require("gulp-concat")
templateCache = require("gulp-angular-templatecache")
uglify = require("gulp-uglify")
uncss  = require("gulp-uncss")
order  = require("gulp-order")
gulpif = require("gulp-if")
ngmin  = require("gulp-ngmin")
minifyCSS   = require("gulp-minify-css")
runSequence = require("run-sequence")
jade     = require("gulp-jade")
imagemin = require('gulp-imagemin')
browserSync = require('browser-sync')

production = false
destinationFolder = 'public'

gulp.task "styles", ->
  gulp.src("app/styles/index.styl")
    .pipe(plumber())
    .pipe stylus({
            set:['compress']
    })
    .pipe prefix("last 1 version")
    .pipe gulp.dest("#{destinationFolder}/styles")

gulp.task "coffee", ->
  gulp.src("app/**/*.coffee")
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe concat("application.js")
    .pipe gulpif(production, ngmin())
    .pipe gulpif(production, uglify())
    .pipe gulp.dest(destinationFolder)

# gulp.task "scripts", ->
#   gulp.src("app/**/*.js")
#     .pipe(concat("application.js"))
#     .pipe(gulpif(production, ngmin()))
#     .pipe(gulpif(production, uglify()))
#     .pipe gulp.dest(destinationFolder)

gulp.task "browser-sync", ->
  browserSync.init "#{destinationFolder}/**/*.*",
    server:
      baseDir: "public"

gulp.task "jade", ->
  YOUR_LOCALS = {};
  gulp.src("app/views/*.jade")
    .pipe(plumber())
    .pipe(jade({locals: YOUR_LOCALS}))
    .pipe(templateCache(
      standalone: true
      root: "app/views/"
      module: "templatesApp"
    ))
    .pipe(gulp.dest(destinationFolder))

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
    .pipe gulp.dest("#{destinationFolder}/images")

gulp.task "watch", ['browser-sync'], ->
  gulp.watch "app/styles/*.styl", ["styles"]
  gulp.watch "app/**/*.coffee", ["coffee"]
  gulp.watch "app/views/*.jade", ["jade"]

gulp.task "uncss", ->
  gulp.src("#{destinationFolder}/index.css")
    .pipe(uncss(html: ["index.html"]))
    .pipe(minifyCSS(keepSpecialComments: 0))
    .pipe gulp.dest(destinationFolder)

gulp.task "default",
    runSequence "jade", [
        "coffee"
        "styles"
        "images"
    ]


# gulp.start('templates');
# gulp.start('styles');
# gulp.start('scripts');
# gulp.start('uncss');