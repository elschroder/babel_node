chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
SandboxedModule = require 'sandboxed-module'
chai.should()
expect = chai.expect
chai.use(sinonChai)
TumblrModel = require ('../../server/models/tumblr')

describe 'Unit Testing Tumblr Mode', () ->
  describe "wrong credentials", () ->
    it "will not fetch a single post", (done) ->
      sinon.stub(TumblrModel, 'getPosts').yields('401 Not Authorized',null)
      err = sinon.spy()
      res = sinon.spy()
      TumblrModel.get(10, (err,res) -> 
        expect(err).to.not.to.be.ok
        done()  
        )
    
    it "will not fecth a collection of posts!", (done) ->
      err = sinon.spy()
      res = sinon.spy()
      TumblrModel.getPost('someId', (err,res) -> 
        expect(err).to.not.to.be.ok
        done()  
        )