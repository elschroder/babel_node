_ = require 'lodash'
_s = require "underscore.string"
Moment = require 'moment-timezone'
config = require 'config'
newsTemplates = config.news.templates
newsTemplatesFP = config.news.templates_front_page
allowedLanguages = config.allowed_languages

Tumblr = require '../models/tumblr'

imagesHelper = require '../helpers/images'
LanguageId = require '../helpers/language'

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

        imagesHelper.createPhotoTitle(newsItems)
        reformatedPost = manipulatePost(newsItems[0], language)
        
        _.extend(opts, {post_item: reformatedPost})
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
        imagesHelper.createPhotoTitle(posts)
        imagesHelper.addResponsiveImg(posts)
        #move this to some helper
        _.map(posts, (post) ->
          manipulatePost(post, language)
        )
        _.extend(opts, {tumblr_posts: posts})
      template = "#{language}/#{newsTemplatesFP[language]}"
      res.render(template, opts)         
    )

manipulatePost = (post, language) ->
  post.caption_summary = _s.prune(post.caption, 640) if post.caption
  post.caption_summary = post.caption_summary.replace(/\.\.\.$/, " <a href='/#{language}/n/#{post.id}'>[+]<a>") if post.caption_summary
  post.body_summary = _s.prune(post.body, 640) if post.body
  post.body_summary = post.body_summary.replace(/\.\.\.$/, " <a href='/#{language}/n/#{post.id}'>[+]<a>") if post.body_summary
  
  dateLang = language
  dateLang = 'ca' if language == 'cat'
  post.date = Moment(post.timestamp, 'X').tz("Europe/Madrid").locale("#{dateLang}").format('LLL')
  _.extend(post, LanguageId(language))
  post