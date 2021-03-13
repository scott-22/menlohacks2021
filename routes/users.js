var express = require('express');
var router = express.Router();

// User page
router.get('/', function(req, res, next) {
  fetch('/api/getuser')
    .then(res => response.json)
  res.render('users');
});

module.exports = router;
