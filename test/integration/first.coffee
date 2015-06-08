request = require 'supertest'
assert = require 'assert'
app = require '../../server'

server = request(app.app)

describe 'GET /', () ->
  describe "hiting /", ->
    it "should be moved to a filename named home"
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
  describe '/es/que_hacemos', ->
    it 'should render the spanish version of the website', (done)->
      server
      .get('/es/que_hacemos')
      .expect(200)
      .end((err, res) ->
        if err
          return done(err)
        else
          done()
        )
    it 'should not render 404 when the page does not exist', (done)->
      server
      .get('/es/foobar_fake_root')
      .expect(404)
      .end((err, res) ->
        if err
          return done(err)
        else
          done()
        )

describe "tumblr", ->
  describe "tumblr is not properly configured", -> 
    it "should not connect with wrong credentials"
    it "should not get any values"
    it "should render a news page without any news"
