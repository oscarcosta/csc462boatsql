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
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT
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

-- Defined materialspace
CREATE TABLE materials (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` TEXT NOT NULL
) ENGINE=NDBCLUSTER;

CREATE TABLE parts (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`specHeading` INT NOT NULL, -- FK specHeadings
	`model` TEXT, -- Might need to spin this off into its own table
	`link` TEXT, -- hyperlink
	`source` TEXT, -- might be able to drop this column in implementation?
	`weight` FLOAT, -- "Weight Per Unit (LBS)" in CSV
	`material_and_color` INT,
	`size` TEXT,
	FOREIGN KEY (`material_and_color`) REFERENCES materials(`id`) ON DELETE RESTRICT
	FOREIGN KEY (`specHeading`) REFERENCES specHeadings(`id`) ON DELETE RESTRICT,
) ENGINE=NDBCLUSTER;

-- Some features are repeated, so I'm thinking they're some kind of tag
CREATE TABLE features (
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
	`parent` INT, -- FK boatParts. This is implementation of part hierarchies!
	`location` INT NOT NULL,
	`quantity` INT NOT NULL DEFAULT 0,
	`lcg` FLOAT NOT NULL DEFAULT 0.0, -- Appears to be part of a coordinate system. Might be rotation longitudinal?
	`tcg` FLOAT NOT NULL DEFAULT 0.0, -- transverse?
	`vcg` FLOAT NOT NULL DEFAULT 0.0, -- vertical?
	`lm` INT NOT NULL DEFAULT 0, -- Longitudinal moment
	`tm` INT NOT NULL DEFAULT 0, -- Transverse moment, port is -ve
	`vm` INT NOT NULL DEFAULT 0, -- Vertical moment
	UNIQUE KEY `uniq_part_in_boat` (`boatID`, `partID`, `location`), -- I think this triad is unique? Might need to add specHeading to this
	FOREIGN KEY (`boatID`) REFERENCES boats(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`partID`) REFERENCES parts(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`location`) REFERENCES locations(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`parent`) REFERENCES boatParts(`id`) ON DELETE RESTRICT,
) ENGINE=NDBCLUSTER;

-- Each boat has multiple features!
CREATE TABLE partFeatures (
	`part` INT NOT NULL,
	`feature` INT NOT NULL,
	PRIMARY KEY (`part`, `feature`),
	FOREIGN KEY (`part`) REFERENCES parts(`id`) ON DELETE RESTRICT,
	FOREIGN KEY (`feature`) REFERENCES features(`id`) ON DELETE RESTRICT
) ENGINE=NDBCLUSTER;