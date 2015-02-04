dev_credentials = require '../tumblr.json'

module.exports =
  tumblr: dev_credentials || process.env.tumblr || {}

  