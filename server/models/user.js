var mongoose = require('mongoose');
var bcrypt = require('bcrypt-nodejs');

var Schema = mongoose.Schema;
var userSchema = new mongoose.Schema({
	name: String,
	email: String,
	password: String,
	_room: [{type: Schema.Types.ObjectId, ref: 'Room'}],
	messages: [{type: Schema.Types.ObjectId, ref:'Message'}],
	created_at: {type: Date, default: new Date}
});

userSchema.methods.generateHash = function(password) {
	return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

userSchema.methods.validPassword = function(password) {
	return bcrypt.compareSync(password, this.password);
};

var User = mongoose.model('User', userSchema);

