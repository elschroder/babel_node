dev_credentials = require '../tumblr.json'

module.exports =
  tumblr:
    oauth: dev_credentials || process.env.tumblr || {}
    blog: 'babelpde.tumblr.com'
  news:
    limit: 10