fs = require 'fs'
module.exports = (grunt) ->
  grunt.registerTask('routes', 'creates a fake datastructure for side banners region', ->
    dirPath = 'server/views/'
    done = @async()
    files = {}
    console.log "routes"
    grunt.file.recurse(dirPath, (filePath)->
      x =filePath.replace(dirPath, "").replace('.hbs', '').split('/')
      unless x[0] == 'layouts'
        if files[x[0]]
          files[x[0]].push(x[1])
        else
          files[x[0]] = [x[1]]
    )
    fs.writeFile("#{dirPath}/routes.json", JSON.stringify(files , null, 2), (err)->
      #console.log "#{_.keys(manifest).length} files processed into the manifest written in #{destDir}/manifest.json."
      done()
    )
  )