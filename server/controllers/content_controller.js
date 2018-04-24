const {
  routes, allowedLanguages, layout, tumblr,
} = require('config');

module.exports.index = function (req, res) {
  return res.redirect(302, '/es/home/');
};

module.exports.get = (req, res) => {
  let status = 404;
  const language = req.params.language;

  if (allowedLanguages.includes(language)) {
    let template;
    const content = req.params.content;
    const opts = {
      layout, tumblr_on: tumblr.on, is_mi_grano_de_arena: false, locals: res.locals, ga: null,
    };

    if (routes[language].includes(content)) {
      template = `${language}/${content}`;
      status = 200;
    } else {
      template = `${language}/error`;
    }
    res.status(status).render(template, opts);
  } else { res.send(status); }
};
