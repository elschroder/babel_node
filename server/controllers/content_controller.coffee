_ = require 'lodash'
config = require 'config'
routes = config.routes

LanguageId = require '../helpers/language'
Tumblr = require '../models/tumblr'

module.exports.get = (req, res) ->
  opts =  {layout: 'babel'}
  language = req.params.language
  language = 'es' unless language
  content = req.params.content
  content = 'index' unless content
  
  _.extend(opts, LanguageId(language))
  
  if _.contains(routes[language], content)
    template = "#{language}/#{content}"
  else
    template = "#{language}/error"
  
  postLimit = config.news.limit unless content == 'news' ||   content == 'noticias' ||  content == 'noticies'
      
  if (content == 'index' || content == 'news' ||   content == 'noticias' ||  content == 'noticies') && !(template.match('error'))
    Tumblr.get(postLimit, (err, posts) ->
      console.log "err",err if err
      if posts?.length > 0
        addResponsiveImg(posts) 
        console.log "posts",posts
        
        _.extend(opts, {tumblr_posts: posts})
      res.render(template, opts)    
    )
  else
    res.render(template, opts)
  
addResponsiveImg = (posts) ->
  _.each(posts, (post) ->
    if post.body
      post.body = post.body.replace(/\<img src/g, "<img class='img-responsive' src")
  )