Tumblr = require '../models/tumblr'
config = require 'config'
LanguageId = require '../helpers/language'
_ = require 'lodash'
module.exports.get = (req, res) ->
  language = req.params.language
  language = 'es' unless language
  id = req.params.id
  
  
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, locals: res.locals, ga: config.google.ga}
  _.extend(opts, LanguageId(language))
  
  Tumblr.getPost(id, (err, callback)->
    console.log "callback", callback
    if callback.length > 0
      callback = callback[0]
      _.extend(opts, {post_item: callback})
      console.log "opts", opts
    res.render('common/tumblr/news/news_item', opts)
  )
  
  
postType = (post) ->
  console.log 'post->', post
  post.isText = true if post.type == 'text'
  post.isPhoto = true if post.type == 'photo'
