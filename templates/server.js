const express = require('express')
const app = express();
const port = 3000;
var path    = require("path");
app.use(express.static(__dirname + '/assets'));
app.get('/style.css', function(req, res) {
  res.sendFile(__dirname + "/" + "style.css");
});
app.get('/app.js', function(req, res) {
  res.sendFile(__dirname + "/" + "app.js");
});
app.get('/object_view_directive.js', function(req, res) {
  res.sendFile(__dirname + "/" + "object_view_directive.js");
});
app.get('/object_view_directive.js', function(req, res) {
  res.sendFile(__dirname + "/" + "object_view_directive.js");
});

app.get('/menu.html', function(req, res) {
  res.sendFile(__dirname + "/" + "menu.html");
});

app.get('/object_view_directive.html', function(req, res) {
  res.sendFile(__dirname + "/" + "object_view_directive.html");
});

app.get('/create_object.html', function(req, res) {
  res.sendFile(__dirname + "/" + "create_object.html");
});

app.get('/create_student.html', function(req, res) {
  res.sendFile(__dirname + "/" + "create_student.html");
});

app.get('/object_view.html', function(req, res) {
  res.sendFile(__dirname + "/" + "object_view.html");
});

app.get('/object_view_widget.html', function(req, res) {
  res.sendFile(__dirname + "/" + "object_view_widget.html");
});
app.get('/',function(req,res){
    res.sendFile(path.join(__dirname+'/index.html'));
 });

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
