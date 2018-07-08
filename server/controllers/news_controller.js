const config = require('config');
const News = require('../models/news.js');

const newsTemplates = config.news.templates;

module.exports.index = function (req, res) {
  const { language } = req.params;
  News.getAll({opts: News.setOpts(req, res, language) }, (err, newsItems) => {
    if (err){
      res.render('common/error');
    }
    const template = `${language}/${newsTemplates[language]}`;
    res.render(template, newsItems);
  });
};

module.exports.get = function (req, res) {
  const { language } = req.params;
  const newsItemId = req.params.id;
  const opts = News.setOpts(req, res, language);

  News.get({id: newsItemId, opts: opts }, (err, newsItem) => {
    if (err){
      res.render('common/error');
    }
    res.render('common/tumblr/news/news_item', newsItem);
  });
};
