// load all the things we need
var LocalStrategy   = require('passport-local').Strategy;

var User = mongoose.model('User');

module.exports = function(passport) {

	// =========================================================================
    // passport session setup ==================================================
    // =========================================================================
    // required for persistent login sessions
    // passport needs ability to serialize and unserialize users out of session

    // used to serialize the user for the session
    passport.serializeUser(function(user, done) {
        done(null, user.id);
    });

    // used to deserialize the user
    passport.deserializeUser(function(id, done) {
        User.findById(id, function(err, user) {
            done(err, user);
        });
    });

    passport.use('local-signup', new LocalStrategy({
        // by default, local strategy uses username and password, we will override with email
        usernameField : 'email',
        passwordField : 'password',
        passReqToCallback : true // allows us to pass back the entire request to the callback
    },
    function(req, name, email, password, room, done) {
    	// asynchronous
        // User.findOne wont fire unless data is sent back
    	process.nextTick(function(){

    		// find a user whose email is the same as the forms email
        // we are checking to see if the user trying to login already exists
        User.findOne({ 'email' :  email }, function(err, user) {
            // if there are any errors, return the error
            if (err)
                return done(err);

            // check to see if theres already a user with that email
            if (user) {
                return done(null, false, req.json({'error':'That email is already taken.'}));
            } else {

            	var newUser = new User();
            	newUser.name = name;
            	newUser.email = email;
            	newUser.password = newUser.generateHash(password);
            	newUser.room = room;
            	newUser.save(function(err) {
            		if (err) {
            			console.log(err);
            		} else {
            			return done(null, newUser);
            		}
            	});
            }
    	});
    	});
    }));

    passport.use('local-login', new LocalStrategy ({
    	usernameField : 'email',
    	passwordField : 'password',
    	passReqToCallback : true
    },
    function(req, email, password, done) {
    	User.findOne({'email': email}, function(err, user){
    		if (err) {
    			return done(err);
    		}
    		if (!user) {
    			return done(null, false, req.json({'error' : 'Incorrect user credentials'}));
    		}
    		if (!user.validPassword(password)) {
    			return done(null, false, req.json({'error' : 'Incorrect user credentials'}));
    		}
    		return done(null, user);
    	});
    }));
}