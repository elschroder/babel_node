_ = require 'lodash'
tumblr = (require 'config').tumblr
{Blog, User} = require 'tumblr'

module.exports.get = (limit=null, cb) ->
  opts = {} 
  opts.limit = limit if limit
  getPosts(opts, cb)
  
module.exports.getPost = (id, cb) ->
  getPosts({id: id, blog_name: 'babelpde'}, cb)

getPosts = (opts, cb) ->
  new Blog(tumblr.blog, tumblr.oauth)
    .posts(opts, (error, response) ->
      return cb(error) if error 
      cb(null, postType(response.posts))
    )

postType = (posts) ->
    _.map(posts, (post)->
      post.isText = true if post.type == 'text'
      post.isPhoto = true if post.type == 'photo'
      post.isVideo = true if post.type == 'video'
      post
    )