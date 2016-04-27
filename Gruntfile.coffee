_ = require 'lodash'

module.exports = (grunt) ->
  
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    clean:
      options: 
        force: true
      precompile:
        ['client/build']
    bower_concat: 
      all:
        dest: 'client/build/_bower.js'
        cssDest: 'client/build/bower.css'
            
        #callback: (mainFiles, component) ->
        #  _.map(mainFiles, (filepath) ->
        #      console.log "filepath", filepath
        #      min = filepath.replace(/\.js$/, '.min.js')
        #      console.log "min", min
        #      grunt.file.exists(min) ? min : filepath
        #      )
    uglify:
      bower:
        options:
          mangle: true
          compress: true
        files:
          'client/dist/bower.min.js': 'client/build/_bower.js'
          #'client/dist/bower.min.css': 'client/dist/_bower.css'
    cssmin:
      target:
        files: [
            expand: true
            cwd: 'client/build/'
            src: ['*.css', '!*.min.css']
            dest: 'client/dist'
            ext: '.min.css'
          
        ]
    inline:
      dist:
        options:
          exts: ['hbs']
        src: 'server/views/layouts/babel.hbs'
        dest: 'server/views/layouts/dist/babel.hbs'
  )
  grunt.loadNpmTasks('grunt-bower-concat')
  grunt.loadNpmTasks('grunt-contrib-clean')
  
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-inline')
  grunt.loadTasks('tasks')  
  grunt.registerTask('default', ['bower:install', 'bower_concat',  'uglify', 'cssmin', 'inline', 'clean'])