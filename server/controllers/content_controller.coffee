_ = require 'lodash'
config = require 'config'
routes = config.routes
allowedLanguages = config.allowed_languages
newsTemplates = config.news.templates
TumblrHelper = require '../helpers/tumblr'
LanguageId = require '../helpers/language'

module.exports.index = (req, res) ->
  console.log "req.path", req.path
  console.log "req.query", req.query
  if req.query.q
    ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress
    console.log "ip->", ip
    console.log "req.host", req.host
    console.log "req.parmas", req.params
    console.log "req.query", req.query
    console.log "req.path", req.path
    res.status(501).send('Not Implemented')
  else
    language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
    if !(_.contains(allowedLanguages, req.params.language)) #this is a helper to sanitise the urls.
      res.redirect(301, "/#{language}/")

module.exports.get = (req, res) ->
  language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: false, locals: res.locals, ga: config.google.ga}  
  _.extend(opts, LanguageId(language))
  
  content = req.params.content
  
  if _.contains(routes[language], content)
    template = "#{language}/#{content}"
    opts.status = 200
  else
    template = "#{language}/error"
    opts.status = 404
    
  res.status(opts.status).render(template, opts)