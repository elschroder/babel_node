const config = require('config')
const News = require('../models/news.js')

const frontPageNewsItemCount = config.news.limit
const newsTemplatesFP = config.news.templates_front_page

module.exports.index = function (req, res) {
  const { language } = req.params
  News.getAll({opts: News.setOpts(req, res, language), limit: frontPageNewsItemCount }, (err, newsItems) => {
    if (err) {
      res.render('common/error')
    }
    const template = `${language}/${newsTemplatesFP[language]}`
    res.render(template, newsItems)
  })
}
