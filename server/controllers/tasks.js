var mongoose = require('mongoose');
var Task = mongoose.model('Task');
var User = mongoose.model('User');
var Room = mongoose.model('Room');

module.exports = (function(){
	return{
		show: function(req, res) {
			Task.find({}, function(err, tasks) {
				if(err){
					console.log('cannot show all tasks');
				} else{
					res.json(tasks);
				}
			})
		},

		create: function(req, res) {
			var task = new Task({objective: req.body.objective, expiration_date: req.body.expiration_date, _room: req.body._room, users: req.body.users});
			task.save(function(err, task){
				if (err){
					console.log(err.errors);
					console.log('cannot create task');
				} else {
					console.log('succesfully created task');
					Room.findOneAndUpdate({_id:req.body._room}, {'$push': {tasks: task._id}}, {new: true}).exec(function(err, room){
						if(err){
							console.log('error updating task to room');
						} else{
							console.log('successfully updated task to room')
							console.log(room)
							res.json(room);
						}
					});
				}
				
			});
		},

		update: function(req, res) {
			Task.findOneAndUpdate({_id: req.params.id}, {objective: req.body.objective, expiration_date: req.body.expiration_date, users: req.body.users}, function(err, tasks) {
				if(err){
					console.log('cannot update task information');
				} else {
					console.log('successfully updated task information');
					res.json(tasks);
				}
			})
		},

		remove: function(req, res) {
			Task.remove({_id: req.params.id}, function(err, tasks) {
				if(err) {
					console.log('cannot remove task');
					return err.errors;
				} else {
					console.log('successfully removed task!');
					res.json(true);
				}
			})
			Room.findOneAndUpdate({_id: req.body.room._id}, {'$pull': {tasks: task._id}}).exec(function(err, tasks){
				if(err){
					console.log('cannot update task information');
				} else {
					console.log('successfully updated task information');
					res.json(tasks);
				}
			})
			Message.find({_task: req.params.id}, function(err, messages){
				if(err){
					console.log('error')
				} else {
					
				}
			})
		}


	}
})();