request = require 'supertest'
assert = require 'assert'
app = require '../server'

server = request(app.app)


describe 'GET /', () ->
  describe "hiting /", ->
    it 'should return 301', (done) ->
      console.log 'app',app.app
      server
      .get('/')
      .expect(301)
      .end((err, res)->
        if err
          return done(err)
        else
          assert.equal(res.header['location'], '/es/')
          done()
        )
describe 'hiting the language root', ->
  describe '/es/', ->
    it 'should render the spanish version of the website', (done)->
      server
      .get('/es')
      .expect(200)
      .end((err, res) ->
        if err
          return done(err)
        else
          return done(res)
        )
        