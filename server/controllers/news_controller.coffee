Tumblr = require '../models/tumblr'
config = require 'config'
newsTemplates = config.news.templates
newsTemplatesFP = config.news.templates_front_page
imagesHelper = require '../helpers/images'
LanguageId = require '../helpers/language'
_ = require 'lodash'

module.exports.get = (req, res) ->
  language = req.params.language
  language = 'es' unless language
  id = req.params.id
  
  
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, locals: res.locals, ga: config.google.ga}
  _.extend(opts, LanguageId(language))
  
  Tumblr.getPost(id, (err, callback)->
    #res.render('common/error', opts) if err
    if err
      console.log "fooerror",err
    else if callback
      console.log "-> ", callback
      if callback.length > 0 && callback?[0].blog_name == 'babelpde'
        callback = callback[0] 
        _.extend(opts, {post_item: callback})
        res.render('common/tumblr/news/news_item', opts)
      else
        res.render('common/error', opts)
    else
      res.render('common/error', opts)
    
  )


module.exports.index = (req, res) ->
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, locals: res.locals, ga: config.google.ga}
  #content = 'noticias'
  language = req.params.language
  language = 'es' unless language
  
  template = "#{language}/#{newsTemplatesFP[language]}"
  
  _.extend(opts, LanguageId(language))
  
  postLimit = config.news.limit #unless _.contains(newsTemplates, content)

  Tumblr.get(postLimit, (err, posts) ->
    if err
      console.log "err"
      opts.tumblr_on = false
    if posts
      console.log "posts"
      opts.tumblr_on = false if posts?.length < 1
      imagesHelper.addResponsiveImg(posts)
      #move this to some helper
      _.map(posts, (post) ->
        _.extend(post, LanguageId(language) )
      )
      _.extend(opts, {tumblr_posts: posts})
    res.render(template, opts)      
  )
  
postType = (post) ->
  console.log 'post->', post
  post.isText = true if post.type == 'text'
  post.isPhoto = true if post.type == 'photo'
  post.isVideo = true if post.type == 'video'