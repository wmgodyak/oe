var gulp = require('gulp');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var cssmin = require('gulp-cssmin');
var rename = require("gulp-rename");
var merge = require('merge-stream');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var spritesmith = require('gulp.spritesmith');
var layout = require('layout');

gulp.task('style', function () {
	return gulp.src('assets/sass/style.scss')
	.pipe(sass().on('error', sass.logError))
	.pipe(autoprefixer({
		browsers: ['> 0%']
	}))
  .pipe(gulp.dest('assets/css'))
});

gulp.task('minify', function () {
  var css = gulp.src(['assets/css/**/*.css', '!assets/css/*.min.css'])
              .pipe(cssmin())
              .pipe(concat('style.min.css'))
              .pipe(gulp.dest('assets/css'));

  var js = gulp.src(['assets/js/**/*.js', '!assets/js/*.min.js'])
              .pipe(concat('main.min.js'))
              .pipe(uglify())
              .pipe(gulp.dest('assets/js'));

   return merge(css, js);
});

gulp.task('sprite', function () {
  var spriteData = gulp.src('assets/img/sprite/sprite-items/*.png').pipe(spritesmith({
    imgName: 'sprite.png',
    cssName: '_sprite.scss',
    algorithm: 'diagonal',
    imgPath: '../img/sprite/sprite.png'
  }));

  var imgStream = spriteData.img
  .pipe(gulp.dest('assets/img/sprite'));

  var cssStream = spriteData.css
  .pipe(gulp.dest('assets/sass/module'));

  return merge(imgStream, cssStream);
});

gulp.task('sass-watch', function () {
  gulp.watch('assets/img/sprite/sprite-items/*.png', ['sprite']);
  gulp.watch('assets/sass/**/*.scss', ['style']);
});

gulp.task('default', ['sass-watch'], function () {

});