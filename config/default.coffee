dev_credentials = require '../tumblr.json'
routes = require './routes.json'

module.exports =
  tumblr:
    oauth: dev_credentials || process.env.tumblr || {}
    blog: 'babelpde.tumblr.com'
  news:
    limit: 10
  routes: routes