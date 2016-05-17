var mongoose = require('mongoose');
var Task = mongoose.model('Task');

module.exports = {

	index: function(req, res) {
		console.log("in index")
		Task.find({}, function(err, tasks) {
			console.log(err, tasks)
			res.json(tasks);
		});
	},

	create: function(req, res) {
		console.log("create model");
		var task = new Task(req.body);
		task.save(function(err, task){
			console.log(task)
			if (err){
				console.log(err);
			} else {
				res.json(task);
			}
		});
	}

}