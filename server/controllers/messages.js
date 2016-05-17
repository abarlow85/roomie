var mongoose = require('mongoose');
var Task = mongoose.model('Task');
var User = mongoose.model('User');
var Room = mongoose.model('Room');
var Message = mongoose.mode('Message')

module.exports = (function(){
	return{
		show: function(req, res) {
			Message.find({}, function(err, messages) {
				if(err){
					console.log('cannot show all messages');
				} else{
					res.json(messages);
				}
			})
		},

		create: function(req, res) {
			var message = new Message({content: req.body.content, _room: req.body._room._id, _user: req.body._user._id, _task: req.body._task._id, created_at: new Date});
			message.save(function(err, message){
				if (err){
					console.log(err.errors);
					console.log('cannot create message');
				} else {
					console.log('succesfully created message');
					res.json(message);
				}
				Room.findOneAndUpdate({_id:req.body._room._id}, {'$push': {messages: message._id}}).exec(function(err, messages){
					if(err){
						console.log('error updating message to room');
					} else{
						console.log('successfully updated message to room')
					}
				})
				User.findOneAndUpdate({_id:req.body._user._id}, {'$push': {messages: message._id}}).exec(function(err, messages){
					if(err){
						console.log('error updating message to user');
					} else{
						console.log('successfully updated message to user')
					}
				})
				Task.findOneAndUpdate({_id:req.body._task._id}, {'$push': {messages: message._id}}).exec(function(err, messages){
					if(err){
						console.log('error updating message to task');
					} else{
						console.log('successfully updated message to task')
					}
				})
			});
		}

		// remove: function(req, res) {
		// 	Message.remove({_id: req.params.id}, function(err, messages) {
		// 		if(err) {
		// 			console.log('cannot remove message');
		// 			return err.errors;
		// 		} else {
		// 			console.log('successfully removed message!');
		// 			res.json(true);
		// 		}
		// 	})
		// }


		// update: function(req, res) {
		// 	Message.findOneAndUpdate({_id: req.params.id}, {objective: req.body.objective, expiration_date: req.body.expiration_date, users: req.body.users}, function(err, messages) {
		// 		if(err){
		// 			console.log('cannot update message information');
		// 		} else {
		// 			console.log('successfully updated message information');
		// 			res.json(messages);
		// 		}
		// 	})
		// },


	}
})();