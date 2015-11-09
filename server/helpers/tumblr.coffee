_ = require 'lodash'
_s = require "underscore.string"
Moment = require 'moment-timezone'
LanguageId = require '../helpers/language'

setTitle = (post) ->
  if post.type == 'photo' #if a post is of the type photo we need to create a title.
    caption = post.caption
    caption = caption.replace(/\n/g, ' ')
    caption = caption.replace(/\s\s+/g, ' ') #removes any extra space
    splitCaption = /\<h2\>(.*?)\<\/h2\>/i.exec(caption)
    post.title = splitCaption?[1]?.replace(/<(.|\n)*?>/g, '')
    post.caption = caption.replace(splitCaption?[0],'')

setScaledImages = (post) ->  #picks a smaller image and all tumblr links are redirected to https (the api does not allow this by default)
  images = post.photos
  if images
    _.each(images, (image) ->
      image.picked_size = _.find(image.alt_sizes, width: 400)
      if image.original_size
        image.original_size.url = image.original_size?.url.replace(/http\:/,'https:')
      if image.picked_size
        image.picked_size.url = image.picked_size?.url.replace(/http\:/,'https:')
      else
        image.picked_size = image.original_size
    )
        
setSummary = (post, language) ->
  post.caption_summary = _s.prune(post.caption, 640) if post.caption
  post.caption_summary = post.caption_summary.replace(/\.\.\.$/, " <a href='/#{language}/n/#{post.id}'>[+]<a></b></i></p>") if post.caption_summary #extra </b></i></p> are result of a work-around to circunvent the missing closing tags when the text is truncated. scripts to find them where quite heavy.
  post.body_summary =  _s.prune(post.body, 640) if post.body
  post.body_summary = post.body_summary.replace(/\.\.\.$/, " <a href='/#{language}/n/#{post.id}'>[+]<a></b></i></p>") if post.body_summary #extra </b></i></p> are result of a work-around to circunvent the missing closing tags when the text is truncated. scripts to find them where quite heavy.
  _.extend(post, LanguageId(language))

setDate = (post, language) ->
  language = 'ca' if language == 'cat'
  post.date = Moment(post.timestamp, 'X').tz("Europe/Madrid").locale("#{language}").format('LLL')

setType = (post) ->
  post.isText = true if post.type == 'text'
  post.isPhoto = true if post.type == 'photo'
  post.isVideo = true if post.type == 'video'
  post

module.exports.prettyPrintPost = prettyPrintPost = (post, language) ->
  setType(post)
  setTitle(post)
  setScaledImages(post)
  setSummary(post, language)
  setDate(post, language)
  post
  