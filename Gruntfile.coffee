module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
  )
  grunt.loadTasks('tasks')
  #grunt.registerTask('build', ['bower:install','clean','concat','copy','mince'])  
  grunt.registerTask('default', ['bower:install'])
