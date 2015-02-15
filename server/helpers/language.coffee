module.exports = (language) ->
  return {isEs : true} if language == 'es'
  return {isCat : true} if language == 'cat'
  return {isEn : true} if language == 'en'
    