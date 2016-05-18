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
					res.json(rooms);
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
		var room = new Room({name: req.body.name, users: req.body.user._id, created_at: new Date});
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

		// create: function(req, res){
		// 	console.log("adding rooms");
		// 	var room = new Room({name: "123", category: "UC Berkeley", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")
					
		// 		}
		// 	})
		// 	var room = new Room({name: "321", category: "UC Berkeley", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")
					
		// 		}
		// 	})
		// 	var room = new Room({name: "541", category: "UC Berkeley", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")
					
		// 		}
		// 	})
		// 	var room = new Room({name: "7363", category: "UC Berkeley", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")
					
		// 		}
		// 	})
		// 	var room = new Room({name: "1", category: "UC Davis", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")
					
		// 		}
		// 	})
		// 	var room = new Room({name: "13", category: "UC Davis", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")	
		// 		}
		// 	})
		// 	var room = new Room({name: "12", category: "UC Davis", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")	
		// 		}
		// 	})
		// 	var room = new Room({name: "1", category: "Coding Dojo", created_at: new Date});
		// 	room.save(function(err, room){
		// 		if(err){
		// 			console.log(err.errors);
		// 			console.log('cannot add room');
		// 		} else{
		// 			console.log("successfully added room")	
		// 		}
		// 	})
		// }
		

	}
})();