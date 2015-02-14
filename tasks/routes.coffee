fs = require 'fs'
module.exports = (grunt) ->
  grunt.registerTask('routes', 'Creates an hierarchy of views for each language used in the website', ->
    dirPath = 'server/views/'
    done = @async()
    
    files = {}
    
    grunt.file.recurse(dirPath, (filePath)->
      x =filePath.replace(dirPath, "").replace('.hbs', '').split('/')
      unless x[0] == 'layouts' || x[0] == 'common'
        if files[x[0]]
          files[x[0]].push(x[1])
        else
          files[x[0]] = [x[1]]
    )
    fs.writeFile("config/routes.json", JSON.stringify(files , null, 2), (err)->
      done()
    )
  )