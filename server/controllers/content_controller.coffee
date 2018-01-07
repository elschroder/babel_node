_ = require 'lodash'
config = require 'config'
routes = config.routes
allowedLanguages = config.allowed_languages
newsTemplates = config.news.templates
TumblrHelper = require '../helpers/tumblr'
LanguageId = require '../helpers/language'

module.exports.index = (req, res) ->
  if req.query.q
    ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress
    res.status(410).send(null)
  else
    res.redirect(302, "/es/home/")

module.exports.get = (req, res) ->
  language = 'es'
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: false, locals: res.locals, ga: config.google.ga}
  _.extend(opts, LanguageId(language))

  content = req.params.content
  # console.log "content ", content
  # console.log " routes language" + routes[language]
  # console.log " content" + content
  # console.log " -- find " + _.find(routes[language], (o) -> (o == content) )
  if _.find(routes[language], (o) -> (o == content) )
    template = "#{language}/#{content}"
    opts.status = 200
  else
    template = "#{language}/error"
    opts.status = 404

  res.status(opts.status).render(template, opts)
