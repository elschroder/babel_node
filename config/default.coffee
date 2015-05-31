routes = require './routes.json'

module.exports =
  allowed_languages : ['es','en','cat']
  google:
    ga:  process.env.ga || 'UA-XXXXXXXX-1'
  tumblr:
    on: if process.env.tumblr_on then process.env.tumblr_on == "true" else true
    oauth: 
      consumer_key :  process.env.tumblr_key
      consumer_secret :  process.env.tumblr_secret
    blog: process.env.tumblr_blog || 'babelpde.tumblr.com'
  news:
    limit: 10
    templates: {'en':'news','es':'noticias','cat':'noticies'}
    templates_front_page: {'en':'news_fp','es':'noticias_fp','cat':'noticies_fp'}
  is_mi_grano_de_arena: if process.env.mi_grano_de_arena then process.env.mi_grano_de_arena == "true" else false
  routes: routes
  layout: 'babel'