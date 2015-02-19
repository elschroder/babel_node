_ = require 'lodash'

module.exports.addResponsiveImg = (posts) ->
  _.each(posts, (post) ->
    if post.body
      post.body = post.body.replace(/\<img src/g, "<img class='img-responsive' src")
  )