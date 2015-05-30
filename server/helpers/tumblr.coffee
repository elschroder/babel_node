_ = require 'lodash'
_s = require "underscore.string"
Moment = require 'moment-timezone'
LanguageId = require '../helpers/language'

module.exports.addResponsiveImg = (posts) ->
  _.each(posts, (post) ->
    if post.body
      post.body = post.body.replace(/\<img src/g, "<img class='img-responsive' src")
  )
  
module.exports.createPhotoTitle = (posts) ->
  _.each(posts, (post) ->
    if post.type == 'photo'
      caption = post.caption
      
      caption = caption.replace(/\n/g, 'foo ')
      
      splitCaption = /\<h2\>(.*?)\<\/h2\>/i.exec(caption)
      #caption = caption.replace('\n', ' ')
      
      post.title = splitCaption?[1]?.replace(/<(.|\n)*?>/g, '')
      post.caption = caption.replace(splitCaption?[0],'')
  )

pickImageNeedsRefactoring = (post) ->
  #picks a smaller image 
  #adds https links to tumblr
  images = post.photos
  if images
    _.each(images, (image) ->
      image.picked_size = _.find(image.alt_sizes, width:400)
      if image.original_size
        image.original_size.url = image.original_size?.url.replace(/http\:/,'https:')
      if image.picked_size
        image.picked_size.url = image.picked_size?.url.replace(/http\:/,'https:')
      else
        image.picked_size = image.original_size
    )
    
module.exports.manipulatePostNeedsRefactoring = (post, language) ->
  
  post.caption_summary = _s.prune(post.caption, 640) if post.caption
  post.caption_summary = post.caption_summary.replace(/\.\.\.$/, " <a href='/#{language}/n/#{post.id}'>[+]<a>") if post.caption_summary
  post.body_summary = _s.prune(post.body, 640) if post.body
  post.body_summary = post.body_summary.replace(/\.\.\.$/, " <a href='/#{language}/n/#{post.id}'>[+]<a>") if post.body_summary
  
  dateLang = language
  dateLang = 'ca' if language == 'cat'
  post.date = Moment(post.timestamp, 'X').tz("Europe/Madrid").locale("#{dateLang}").format('LLL')
  _.extend(post, LanguageId(language))
  pickImageNeedsRefactoring(post)
  post
 

photoManipulation = ->
  console.log "we add all the tasks needed to do on a photo"

textManipulation = ->
  console.log "we add all the tasks needed to do on text from a post"


 
  