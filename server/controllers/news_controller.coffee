Tumblr = require '../models/tumblr'
config = require 'config'
newsTemplates = config.news.templates
newsTemplatesFP = config.news.templates_front_page
allowedLanguages = config.allowed_languages

imagesHelper = require '../helpers/images'
LanguageId = require '../helpers/language'
_ = require 'lodash'

module.exports.get = (req, res) ->
  id = req.params.id
  
  if id && !_.contains(allowedLanguages, req.params.language)
    console.log "if id lingua"
    res.redirect("/es/n/#{id}")
  else
    console.log 'Else id e lingua direitos'
    opts =  {layout: config.layout, tumblr_on: config.tumblr.on, locals: res.locals, ga: config.google.ga}
    language = if _.contains(allowedLanguages,req.params.language) then req.params.language else 'es'
    _.extend(opts, LanguageId(language))
    
    Tumblr.getPost(id, (err, callback)->
      if callback && callback?.length > 0 && callback?[0].blog_name == 'babelpde' && (!err)
        console.log 'else if'
        callback = callback[0] 
        _.extend(opts, {post_item: callback})
        res.render('common/tumblr/news/news_item', opts)
      else
        console.log "todos os outros erros", err
        res.render('common/error', opts)
    )

module.exports.index = (req, res) ->
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, locals: res.locals, ga: config.google.ga}
  language = if _.contains(allowedLanguages,req.params.language) then req.params.language else 'es'
  _.extend(opts, LanguageId(language))
  
  if !(_.contains(allowedLanguages,req.params.language))
    res.redirect("/#{language}/")  
  else
    Tumblr.get(config.news.limit, (err, posts) ->
      if !err && posts && posts?.length > 0 
        imagesHelper.addResponsiveImg(posts)
        #move this to some helper
        _.map(posts, (post) ->
          _.extend(post, LanguageId(language) )
        )
        _.extend(opts, {tumblr_posts: posts})
      template = "#{language}/#{newsTemplatesFP[language]}"
      res.render(template, opts)         
    )