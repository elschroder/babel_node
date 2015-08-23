contentController = require "../controllers/content_controller"
newsController = require "../controllers/news_controller"

module.exports = (app) ->
  
  app.route '/robots.txt'
    .get (req, res) ->
      res.type('text/plain') 
      res.send("User-agent: *\nDisallow: /")  
  
  app.route '/'
    .get contentController.index
  
  app.route "/:language/"
    .get newsController.index

  app.route "/:language/noticies/"
    .get newsController.index
  
  app.route "/:language/noticias/"
    .get newsController.index
  
  app.route "/:language/news/"
    .get newsController.index
  
  app.route "/:language/n/:id"
    .get newsController.get
    
  app.route "/:language/:content"
    .get contentController.get
  
  
  