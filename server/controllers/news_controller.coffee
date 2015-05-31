_ = require 'lodash'
config = require 'config'
newsTemplates = config.news.templates
newsTemplatesFP = config.news.templates_front_page
allowedLanguages = config.allowed_languages

Tumblr = require '../models/tumblr'

TumblrHelper = require '../helpers/tumblr'
LanguageId = require '../helpers/language'

module.exports.get = (req, res) ->
  id = req.params.id
  
  if id && !_.contains(allowedLanguages, req.params.language)
    res.redirect("/es/n/#{id}")
  else
    opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: config.is_mi_grano_de_arena, locals: res.locals, ga: config.google.ga}
    language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
    _.extend(opts, LanguageId(language))
    
    Tumblr.getPost(id, (err, newsItems) ->
      if (!err) && newsItems && newsItems?.length > 0 && newsItems?[0].blog_name == 'babelpde'
        TumblrHelper.createPhotoTitle(newsItems)
        reformatedPost = TumblrHelper.manipulatePostNeedsRefactoring(newsItems[0], language)
        
        _.extend(opts, {post_item: reformatedPost})
        res.render('common/tumblr/news/news_item', opts)
      else
        res.render('common/error', opts)
    )

module.exports.index = (req, res) ->
  opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: config.is_mi_grano_de_arena, locals: res.locals, ga: config.google.ga}
  language = if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
  _.extend(opts, LanguageId(language))
  
  if !(_.contains(allowedLanguages,req.params.language))
    res.redirect("/#{language}/")  
  else
    Tumblr.get(config.news.limit, (err, posts) ->
      if !err && posts && posts?.length > 0  
        TumblrHelper.createPhotoTitle(posts)
        TumblrHelper.addResponsiveImg(posts)
        _.map(posts, (post) ->
          TumblrHelper.manipulatePostNeedsRefactoring(post, language)
        )
        _.extend(opts, {tumblr_posts: posts})
      template = "#{language}/#{newsTemplatesFP[language]}"
      res.render(template, opts)         
    )

