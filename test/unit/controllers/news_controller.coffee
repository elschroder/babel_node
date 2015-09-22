chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
SandboxedModule = require 'sandboxed-module'
chai.should()
expect = chai.expect
chai.use(sinonChai)



describe 'Unit Testing news controllers', () ->
