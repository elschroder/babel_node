tumblr = (require 'config').tumblr
{Blog, User} = require 'tumblr'

module.exports.get = (limit, cb) ->
  opts = {limit: limit}
  
  new Blog(tumblr.blog, tumblr.oauth)
    .posts(opts , (error, response) ->
      cb(error) if error
      cb(null, response.posts)
    )