/*
MANUEL BISHOP NORIEGA
NICHOLAS LAMARCHE
*/


DROP DATABASE IF EXISTS Feb2023Manuel;

CREATE DATABASE Feb2023Manuel;
USE Feb2023Manuel;

CREATE TABLE band(
				bandId INT PRIMARY KEY AUTO_INCREMENT,
				bandName VARCHAR(20),
                bandDateF DATE);
                
CREATE TABLE song(
				songId INT PRIMARY KEY AUTO_INCREMENT,
				songName	VARCHAR(20),
                songPrice	DECIMAL(4,2),
                songTt	BOOLEAN,
                bandId INT,
                FOREIGN KEY (bandId)
				REFERENCES band(bandId)
                ON DELETE RESTRICT ON UPDATE CASCADE);
                
CREATE TABLE leadSinger(
				songId INT PRIMARY KEY UNIQUE,
				leadFname	VARCHAR(20),
                leadLname	VARCHAR(20),
                FOREIGN KEY (songId)
				REFERENCES song(songId)
                ON DELETE RESTRICT ON UPDATE CASCADE);
                
INSERT INTO band (bandName, bandDateF)
		VALUES
			("Led Zeppelin","1968-08-28"),
   			("Queen","1970-04-22"),
            ("The Strokes","1998-02-28");
            
INSERT INTO song (songName, songPrice, songTt,bandId)
		VALUES
			("Immigrant Song",6,false,1),
   			("We are the Champions",2.99,true,2),
            ("Hard to Explain",5.99,false,3),
            ("Kashmir",1,true,1),
            ("Bohemian Rhapsody",12.99,true,2);
            
INSERT INTO leadSinger (songId, leadFname, leadLname)
		VALUES
			(1,"Robert","Plant"),
   			(2,"Freddie","Mercury"),
            (3,"Julian","Casablancas"),
            (4,"Manuel","Bishop"),
            (5,"Freddie","Mercury");
            
SELECT * FROM band;
SELECT * FROM song;
SELECT * FROM leadSinger;
SELECT songName, bandName FROM song
JOIN band
ON band.bandId=song.bandId;
