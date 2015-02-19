routes = require './routes.json'

module.exports =
  tumblr:
    on: if process.env.tumblr_on then process.env.tumblr_on == "true" else true
    oauth: 
      consumer_key :  process.env.tumblr_key
      consumer_secret :  process.env.tumblr_secret
    blog: 'babelpde.tumblr.com'
  news:
    limit: 10
  routes: routes