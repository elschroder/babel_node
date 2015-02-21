_ = require 'lodash'
config = require 'config'
routes = config.routes
imagesHelper = require '../helpers/images'
LanguageId = require '../helpers/language'
Tumblr = require '../models/tumblr'

newsTemplates = ['news','noticias','noticies']

module.exports.get = (req, res) ->
  opts =  {layout: 'babel', tumblr_on: config.tumblr.on}
  language = req.params.language
  language = 'es' unless language
  content = req.params.content
  content = 'index' unless content
  
  _.extend(opts, LanguageId(language))
  
  if _.contains(routes[language], content)
    template = "#{language}/#{content}"
  else
    template = "#{language}/error"
  
  if _.contains(_.union(newsTemplates, ['index']), content) && !(template.match('error')) && config.tumblr.on
    
    postLimit = config.news.limit unless _.contains(newsTemplates, content)

    Tumblr.get(postLimit, (err, posts) ->
      if err
        opts.tumblr_on = false
      if posts
        opts.tumblr_on = false if posts?.length < 1
        imagesHelper.addResponsiveImg(posts)         
        _.extend(opts, {tumblr_posts: posts})
      res.render(template, opts)      
    )
  else
    res.render(template, opts)
  
