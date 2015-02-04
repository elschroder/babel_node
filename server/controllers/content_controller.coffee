_ = require 'lodash'
LanguageId = require '../helpers/language'
routes = require '../views/routes'
config = require 'config'
{Blog, User} = require 'tumblr'

module.exports.get = (req, res) ->
  opts =  {layout: 'babel'}
  console.log "config", config
  language = req.params.language
  language = 'es' unless language
  content = req.params.content
  content = 'index' unless content

  _.extend(opts, LanguageId(language))
  
  if _.contains(routes[language], content)
    res.render("#{language}/#{content}", opts)
  else
    res.render("#{language}/error", opts)
    
module.exports.index = (req, res) ->
  #######  tumblr test

  oauth = config.tumblr
    #token: 'OAuth Access Token'
    #token_secret: 'OAuth Access Token Secret'

  blog = new Blog 'babelpde.tumblr.com', oauth

  blog.photo limit: 10, (error, response) ->
    throw new Error error if error
    #console.log error if error
    console.log response.posts[0].photos[0].original_size.url
    _.each(response.posts, (post)->
      _.extend(post, {new_image: response.posts[0].photos[0].original_size.url})
    )
    opts =  {layout: 'babel', isEs: true, tumblr_posts: response.posts}
    res.render("es/index", opts)
    
  #user = new User oauth

  #user.info (error, response) ->
  #  throw new Error error if error
  #  console.log response.user

  #######
  
  