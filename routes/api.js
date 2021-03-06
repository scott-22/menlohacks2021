var express = require('express');
var router = express.Router();

var database = require('../database');
var properties = require('../properties.js');
var ShipmentCenter = require('../build/contracts/ShipmentCenter.json');
var Shipment = require('../build/contracts/Shipment.json');

// API endpoints
router.get('/getuser', function(req, res, next) {
    address = req.query.address;
    database.users.findOne({id: address})
        .then(query => {
            if (query) 
                res.status(200).send(JSON.stringify(query));
            else 
                res.status(404).send(JSON.stringify({error: "No user associated with this address"}));
        })
        .catch(err => {
            console.log(err);
            res.status(500).send({error: "Something went wrong"});
        });
});

// TODO: add verification
router.post('/adduser', function(req, res, next) {
    if (!req.body.name || !req.body.type || !req.body.address)
        res.status(400).send(JSON.stringify({error: "Missing field!"}));
    else {
        database.users.findOne({id: req.body.address})
            .then(query => {
                if (query) throw {error: "User already exists!"};
                else {
                    let user = new database.users({
                        id: req.body.address,
                        username: req.body.name,
                        usertype: req.body.type
                    });
                    user.save(err => {console.log(err)});
                    res.sendStatus(200);
                }
            })
            .catch(err => {
                console.log(err);
                res.status(400).send(JSON.stringify(err));
            });
    }
});

router.get('/shippingcenter/address', function(req, res, next) {
    res.send(JSON.stringify({address: properties.shippingCenter}));
});

router.get('/shippingcenter/abi', function(req, res, next) {
    res.json(ShipmentCenter["abi"]);
});

router.get('/shipment/abi', function(req, res, next) {
    res.json(Shipment["abi"]);
});

router.get('/users', function(req, res, next) {
    database.users.find()
        .then(query => {
            res.send(JSON.stringify(query));
        })
        .catch(err => {
            console.log(err);
        });
});

module.exports = router;