_ = require 'lodash'
config = require 'config'
{Blog, User} = require 'tumblr'

module.exports.get = (limit, cb) ->
  opts = {limit: limit}
  
  blog = new Blog 'babelpde.tumblr.com', config.tumblr.oauth
  blog.posts( opts , (error, response) ->
    cb(error) if error
    cb(null, response.posts)
  )