_ = require 'lodash'
LanguageId = require '../helpers/language'
routes = require '../views/routes'

module.exports.get = (req, res) ->
  opts =  {layout: 'babel'}
  
  language = req.params.language
  language = 'es' unless language
  content = req.params.content
  content = 'index' unless content

  _.extend(opts, LanguageId(language))
  
  if _.contains(routes[language], content)
    res.render("#{language}/#{content}", opts)
  else
    res.render("#{language}/error", opts)
    
module.exports.index = (req, res) ->
  opts =  {layout: 'babel', isEs: true}
  res.render("es/index", opts)