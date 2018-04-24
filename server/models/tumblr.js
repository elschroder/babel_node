const { tumblr } = (require('config'));
const { Blog, User } = require('tumblr');

const blog = new Blog(tumblr.blog, tumblr.oauth);

const getAll = function (limit = null, cb) {
  const opts = {};
  if (limit) { opts.limit = limit; }
  return getPosts(opts, cb);
};

const getPost = (id, callback) =>
  getPosts({ id, blog_name: tumblr.blog_name }, (err, posts) => {
    if (err) { return callback(err); }
    return callback(null, posts != null ? posts[0] : undefined);
  });


var getPosts = (opts, cb) =>
  blog.posts(opts, (error, response) => {
    if (error) { return cb(error); }
    return cb(null, response.posts);
  });

module.exports.get = getAll;
module.exports.getPost = getPost;
module.exports.getPosts = getPosts;
