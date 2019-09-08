const {routes, allowedLanguages, layout, tumblr} = require('config')

module.exports.index = function (req, res) {
  const language = req.params.language || 'es' // defaults to /es/
  return res.redirect(302, `/${language}/home/`)
}

module.exports.get = (req, res) => {
  let status = 404
  const language = req.params.language

  if (allowedLanguages.includes(language)) {
    let template
    const content = req.params.content
    const opts = {
      layout: `babel_${language}`,
      tumblr_on: tumblr.on,
      is_mi_grano_de_arena: false,
      locals: res.locals,
      ga: null,
      language: language
    }

    if (routes[language].includes(content)) {
      template = `${language}/${content}`
      status = 200
    } else {
      template = `${language}/error`
    }
    res.status(status).render(template, opts)
  } else { res.send(status); }
}
