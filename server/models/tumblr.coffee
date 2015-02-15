tumblr = (require 'config').tumblr
{Blog, User} = require 'tumblr'

module.exports.get = (limit=null, cb) ->
  opts = {} 
  opts.limit = limit if limit
  
  new Blog(tumblr.blog, tumblr.oauth)
    .posts(opts , (error, response) ->
      cb(error) if error
      cb(null, response.posts)
    )