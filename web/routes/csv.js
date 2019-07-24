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

const dbSQL = require('../dbSQL');



router.get('/', function(req, res, next) {
	
	fs.createReadStream(csvPath)
		.pipe(csv())
		.on('data', dbSQL.csvRead)
		.on('end', () => {
			dbSQL.runInsert().then((tableJSON) => {
				res.send(tableJSON);
				dbSQL.insertSpecHeadings().then((specJSON) => {
					res.send(specJSON);
				});
			});
			// res.send("Processing complete");
		});

});
module.exports = router;
