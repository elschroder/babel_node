contentController = require "../controllers/content_controller"

module.exports = (app) ->
  
  app.route '/'
    .get contentController.get
  
  app.route "/:language"
    .get contentController.get
    
  app.route "/:language/:content"
    .get contentController.get
  
  