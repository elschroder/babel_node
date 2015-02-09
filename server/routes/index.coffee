contentController = require "../controllers/content_controller"

module.exports = (app) ->
  
  app.route '/'
    .get contentController.get
    
  app.route "/content/:language/:content"
    .get contentController.get
  
  app.route "/content/:language/"
    .get contentController.get