_ = require 'lodash'
tumblr = (require 'config').tumblr
{Blog, User} = require 'tumblr'

blog = new Blog(tumblr.blog, tumblr.oauth)

getAll = (limit=null, cb) ->
  opts = {} 
  opts.limit = limit if limit
  getPosts(opts, cb)

getPost = (id, callback) ->
  getPosts({id: id, blog_name: tumblr.blog_name}, (err, posts) ->
    return callback(err) if err
    callback(null, posts?[0])
    )

getPosts = (opts, cb) ->
  blog.posts(opts, (error, response) ->
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
  
module.exports.get = getAll
module.exports.getPost = getPost
module.exports.getPosts = getPosts
