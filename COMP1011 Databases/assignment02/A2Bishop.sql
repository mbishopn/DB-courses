/*		MANUEL BISHOP NORIEGA
		STUDENT ID: 4362207
		Assignment 2 - PODCASTS DATABASE 	*/
-- -------------------------------------------- BUILDING THE DATABASE ---------------------------------------------
DROP DATABASE IF EXISTS A2Manuel;
CREATE DATABASE A2Manuel;
USE A2Manuel;

-- -------  TABLE: PODCASTS ------- 
CREATE TABLE podcasts(
			podcasts_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,     	-- this COULD be the episode number, but is not this time
			podcasts_name VARCHAR(50), 									-- Podcast name
			podcasts_host VARCHAR(50),									-- episode's topic
			podcasts_hasguests BOOLEAN									-- true=has guests false= hasn't guests
);
-- --------- TABLE: GUESTS ---------
CREATE TABLE guests(
			guests_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,			-- PK, unique identifier for guests in table
			guests_fname VARCHAR(25),									-- Guest's first name
			guests_lname VARCHAR(25),									-- Guest's last name
   			guests_credentials VARCHAR(50)								-- Guest's Credentials, who is the guest
);
-- --------- TABLE: PROGRAM ---------
CREATE TABLE program(
			podcast_id INT,								-- podcast_id points to podcasts_id in podcasts table
			guest_id INT,								-- guest_id points to guests_id in guests table
   			program_date DATE,							-- Podcast emision date
            program_topic VARCHAR(80),					-- this program topic

			PRIMARY KEY (podcast_id,guest_id),			-- both fields compose the primary key for episodes table
			FOREIGN KEY (podcast_id)						-- linking tables at table level
			REFERENCES podcasts(podcasts_id),			-- We know there's no such 1:1 relationship in MySQL but here we can simulate that
            FOREIGN KEY (guest_id)
            REFERENCES guests(guests_id)
			ON DELETE RESTRICT ON UPDATE CASCADE		-- by adding the constraint unique to our FK column
);

-- --------- TABLE: TRANSCRIPTS ---------

CREATE TABLE transcripts(
			podcast_id INT PRIMARY KEY,					-- PK and FK, points to related podcast
			transcript_format CHAR(3),					-- Podcast transcript file format: txt, pdf or doc
			transcript_path VARCHAR(50),				-- file path where file is stored
			FOREIGN KEY (podcast_id)					
			REFERENCES podcasts(podcasts_id)			-- We konw there's no such 1:1 relationship in MySQL but here we can simulate that
			ON DELETE RESTRICT ON UPDATE CASCADE		-- by adding the constraint unique to our FK column
);
-- ------------------------------------------------------ INSERTING DATA ------------------------------------------------------
-- -------- PODCASTS DATA ----------
INSERT INTO `podcasts` (`podcasts_name`,`podcasts_host`,`podcasts_hasguests`)
	VALUES
		("The Hardocre Self Help Podcast with duff the psych","Robert Duff",true),
		("The men's self help podcast","Dr. John Moore",false),
		("Self-Helpless","Delanie Fischer & Kelsey Cook",true),
		("Something you should know","Mike Carruthers",true),
   		("Here to Thrive","Kate Snowise",true)
		;
-- -------- GUESTS DATA ------------
INSERT INTO `guests` (`guests_fname`,`guests_lname`,`guests_credentials`)
	VALUES
   		("No guests","Host Only","--"),
		("Anna","Yusim","Psychiatrist"),
		("Shirisha","Avadhanula","Endocrinologist"),
		("Tara","Pringle Jefferson","Journalist"),
		("Tommy","Brennan","hosts' friend"),
		("Judy","Ho","Clinical and Forensic Psychologist")
		;
-- -------- PROGRAM DATA -------
INSERT INTO `program` (`podcast_id`,`guest_id`,`program_date`,`program_topic`)
	VALUES
		(1,2,"2019-08-04","Mental health and spirituality with Dr. Anna Yusim"),
		(2,1,"2022-02-02","Encore: Is it time to take a break from social media?"),
		(3,3,"2023-02-20","Adrenal Insufficiency"),
		(4,2,"2020-03-07","SYSK Choice: What it means to be spiritual & taming your survival instinct"),
		(5,4,"2019-01-03","Tara Pringle Jefferson on Self-Care"),
		(3,5,"2023-02-13","Establishing a daily routine"),
		(5,6,"2019-09-20","Dr. Judy Ho: Self-sabotage")
		;
-- ------- TRANSCRIPTS DATA ------        
  INSERT INTO `transcripts` (`podcast_id`,`transcript_format`,`transcript_path`)
	VALUES
		(1,"txt","/hardcoreSelfHelp"),
		(2,"pdf","/mensSelfHelpPodcast"),
		(3,"txt","/selfHelpless"),
		(4,"doc","/somethingYouShouldKnow"),
   		(5,"txt","/heretothrive")
		;

/* ------------------- Q U E R I E S ------------- */
-- ASNWER 1 - Displaying 2 columns from each table in 1:1 relationship
SELECT podcasts_name AS PODCAST,
	podcasts_host AS HOST_NAME,
    transcript_format,
	transcript_path
FROM podcasts
JOIN transcripts
ON	podcasts_id=podcast_id
WHERE podcasts_name
LIKE "%help%";

-- ANSWER 2 - select 2 or 3 columns from a table with numeric, perform an operation and sorting results from highest to lowest.
SELECT podcasts_name,
	program_date,
	program_topic,
    guests_credentials,
    TIMESTAMPDIFF(DAY,program_date,CURDATE()) AS transmitted_ago_in_days
    -- DATEDIFF(CURDATE(),program_date) AS transmitted_ago_in_days   -- Another way to get the same result for elapsed days since program transmission
FROM podcasts
JOIN program
ON podcasts_id=podcast_id
JOIN guests
ON guest_id=guests_id
ORDER BY transmitted_ago_in_days DESC;

-- ANSWER 3 - List of podcasts with no guests yet
SELECT podcasts_name,
	program_date,
    program_topic,
    CONCAT(guests_fname," ",guests_lname) AS guest
FROM podcasts
JOIN program
ON podcasts_id=podcast_id
JOIN guests
ON guest_id=guests_id
WHERE podcasts_hasguests=false;

-- ANSWER 4 - Display columns from each table in M:N relationship without showing any column from junction table.alter
SELECT podcasts_name as PODCAST,
	podcasts_host AS HOST,
    guests_credentials as TITLE,
    CONCAT(guests_fname," ",guests_lname) as GUEST
FROM podcasts
JOIN program
ON podcasts_id=podcast_id
JOIN guests
ON guest_id=guests_id
ORDER BY podcast;