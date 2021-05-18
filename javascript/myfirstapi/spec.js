var request = require('supertest');
describe('loading express', function() {
   var server;
   beforeEach(function(){
      delete require.cache[require.resolve('./server.js')];
      server = require('./server.js');
   });
   afterEach(function(done){
      server.close(done);
   });
   it('responds to /', function testSlash(done){
      request(server)
         .get('/')
         .expect(200, done);
   });

   it('responds to /200', function test200(done){
      request(server)
         .get('/200')
         .expect(200, done);
   });

   it('responds to /400', function test400(done){
      request(server)
         .get('/400')
         .expect(400, done);
   });

   it('responds to /500', function test500(done){
      request(server)
         .get('/500')
         .expect(500, done);
   });

});
