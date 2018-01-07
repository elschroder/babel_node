_ = require 'lodash'
config = require 'config'
newsTemplates = config.news.templates
newsTemplatesFP = config.news.templates_front_page
allowedLanguages = config.allowed_languages

Tumblr = require '../models/tumblr'

TumblrHelper = require '../helpers/tumblr'
LanguageId = require '../helpers/language'

module.exports.index = (req, res) ->

  language = req.params.language #if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
  opts = setOpts(req, res, language)

  Tumblr.get(config.news.limit, (err, posts) ->
    if !err && posts?.length > 0
      _.each(posts, (post) ->
        # console.log post
        TumblrHelper.prettyPrintPost(post, language)
        )
      _.extend(opts, {tumblr_posts: posts})

      template = "#{language}/#{newsTemplatesFP[language]}"
      res.render(template, opts)
    else
      # console.log "news index -> err",err
      #res.send(404)
      res.render("#{language}/error", opts)
  )

setOpts = (req, res, language) ->
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: config.is_mi_grano_de_arena, locals: res.locals, ga: config.google.ga}
  _.extend(opts, LanguageId(language))
  opts
