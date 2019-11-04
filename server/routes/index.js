const contentController = require('../controllers/content_controller.js')
const newsController = require('../controllers/news_controller.js')
const homeController = require('../controllers/home_controller.js')

module.exports = (app) => {

  app.route('/robots.txt')
    .get((req, res) => {
      res.type('text/plain')
      res.send('User-agent: *\n')
    })

  app.route('/memoria[0-9]+')
    .get((req, res) => {
      res.redirect(301, '/es/memoria_actividades')
    })

  app.route('/')
    .get(contentController.index)

  app.route('/:language/')
    .get(contentController.index)

  app.route('/:language/home')
    .get(homeController.index)

  app.route('/:language/noticias')
    .get(newsController.index)

  app.route('/:language/nouvelles')
    .get(newsController.index)

  app.route('/:language/n/:id')
    .get(newsController.get)

  app.route('/:language/:content')
    .get(contentController.get)

  app.route('*')
    .get((req, res) => res.send(404))
}
