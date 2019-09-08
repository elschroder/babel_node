const express = require('express')
const exphbs = require('express-handlebars')
const device = require('express-device')
const favicon = require('serve-favicon')
const compression = require('compression')
const config = require('config')

const app = express()

const env = process.env.NODE_ENV || 'development'
const port = process.env.PORT || 6100

const exphbsConf = exphbs.create({
  extname: '.hbs',
  viewsDir: 'server/views/',
  layoutsDir: 'server/views/layouts',
  partialsDir: ['server/views/']
})

app.engine('.hbs', exphbsConf.engine)

app.set('views', `${__dirname}/views/`)
app.set('view engine', '.hbs')

app.use('/assets', express.static('client/assets', { maxAge: 31536000 * 1000 })); // #cache for 1 year
app.use('/assets', express.static('client/dist', { maxAge: 31536000 * 1000 })); // #cache for 1 year
app.use(favicon(`${process.cwd()}/client/assets/favicon.ico`))
app.use(compression())

app.use('/:language/', (req, res, next) => {
  if (config.allowedLanguages.includes(req.params.language)) {
    next()
  } else if (req.params.language == 'robots.txt' || req.params.language == 'memoria2017' || req.params.language == 'memoria2018') {
    next()
  } else {
    res.send(404)
  }
})

const server = app.listen(port, () => console.log(`App listening on port ${port}!`))

server.addListener('connection', (stream) => {
  stream.setTimeout(4000) // timeout 4 s
})

process.on('SIGTERM', () => {
  console.log('Received SIGTERM')
  server.close(() => {
    console.log('Closed out remaining connections.')
    process.exit(0)
  })
})

require('./routes')(app)

module.exports.app = app
