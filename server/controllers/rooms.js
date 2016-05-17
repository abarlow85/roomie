var mongoose = require('mongoose');
var User = mongoose.model('User');
var Room = mongoose.model('Room');

module.exports = (function(){
	return{
		show: function(req, res){
			Room.find({}).exec(function(err, rooms){
				if(err){
					console.log(err.errors);
					console.log('cannot show all rooms');
				} else{
					console.log('showing all rooms');
					res.json(users);
				}
			})
		},

		show_by_id: function(req, res) {
			Room.findOne({name: req.body.name}).exec(function(err, room) {
				if(err){
					console.log('cannot search for room');
				} else {
					console.log('showing room search');
					res.json(room);
				}
			})
		},

		create: function(req, res){
			var room = new Room({name: req.body.name, user: req.body.user, created_at: new Date});
			room.save(function(err, room){
				if(err){
					console.log(err.errors);
					console.log('cannot add room');
				} else{
					console.log("successfully added room")
					res.json(room);
				}
			})
		}

	}
})();