chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
SandboxedModule = require 'sandboxed-module'
chai.should()
expect = chai.expect
chai.use(sinonChai)

Moment = require 'moment-timezone'

TumblrModel = require ('../../../server/models/tumblr')
TumblrHelper = require "../../../server/helpers/tumblr"

post_with_photos =
  blog_name: 'babelpde'
  id: 113775093967
  post_url: 'http://babelpde.tumblr.com/post/113775093967/la-segona-convocatòria-del-taller-de-coaching'
  slug: 'la-segona-convocatòria-del-taller-de-coaching'
  type: 'photo'
  date: '2015-03-16 09:48:17 GMT'
  timestamp: 1426499297
  state: 'published'
  format: 'html'
  reblog_key: 'MNLV3HYM'
  tags: [ 'taller coaching formación barcelona formació acciósocial comunitari BPDE' ]
  short_url: 'http://tmblr.co/Z5IFAl1fzXYZF'
  recommended_source: null
  recommended_color: null
  highlighted: []
  note_count: 0
  caption: '<h2><b>La segona convocatòria \n      del Taller  de            Coaching Social per a professionals  te previst el seu inici al octubre de 2015.</b></h2><p><b><i>Sessions conduïdes per un professional de l\'equip docent del <b>Màster en Coaching Sistèmic de la UAB, d</b>irector del Projecte Fèlix Castillo.</i><br/></b></p><p><b>A qui s’ adreça? </b></p><p>Aquells i aquelles que vulguin acompanyar\ntotes aquelles persones desorientades insatisfetes que volen ajuda per a\nrecuperar el camí de la seva vida. A treballadors/es socials que vulguin\npromoure la autonomia de les persones que estan vivint una situació de\ndesorientació o insatisfacció.</p><p><b>Per a què?</b></p><p><b> </b>Un taller per generar&hellip;Recursos i\nhabilitats, coneixement personal, atenció a les emocions, enfocament sistèmic,\ntreball en xarxa i poder personal.</p><p><b>Sessions:</b></p><p><b>1.    </b><b>Connexió amb un\nmateix. </b></p><p>1.1 D’on ve la meva experiència? </p><p>1.1\nCom me’n ocupo? </p><p><b>2.    </b> <b>Qualitat de la realitat</b>. </p><p>2.1\nOn mira la meva\nmirada? </p><p>2.2\nPot influir en la\nrealitat?</p><p><b>3.    </b><b>La intenció i els\nvalors com a motor</b>. </p><p>3.1\nQue m’impulsa a\nmoure’m? </p><p>3.2\nCap a on vull\nanar?(valors) </p><p><b>4.    </b><b>La relació i la\nconnexió amb els altres</b>. </p><p>4.1\nPots imaginar una vida\nsense ningú? </p><p>4.2\nQui vols que hi sigui?</p><p><b>5.    </b> <b>Acció compromesa  quotidiana</b>. </p><p>5.1\nI ara que faig ? </p><p>5.2\nQuè faig per a què tot\nflueixi ?</p><p><b>Quan i on?</b></p><p>Horari: Tardes de dimarts de 16h a\n20h. <br/></p><p>Lloc: CÈNTRIC – Centre psicopedagògic i de teràpia psicomotriu.\nC/Balmes 13 principal 08007 Barcelona.</p><p>Places limitades a 15 alumnes. Si\nla demanda és superior es valorarà fer un segon grup.<br/></p><p>Preu 300€</p><p>Més informació a: 629577430//932955793</p><p><a href="mailto:gestion@babelpuntodeencuentro.org"><b>gestion@babelpuntodeencuentro.org</b></a></p><p><b> o </b></p><p><a href="mailto:info@babelpuntodeencuentro.org"><b>info@babelpuntodeencuentro.org</b></a></p>'
  reblog:
    tree_html: '',
    comment: '<h2><b>La segona convocat&ograve;ria del Taller de Coaching Social per a professionals &nbsp;te previst el seu inici al octubre de 2015.</b></h2><p><b><i>Sessions condu&iuml;des per un professional de l\'equip docent del <b>M&agrave;ster en Coaching Sist&egrave;mic de la UAB, d</b>irector del Projecte F&egrave;lix Castillo.</i><br></b></p><p><b>A qui s&rsquo; adre&ccedil;a?&nbsp;</b></p><p>Aquells i aquelles que vulguin acompanyar\ntotes aquelles persones desorientades insatisfetes que volen ajuda per a\nrecuperar el cam&iacute; de la seva vida. A treballadors/es socials que vulguin\npromoure la autonomia de les persones que estan vivint una situaci&oacute; de\ndesorientaci&oacute; o insatisfacci&oacute;.</p><p><b>Per a qu&egrave;?</b></p><p><b>&nbsp;</b>Un taller per generar&hellip;Recursos i\nhabilitats, coneixement personal, atenci&oacute; a les emocions, enfocament sist&egrave;mic,\ntreball en xarxa i poder personal.</p><p><b>Sessions:</b></p><p><b>1.&nbsp;&nbsp;&nbsp; </b><b>Connexi&oacute; amb un\nmateix. </b></p><p>1.1 D&rsquo;on ve la meva experi&egrave;ncia? </p><p>1.1\nCom me&rsquo;n ocupo? </p><p><b>2.&nbsp;&nbsp;&nbsp; </b> <b>Qualitat de la realitat</b>. </p><p>2.1\nOn mira la meva\nmirada? </p><p>2.2\nPot influir en la\nrealitat?</p><p><b>3.&nbsp;&nbsp;&nbsp; </b><b>La intenci&oacute; i els\nvalors com a motor</b>. </p><p>3.1\nQue m&rsquo;impulsa a\nmoure&rsquo;m? </p><p>3.2\nCap a on vull\nanar?(valors) </p><p><b>4.&nbsp;&nbsp;&nbsp; </b><b>La relaci&oacute; i la\nconnexi&oacute; amb els altres</b>. </p><p>4.1\nPots imaginar una vida\nsense ning&uacute;? </p><p>4.2\nQui vols que hi sigui?</p><p><b>5.&nbsp;&nbsp;&nbsp; </b> <b>Acci&oacute; compromesa &nbsp;quotidiana</b>. </p><p>5.1\nI ara que faig&nbsp;? </p><p>5.2\nQu&egrave; faig per a qu&egrave; tot\nflueixi&nbsp;?</p><p><b>Quan i on?</b></p><p>Horari: Tardes de dimarts de 16h a\n20h.&nbsp;<br></p><p>Lloc: C&Egrave;NTRIC &ndash; Centre psicopedag&ograve;gic i de ter&agrave;pia psicomotriu.\nC/Balmes 13 principal 08007 Barcelona.</p><p>Places limitades a 15 alumnes. Si\nla demanda &eacute;s superior es valorar&agrave; fer un segon grup.<br></p><p>Preu 300&euro;</p><p>M&eacute;s informaci&oacute; a: 629577430//932955793</p><p><a href="mailto:gestion@babelpuntodeencuentro.org"><b>gestion@babelpuntodeencuentro.org</b></a></p><p><b> o </b></p><p><a href="mailto:info@babelpuntodeencuentro.org"><b>info@babelpuntodeencuentro.org</b></a></p>' 
  trail: []
  image_permalink: 'http://babelpde.tumblr.com/image/113775093967'
  photos: [ { caption: '', alt_sizes: [ 
                { width: 1211, height: 850, url: 'http://41.media.tumblr.com/63eaeca665f428b2b0568cdfed417b68/tumblr_nlatwhOopd1upnec3o1_1280.jpg' },
                { width: 500, height: 351, url: 'http://41.media.tumblr.com/63eaeca665f428b2b0568cdfed417b68/tumblr_nlatwhOopd1upnec3o1_500.jpg' },
                { width: 400, height: 281, url: 'http://41.media.tumblr.com/63eaeca665f428b2b0568cdfed417b68/tumblr_nlatwhOopd1upnec3o1_400.jpg' },
                { width: 250, height: 175, url: 'http://40.media.tumblr.com/63eaeca665f428b2b0568cdfed417b68/tumblr_nlatwhOopd1upnec3o1_250.jpg' },
                { width: 100, height: 70, url: 'http://40.media.tumblr.com/63eaeca665f428b2b0568cdfed417b68/tumblr_nlatwhOopd1upnec3o1_100.jpg' },
                { width: 75, height: 75,  url: 'http://41.media.tumblr.com/63eaeca665f428b2b0568cdfed417b68/tumblr_nlatwhOopd1upnec3o1_75sq.jpg' } 
              ],original_size: { width: 1211, height: 850, url: 'http://41.media.tumblr.com/63eaeca665f428b2b0568cdfed417b68/tumblr_nlatwhOopd1upnec3o1_1280.jpg' }}]

