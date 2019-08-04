-- This file was made in MySQL, though the final product may use either MySQL or PostGreSQL
-- The parts and boatParts table are probably bloated; Given input from the client,
-- it should be possible to move many fields over to other tables (like categories)

-- Many mystery columns I've dumped into boatParts. Others I'm not sure how to treat, like "Preferred mfg".
-- Still others (like Weight total) are calculated columns, and have been explicitly excluded
-- Revisit schema with these mystery columns in mind!

CREATE DATABASE IF NOT EXISTS boatdb;
USE boatdb;

-- Parts agnostic list
CREATE TABLE boats (
	`id` INT PRIMARY KEY AUTO_INCREMENT
) ENGINE=NDBCLUSTER;
-- It's just the name, because of the nature of the sample dataset. Real world implementation would inevitably have all the other typical fields
CREATE TABLE manufacturers (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
CREATE TABLE categories (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
CREATE TABLE parts (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`manf` INT NOT NULL, -- FK to manufacturers
	`model` TEXT, -- Might need to spin this off into its own table
	`builderID` TEXT, -- Instead of "New WP I.D.", just store a NULL if no builderID available
	`electrical` TEXT,
	`category` INT, -- FK to categories,
	`unit_measurement` TEXT,
	`link` TEXT, -- hyperlink
	`source` TEXT, -- might be able to drop this column in implementation?
	`weight` FLOAT, -- "Weight Per Unit (LBS)" in CSV
	`size` TEXT, -- consider breaking this down into multiple fields
	FOREIGN KEY (`manf`) REFERENCES manufacturers(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`category`) REFERENCES categories(`id`) ON DELETE RESTRICT
) ENGINE=NDBCLUSTER;
-- I've got no idea what a GCMNA Point person, but hey, they get a table.
CREATE TABLE personnel (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
-- I'm treating headings as categories, and spec headings as subcategories.
CREATE TABLE headings (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
-- Spec Headings appear to be mandatory. If they're not, might need to re-engineer this section
CREATE TABLE specHeadings (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`heading` INT NOT NULL,
	`name` TEXT NOT NULL,
	FOREIGN KEY (`heading`) REFERENCES headings(`id`) ON DELETE RESTRICT
) ENGINE=NDBCLUSTER;
-- Some features are repeated, so I'm thinking they're some kind of tag
CREATE TABLE features (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
-- Defined colorspace
CREATE TABLE colours (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
-- Defined materialspace
CREATE TABLE materials (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
-- locations! Done this way to allow it to be unique in boatParts
CREATE TABLE locations (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;
-- Table of all boat parts. This is likely to have the most records, and thus must be distributed carefully
-- I'm assuming a boat can have the same part in multiple places, so primary key is combination of 3 fields
-- Scratch that, just use a constraint to ensure uniqueness
CREATE TABLE boatParts (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`boatID` INT NOT NULL,
	`partID` INT NOT NULL,
	`location` INT NOT NULL,
	`gcmna_point_person` INT NOT NULL,
	`check_item` TINYINT(1), -- Mystery field! boolean.
	`selected_item` TINYINT(1), -- Mystery field! boolean.
	`update_status` TINYINT(1), -- Mystery field! boolean.
	`history` TEXT, -- Mystery field!
	`specHeading` INT NOT NULL, -- FK specHeadings
	`quantity` INT NOT NULL DEFAULT 0,
	`parent` INT, -- FK boatParts. This is implementation of part hierarchies!
	`lcg` FLOAT NOT NULL DEFAULT 0.0, -- Appears to be part of a coordinate system. Might be rotation longitudinal?
	`tcg` FLOAT NOT NULL DEFAULT 0.0, -- transverse?
	`vcg` FLOAT NOT NULL DEFAULT 0.0, -- vertical?
	`lm` INT NOT NULL DEFAULT 0, -- Longitudinal moment
	`tm` INT NOT NULL DEFAULT 0, -- Transverse moment, port is -ve
	`vm` INT NOT NULL DEFAULT 0, -- Vertical moment
	`colour` INT,
	`material` INT,
	UNIQUE KEY `uniq_part_in_boat` (`boatID`, `partID`, `location`), -- I think this triad is unique? Might need to add specHeading to this
	FOREIGN KEY (`boatID`) REFERENCES boats(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`partID`) REFERENCES parts(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`location`) REFERENCES locations(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`gcmna_point_person`) REFERENCES personnel(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`specHeading`) REFERENCES specHeadings(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`parent`) REFERENCES boatParts(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`colour`) REFERENCES colours(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`material`) REFERENCES materials(`id`) ON DELETE RESTRICT
) ENGINE=NDBCLUSTER;

-- Each boat has multiple features!
CREATE TABLE boatPartFeatures (
	`boatPart` INT NOT NULL,
	`feature` INT NOT NULL,
	PRIMARY KEY (`boatPart`, `feature`),
	FOREIGN KEY (`boatPart`) REFERENCES boatParts(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`feature`) REFERENCES features(`id`) ON DELETE RESTRICT
) ENGINE=NDBCLUSTER;
-- Some columns in the CSV look very specific to one project. These go in this table
-- example: "Places to reduce from 38 Meter"
CREATE TABLE boatPartMeta (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`boatPart` INT NOT NULL,
	`meta_key` TEXT NOT NULL,
	`meta_value` TEXT, -- technically, this is arbitrary data that should be parsed by calling script
	FOREIGN KEY (`boatPart`) REFERENCES boatParts(`id`) ON DELETE RESTRICT
) ENGINE=NDBCLUSTER;

-- Inserts are not in this script. Those will be done via either python script or by uploading a set of formatted CSVs (... probably generated by a python script)
