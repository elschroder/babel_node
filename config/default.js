const routes = require('./routes.json')

module.exports = {
  allowedLanguages: ['es'],
  allowed_languages : ['es'],
  google: {
    ga:  process.env.ga || 'UA-XXXXXXXX-1'
  },
  tumblr: {
    on: process.env.tumblr_on ? process.env.tumblr_on === "true" : true,
    oauth: {
      consumer_key :  process.env.tumblr_key,
      consumer_secret :  process.env.tumblr_secret
    },
    blog: process.env.tumblr_blog || 'babelpde.tumblr.com'
  },
  news: {
    limit: 3,
    templates: {'en':'news','es':'noticias','cat':'noticies'},
    templates_front_page: {'en':'news_fp','es':'home','cat':'noticies_fp'}
  },
  is_mi_grano_de_arena: process.env.mi_grano_de_arena ? process.env.mi_grano_de_arena === "true" : false,
  routes,
  layout: 'babel'
};

module.exports.routes = routes
