const express = require('express');

const app = express();

const port = 8000;

app.listen(port, function (err) {
   if(err){
      console.log("Error starting server");
   }
   else{
      console.log("Server started on "+port);
   }
})

app.get('/', function(req, res) {
   res.end('My First API')
})

app.get('/200', function(req, res) {
   res.end('200')
})

app.get('/400', function(req, res) {
   res.sendStatus(400)
})

app.get('/500', function(req, res) {
   res.sendStatus(500)
})
