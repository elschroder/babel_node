const config = require('config')

const tumblr = require('tumblr.js')
const tumblrBlogName = config.tumblr.blog

const tumblrClient = tumblr.createClient({
  consumer_key: config.tumblr.oauth.consumer_key,
  consumer_secret: config.tumblr.oauth.consumer_secret,
  token: config.tumblr.oauth.tumblr_token,
  token_secret: config.tumblr.oauth.tumblr_token_secret
})

const tumblrHelper = require('../helpers/tumblr.js')

const get = function (data, callback) {
  let opts = data.opts
  tumblrClient.blogPosts(tumblrBlogName, {id: data.id }, (err, data) => {
    const post = data.posts[0]
    if (err) {
      callback(err)
    }
    opts = { ...opts, ...{ post_item: tumblrHelper.prettyPrintPost(post, opts.language) } }
    callback(null, opts)
  })
}

const getAll = function (data, callback) {
  let opts = data.opts
  let tumblrOpts = {}
  if (data.limit) {
    tumblrOpts = {limit: data.limit}
  }
  tumblrClient.blogPosts(tumblrBlogName, tumblrOpts, (err, data) => {
    let posts = data.posts
    posts = posts.map(post => tumblrHelper.prettyPrintPost(post, opts.language))
    opts = { ...opts, ...{ tumblr_posts: posts } }
    callback(null, opts)
  })
}

const setOpts = function (req, res, language) {
  const opts = {
    language: language,
    layout: `babel_${language}`,
    tumblr_on: config.tumblr.on,
    is_mi_grano_de_arena: config.is_mi_grano_de_arena,
    locals: res.locals,
    ga: config.google.ga
  }
  return opts
}

module.exports.get = get
module.exports.getAll = getAll
module.exports.setOpts = setOpts
