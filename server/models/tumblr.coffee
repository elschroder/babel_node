_ = require 'lodash'
tumblr = (require 'config').tumblr
{Blog, User} = require 'tumblr'

module.exports.get = (limit=null, cb) ->
  opts = {} 
  opts.limit = limit if limit
  
  new Blog(tumblr.blog, tumblr.oauth)
    .posts(opts , (error, response) ->
      cb(error) if error
      postType(response.posts)
      cb(null, response.posts)
    )
    
postType = (posts) ->
  _.each(posts, (post) ->
    post.isText = true if post.type == 'text'
    post.isPhoto = true if post.type == 'photo'
  )