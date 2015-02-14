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
    
  if content == 'index' && !(template.match('error'))
    Tumblr.get(config.news.limit, (err, posts) ->
      _.extend(opts, {tumblr_posts: posts})
      res.render(template, opts)    
    )
  else
    res.render(template, opts)
  
  