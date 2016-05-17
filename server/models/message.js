var mongoose = require('mongoose');

var Schema = mongoose.Schema;
var messageSchema = new mongoose.Schema({
	content: String,
	_user: {type: Schema.Types.ObjectId, ref: 'User'},
	_task: {type: Schema.Types.ObjectId, ref: 'Task'},
	created_at: {type: Date, default: new Date}
});

userSchema.methods.generateHash = function(password) {
	return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

userSchema.methods.validPassword = function(password) {
	return bcrypt.compareSync(password, this.password);
};

var User = mongoose.model('User', userSchema);

