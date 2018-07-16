const express = require('express');
const exphbs = require('express-handlebars');
const device = require('express-device');
const favicon = require('serve-favicon');
const compression = require('compression');
const config = require('config');
// const deviceHelpers = require('./helpers/device-helpers');

const app = express();

const env = process.env.NODE_ENV || 'development';
const port = process.env.PORT || 6100;

const exphbsConf = exphbs.create({
  extname: '.hbs',
  viewsDir: 'server/views/',
  layoutsDir: 'server/views/layouts',
  partialsDir: ['server/views/'],
});

app.engine('.hbs', exphbsConf.engine);

app.set('views', `${__dirname}/views/`);
app.set('view engine', '.hbs');

// app.use(device.capture()); // describes waht type of device the user is using: Desktop/mobile/tablet/etc


app.use('/assets', express.static('client/assets', { maxAge: 31536000 * 1000 })); // #cache for 1 year
app.use('/assets', express.static('client/dist', { maxAge: 31536000 * 1000 })); // #cache for 1 year
// app.use('/assets', express.static('bower_components', { maxAge: 31536000 * 1000 })); // #cache for 1 year
app.use(favicon(`${process.cwd()}/client/assets/favicon.ico`));
app.use(compression());

app.use('/:language/', (req, res, next) => {
  // console.log(`allo/wed langs ${config.allowed_languages}`);
  // console.log('TODO');
  if (config.allowed_languages.includes(req.params.language) || req.params.language == 'robots.txt') { next(); } else { res.send(404); }
});

const server = app.listen(port, () => console.log(`App listening on port ${port}!`));

server.addListener('connection', (stream) => {
  stream.setTimeout(4000); // timeout 4 s
});

process.on('SIGTERM', () => {
  console.log('Received SIGTERM');
  server.close(() => {
    console.log('Closed out remaining connections.');
    process.exit(0);
  });
});

require('./routes')(app);

module.exports.app = app;
