gulp = require 'gulp'
autoprefixer = require 'gulp-autoprefixer'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
concat = require 'gulp-concat'
rename = require 'gulp-rename'

gulp.task 'sass', ->
	gulp.src './sass/master.scss'
	.pipe sass
		outputStyle: 'expanded'
	.pipe autoprefixer
		browsers: ['last 2 versions']
		cascade: false
	.pipe gulp.dest './htdocs/css'

gulp.task 'build', ->
	gulp.src './coffee/**/*.coffee'
	.pipe coffee
	.pipe concat 'AF.js'
	.pipe gulp.dest './htdocs/js'
	.pipe rename 'AF.min.js'
	.pipe gulp.dest './htdocs/js'

libs = [
	'./bower_components/jquery/dist/jquery.min.js'
	'./bower_components/velocity/velocity.min.js'
]

gulp.task 'libs', ->
	gulp.src libs
	.pipe concat 'AF-libs.js'
	.pipe gulp.dest './htdocs/js'

gulp.task 'default', ->
	gulp.start 'sass'
	gulp.start 'build'

gulp.task 'watch', ->
	gulp.watch './sass/**/*.scss', ['sass']
	gulp.watch './coffee/**/*.coffee', ['build']