_ = require 'lodash'
config = require 'config'
routes = config.routes
allowedLanguages = config.allowed_languages
newsTemplates = config.news.templates
TumblrHelper = require '../helpers/tumblr'
LanguageId = require '../helpers/language'

module.exports.index = (req, res) ->
  # console.log 'hitting index'
  if req.query.q
    ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress
    # console.log "ip->", ip
    # console.log "req.host", req.host
    # console.log "req.parmas", req.params
    # console.log "req.query", req.query
    # console.log "req.path", req.path
    res.status(410).send(null) 
  else
    # console.log "hititng goodby"
    #language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
    #if !(_.contains(allowedLanguages, req.params.language)) #this is a helper to sanitise the urls.
    res.redirect(302, "/es/home/")

module.exports.get = (req, res) ->
  unless _.contains(allowedLanguages, req.params.language)
    # console.log 'not allowerd languega', req.params.language
    res.send(404)
  else
    language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
    opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: false, locals: res.locals, ga: config.google.ga}  
    _.extend(opts, LanguageId(language))
    
    content = req.params.content
    # console.log "content ", content
    if _.contains(routes[language], content)
      template = "#{language}/#{content}"
      opts.status = 200
    else
      template = "#{language}/error"
      opts.status = 404
      
    res.status(opts.status).render(template, opts)