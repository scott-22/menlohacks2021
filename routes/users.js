var express = require('express');
var router = express.Router();

// User page
router.get('/', function(req, res, next) {
  res.render('users');
});

// Create account
router.get('/signup', function(req, res, next) {
  res.render('adduser');
});

module.exports = router;
