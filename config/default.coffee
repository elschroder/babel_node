dev_credentials = require '../tumblr.json'
routes = require './routes.json'

module.exports =
  tumblr:
    oauth: 
      consumer_key :  process.env.tumblr_key
      consumer_secret :  process.env.tumblr_secret
    blog: 'babelpde.tumblr.com'
  news:
    limit: 10
  routes: routes