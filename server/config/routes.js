var tasks = require('../controllers/tasks.js')
var users = require('../controllers/users.js')
var rooms = require('../controllers/rooms.js')

module.exports = function(app, passport) {


// User routes
	app.post('/login', passport.authenticate('local-login', {
        successRedirect: '/profile',
        failureRedirect: '/login'
    });

	app.get('/users', function(req, res){
		users.show(req, res);
	})

	app.get('/users/:id', function(req, res){
		users.show_by_id(req, res);
	})

	app.post('/users/addtoroom', function(req, res){
		users.add_to_room(req, res);
	})

// Task routes
	app.get('/tasks', function(req, res){
		tasks.show(req, res);
	});

	app.post('/tasks/create', function(req, res){
		tasks.create(req, res);
	})

	app.post('/tasks/update', function(req, res){
		tasks.update(req, res);
	})

	app.post('/tasks/remove', function(req, res){
		tasks.remove(req, res);
	})

// Room routes
	app.get('/rooms', function(req, res){
		rooms.show(req, res);
	})

	app.get('/rooms/:id', function(req, res){
		rooms.show_by_id(req, res);
	})

	app.post('/rooms/create', function(req, res){
		rooms.create(req, res);
	})
}