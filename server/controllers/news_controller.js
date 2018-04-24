const config = require('config');
const newsTemplates = config.news.templates;
const newsTemplatesFP = config.news.templates_front_page;
const allowedLanguages = config.allowed_languages;

const Tumblr = require('../models/tumblr.js');
const TumblrHelper = require('../helpers/tumblr.js');

module.exports.get = function (req, res) {
  // console.log "get req.stuff"
  const { language } = req.params; // if _.contains(allowedLanguages, req.params.language) then req.params.language else 'es'
  let opts = setOpts(req, res, language);

  opts.is_mi_grano_de_arena = false;

  return Tumblr.getPost(req.params.id, (err, post) => {
    if (err) {
      return res.render('common/error', opts);
    }
    opts = { ...opts, ...{ post_item: TumblrHelper.prettyPrintPost(post, language) } };
    return res.render('common/tumblr/news/news_item', opts);
  });
};

module.exports.index = function (req, res) {
  const { language } = req.params;
  let opts = setOpts(req, res, language);

  return Tumblr.get(20, (err, posts) => {
    if (!err && ((posts != null ? posts.length : undefined) > 0)) {
      posts = posts.map(post =>
        TumblrHelper.prettyPrintPost(post, language));
      opts = { ...opts, ...{ tumblr_posts: posts } };
      const template = `${language}/${newsTemplates[language]}`;
      return res.render(template, opts);
    }
    return res.render(`${language}/error`, opts);
  });
};

var setOpts = function (req, res, language) {
  const opts = {
    layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: config.is_mi_grano_de_arena, locals: res.locals, ga: config.google.ga,
  };
  return opts;
};
