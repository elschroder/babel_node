_ = require 'lodash'
config = require 'config'
routes = config.routes
imagesHelper = require '../helpers/images'
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
      
  if (content == 'index' || content == 'news' ||   content == 'noticias' ||  content == 'noticies') && !(template.match('error')) && config.tumblr.on
    Tumblr.get(postLimit, (err, posts) ->
      console.log "error", err if err
      if posts?.length > 0
        imagesHelper.addResponsiveImg(posts)         
        _.extend(opts, {tumblr_posts: posts})
      res.render(template, opts)    
    )
  else
    res.render(template, opts)
  
