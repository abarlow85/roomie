var tasks = require('../controllers/tasks.js')

module.exports = function(app, passport) {

	app.post('/login', passport.authenticate('local-login', {

		successRedirect: '/profile',
		failureRedirect: '/login'
	});

	app.post('/tasks', function(req, res){
		tasks.create(req, res);
	});

}