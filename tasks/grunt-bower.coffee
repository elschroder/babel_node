bower = require('bower')

module.exports = (grunt) ->

  grunt.registerTask('bower:install', 'Install js packages listed in bower.json', ->
    done = @async()
    bower.commands.install([], { forceLatest: true} )
    #bower.commands.install()
    .on('data', (data) ->
      grunt.log.write(data)
    )
    .on('error', (data) ->
      grunt.log.write(data)
      done(false)
    )
    .on('end', (data) ->
      done()
    )
  )