//import mongoose module
var mongoose = require('mongoose');
var properties = require('./properties');

//set up mongoose connection
var mongoDB = properties.databaseURL;
mongoose.connect(mongoDB, {useNewUrlParser: true, useUnifiedTopology: true});

var db = mongoose.connection;

//bind connection to error event for connection errors
db.on('error', console.error.bind(console, 'MongoDB connection error'));

var Schema = mongoose.Schema;

var userSchema = new Schema({
    id: String, //stores blockchain address
    username: String,
    usertype: Number //what kind of organization
});

var users = db.model('users', userSchema); //this is a comment

module.exports = {
    users: users
}