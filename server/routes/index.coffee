contentController = require "../controllers/content_controller"
newsController = require "../controllers/news_controller"

module.exports = (app) ->
  
  app.route '/'
    .get contentController.index
  
  
    
  app.route "/:language"
    .get contentController.get
  
  app.route "/:language/n/:id"
    .get newsController.get
    
  app.route "/:language/:content"
    .get contentController.get
  
  
  