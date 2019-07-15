var express = require('express');
var router = express.Router();

/*
	This route is used to read a CSV at a pre-determined location,
	parse it into sql friendly format,
	then write to DB as necessary.
*/
const csvPath = "data.csv";

const csv = require('csv-parser');  
const fs = require('fs');

const customSQL = require('../sql');



router.get('/', function(req, res, next) {
	
	fs.createReadStream(csvPath)
		.pipe(csv())
		.on('data', customSQL.csvRead)
		.on('end', () => {
			// customSQL.insertSpecHeadings().then((tableJSON) => {
			// 	res.send(tableJSON);
			// });
			res.send("Processing complete");
		});

});
module.exports = router;
