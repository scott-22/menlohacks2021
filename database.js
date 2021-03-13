//import mongoose module
var mongoose = require('mongoose');
var properties = require('./properties');

//set up mongoose connection
var mongoDB = `mongodb+srv://hackathon:${properties.databasePassword}@hackathon.lujvz.mongodb.net/hackathon?retryWrites=true&w=majority`;
mongoose.connect(mongoDB, {useNewUrlParser: true, useUnifiedTopology: true});

var db = mongoose.connection;

//bind connection to error event for connection errors
db.on('error', console.error.bind(console, 'MongoDB connection error'));

var Schema = mongoose.Schema;

var userSchema = new Schema({
    id: String, //stores blockchain address
    username: String,
    userType: Number //what kind of organization
});

var users = db.model('users', userSchema);