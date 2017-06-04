contentController = require "../controllers/content_controller"
newsController = require "../controllers/news_controller"
homeController = require "../controllers/home_controller"

module.exports = (app) ->

  app.route '/robots.txt'
    .get (req, res) ->
      res.type('text/plain')
      res.send("User-agent: *\n")  

  app.route '/'
    .get contentController.index


  app.route "/:language/"
    .get contentController.get

  app.route "/:language/home"
    .get homeController.index

  # app.route "/:language/noticies/"
#     .get newsController.index
#
  app.route "/:language/noticias/"
    .get newsController.index

  # app.route "/:language/news/"
#     .get newsController.index

  app.route "/:language/n/:id"
    .get newsController.get

  app.route "/:language/:content"
    .get contentController.get

  app.route "*"
    .get (req,res) ->
      res.send(410)
