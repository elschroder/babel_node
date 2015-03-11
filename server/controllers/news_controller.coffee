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
    res.redirect("/es/n/#{id}")
  else
    opts =  {layout: config.layout, tumblr_on: config.tumblr.on, locals: res.locals, ga: config.google.ga}
    language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
    _.extend(opts, LanguageId(language))
    
    Tumblr.getPost(id, (err, newsItems) ->
      if (!err) && newsItems && newsItems?.length > 0 && newsItems?[0].blog_name == 'babelpde' 
        _.extend(opts, {post_item: newsItems[0]})
        res.render('common/tumblr/news/news_item', opts)
      else
        res.render('common/error', opts)
    )

module.exports.index = (req, res) ->
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, locals: res.locals, ga: config.google.ga}
  language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
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