post_text_only = { 
  blog_name: 'babelpde',
  id: 112551551482,
  post_url: 'http://babelpde.tumblr.com/post/112551551482/nuestro-nuevo-website',
  slug: 'nuestro-nuevo-website',
  type: 'text',
  date: '2015-03-02 23:18:22 GMT',
  timestamp: 1425338302,
  state: 'published',
  format: 'html',
  reblog_key: 'wUYnUAk1',
  tags: [],
  short_url: 'http://tmblr.co/Z5IFAl1eqc67w',
  recommended_source: null,
  recommended_color: null,
  highlighted: [],
  note_count: 0,
  title: 'Nuestro nuevo website',
  body: '<p>Hola desde nuestro nuevo website! :)</p>',
  reblog: { tree_html: '', comment: '<p>Hola desde nuestro nuevo website! :)</p>' },
  trail: [ { blog: [],post: [],content_raw: '<p>Hola desde nuestro nuevo website! :)</p>',content: '<p>Hola desde nuestro nuevo website! :)</p>',is_current_item: true,is_root_item: true } ],
  }

describe 'Unit Testing Tumblr Helper', () ->
  console.log "move these tests to the model test"
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
  
  describe "A text tumblr post", () ->
    language = 'es'
    foo = TumblrHelper.prettyPrintPost(post_text_only,language)
    console.log "foo", foo
    it "should contain the newly created keys", (done) ->
      expect(foo).to.include.keys('body_summary')
      done()
    
    it "should have the moment date", (done) ->
      expect(foo.date).to.eq(Moment(foo.timestamp, 'X').tz("Europe/Madrid").locale(language).format('LLL'))
      done()
      
  describe "A Photo Tumblr Post", () ->
    language = 'es'
    foo = TumblrHelper.prettyPrintPost(post_with_photos,language)
    console.log "foo", foo
      
    it "should have halt if there's no post", (done) ->
      
      expect(foo.date).to.eq(Moment(foo.timestamp, 'X').tz("Europe/Madrid").locale(language).format('LLL'))
      #expect(foo).to.include.keys('caption_summary')
      #expect(foo).to.not.to.be.ok
      done()
      
    it "should contain the altered keys", (done) ->
      expect(foo).to.include.keys('caption_summary')
      expect(foo.photos[0]).to.include.keys('picked_size')
      expect(foo).to.include.keys('title')
      expect(foo).to.include.keys('isPhoto')
      
      done()
      
    describe "should have the title", () ->
      
      it "should not contain new lines chars", (done) ->
        expect(foo.caption).to.not.to.contain('\n')
        
        done()
      
      it "should contain the text between of the first h2 tag without any newlines and no extra space", (done) ->
        expect(foo.title).to.not.to.contain('   ')
        done()