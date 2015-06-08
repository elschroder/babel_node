chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
SandboxedModule = require 'sandboxed-module'
chai.should()
expect = chai.expect
chai.use(sinonChai)
TumblrModel = require ('../../server/models/tumblr')

describe 'integration Testing Tumblr Mode', () ->
  describe "with proper credentials", ->   
    describe "get tumblr posts", ->
      it "get only 1 item", (done) ->
        err = sinon.spy()
        res = sinon.spy()
        TumblrModel.getPost('117762897737', (err,res) ->
          expect(err).to.not.to.be.ok
          expect(res.length).to.deep.equal(1)
          done()  
          )
                
      it "get at most 10 items", (done) ->
        err = sinon.spy()
        res = sinon.spy()
        TumblrModel.get(10, (err,res) ->
          expect(err).to.not.to.be.ok
          expect(res.length).to.be.at.most(10)
          done()
          )

