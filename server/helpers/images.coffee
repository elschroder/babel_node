_ = require 'lodash'

module.exports.addResponsiveImg = (posts) ->
  _.each(posts, (post) ->
    if post.body
      post.body = post.body.replace(/\<img src/g, "<img class='img-responsive' src")
  )
  
module.exports.createPhotoTitle = (posts) ->
  _.each(posts, (post) ->
    if post.type == 'photo'
      caption = post.caption
      caption = caption.replace('\n', ' ')
      splitCaption = /\<h2\>(.*?)\<\/h2\>/i.exec(caption)
      post.title = splitCaption?[1]?.replace(/<(.|\n)*?>/g, '')
      post.caption = caption.replace(splitCaption?[0],'')
  )