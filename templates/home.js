var koa = require('koa');
var app = new koa();
var router = require('koa-router');
var bodyParser = require('koa-body');
var serve = require('koa-static');
var generator_func = function* (){
   yield 1;
   yield 2;
};

var itr = generator_func();
console.log(itr.next());
console.log(itr.next());
console.log(itr.next());
var _ = router();
var Pug = require('koa-pug');
var pug = new Pug({
   viewPath: './views',
   basedir: './views',
   app: app
});
app.use(function* (){
   this.body = 'Hello world!';
});
app.use(_.routes());
app.use(bodyParser({
   formidable:{uploadDir: './uploads'},    //This is where the files would come
   multipart: true,
   urlencoded: true
}));

_.get('/:id', sendID);
_.get('/not_found', printErrorMessage);
function *sendID() {
   this.body = 'The id you specified is ' + this.params.id;
}
var path = require('path');
var staticCache = require('koa-static-cache');
app.use(serve('./assets'));
app.use(staticCache(path.join(__dirname, 'assets'), {
   maxAge: 365 * 24 * 60 * 60  //Add these files to caches for a year
}));
_.get('/things/:name/:id', sendIdAndName);
function *printErrorMessage() {
   this.status = 404;
   this.body = "Sorry we do not have this resource.";
}
function *sendIdAndName(){
   this.body = 'id: ' + this.params.id + ' and name: ' + this.params.name;
};
function *handle404Errors(next) {
   if (404 != this.status) return;
   this.redirect('/not_found');
}

_.get('/authorize/:id', setACookie);

function *setACookie(){
   //Expires after 360000 ms from the time it is set.
   this.cookies.set('user_log', 'user ' + his.params.id);
}

            //Instantiate the router
_.get('/hello', getMessage);   // Define routes

function *getMessage() {
   this.body = "Hello world!";
};

_.get('/files', renderForm);
_.post('/upload', handleForm);

function * renderForm(){
   this.render('file_upload');
}

function *handleForm(){
   console.log("Files: ", this.request.body.files);
   console.log("Fields: ", this.request.body.fields);
   this.body = "Received your data!"; //This is where the parsed request is stored
}

app.listen(3000, function(){
   console.log('Server running on https://localhost:3000')
});
