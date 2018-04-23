const config = require('config')
const Tumblr = require('../models/tumblr.js')
// const LanguageId = require('../helpers/language.js')
const TumblrHelper = require('../helpers/tumblr.js')
const newsTemplatesFP = config.news.templates_front_page

module.exports.index = function(req, res) {
  const { language } = req.params;
  let opts = setOpts(req, res, language);

  return Tumblr.get(20, function(err, posts) {
    if (!err && ((posts != null ? posts.length : undefined) > 0)) {
      posts = posts.map(post =>
        TumblrHelper.prettyPrintPost(post, language)
        );
      opts = {...opts,  ...{tumblr_posts: posts}}
      const template = `${language}/${newsTemplatesFP[language]}`;
      return res.render(template, opts);
    } else {
      return res.render(`${language}/error`, opts);
    }
  });
};

const setOpts = function(req, res, language) {
  const opts =  {layout: config.layout, tumblr_on: config.tumblr.on, is_mi_grano_de_arena: config.is_mi_grano_de_arena, locals: res.locals, ga: config.google.ga};
  return opts;
};
