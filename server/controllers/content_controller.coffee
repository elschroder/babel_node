_ = require 'lodash'
config = require 'config'
routes = config.routes
allowedLanguages = config.allowed_languages
newsTemplates = config.news.templates
TumblrHelper = require '../helpers/tumblr'
LanguageId = require '../helpers/language'

module.exports.index = (req, res) ->
  res.redirect(301, '/es/');
  
module.exports.get = (req, res) ->
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: false, locals: res.locals, ga: config.google.ga}  
  language = req.params.language
  content = req.params.content
  
  if _.contains(routes[language], content)
    template = "#{language}/#{content}"
    opts.status = 200
  else
    language = 'es' unless _.contains(allowedLanguages,language)
    template = "#{language}/error"
    opts.status = 404
    
  _.extend(opts, LanguageId(language))
  res.status(opts.status).render(template, opts)