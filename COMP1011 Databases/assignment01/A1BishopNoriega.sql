/*		MANUEL BISHOP NORIEGA
		STUDENT ID: 4362207
		Assignment 1 - Create your own database 	*/
-- -------------------------------------------- BUILDING THE DATABASE ---------------------------------------------
DROP DATABASE IF EXISTS BishopComputersInv;
CREATE DATABASE BishopComputersInv;
USE BishopComputersInv;

-- ------- PRIMARY TABLE: COMPUTERS ------- 
CREATE TABLE computer(
			computer_id CHAR(6) PRIMARY KEY NOT NULL,
			computer_type CHAR(1) CHECK (computer_type IN ('L','D')), 	-- L=latop, D=desktop, I read about check constraint and wanted to try
			acquisition_date DATE,										-- when device arrived company, helpful to calculate life and services dates
			assigned BOOLEAN,											-- 0=unassigned or 1=assigned to a user
			computer_status CHAR(1),									-- S=stock, R=in repair, D=to be discarded, A=assigned and fully operting
			computer_cost DECIMAL(7,2)									-- for accounting dept, it's all about money :D 
);
/*		--------- TABLE: COMPONENTS ---------
	ONE computer my have MANY components and
	ONE component can belong to only ONE computer. (1:M)
*/
CREATE TABLE parts(
			parts_sn VARCHAR(50) PRIMARY KEY NOT NULL,	-- PK, varchar because not all s/n are only numbers or text
			parts_type INT,								-- 1=drive, 2=cpu, 3=ram, 4=nic
			spare_pn VARCHAR(25),						-- manufacturer/provider spare part number
			parts_desc VARCHAR(50),						-- brief description of component features
			parts_cid CHAR(6),							-- FK, points to computer this part belgons to

			FOREIGN KEY (parts_cid)						-- creating 1:M relationship with parent table at table-level
			REFERENCES computer(computer_id)
			ON DELETE RESTRICT ON UPDATE CASCADE
);
/*		--------- TABLE: USERS ---------
	ONE computer may be assigned to ONE user/employee and 
	ONE user can be responsible for ONE computer (1:1)
*/
CREATE TABLE users(
			users_id VARCHAR(6)	PRIMARY KEY NOT NULL,	-- PK for user FORMAT: ddnnnn where dd=dept identifier nnnn=numeric value
			users_fname VARCHAR(50),					-- really? ok, user first name
			users_lname VARCHAR(50),					-- user last name
			users_phone VARCHAR(20),					-- user phone number
			users_assign_date DATE,						-- the day from which user is responsible for assigned computer, 1st day in company
			users_dept VARCHAR(15),						-- sales, warehouse, accounting, it, etc.
			users_cid CHAR(6) UNIQUE NOT NULL,			-- FK, points to computer assigned to user and with NOT NULL constraint there´s no way to
														-- add a user without computer
			FOREIGN KEY (users_cid)						-- linking tables at table level
			REFERENCES computer(computer_id)			-- We konw there's no such 1:1 relationship in MySQL but here we can simulate that
			ON DELETE RESTRICT ON UPDATE CASCADE		-- by adding the constraint unique to our FK column
);

-- ------------------------------------------------------ INSERTING DATA ------------------------------------------------------
-- -------- COMPUTERS DATA ----------
INSERT INTO `computer` (`computer_id`,`computer_type`,`acquisition_date`,`assigned`,`computer_status`,`computer_cost`)
	VALUES
		("839658","L","2022-02-15",false,"S",4208.50),
		("765651","L","2021-07-08",true,"A",4204.00),
		("903700","D","2021-03-11",true,"A",3327.13),
		("378074","D","2018-10-27",false,"S",2619.99),
		("407925","L","2019-07-25",true,"R",1318),
		("233223","D","2020-09-28",false,"D",1243.35),
		("760964","L","2018-08-06",true,"A",1082.87),
		("835733","L","2020-08-30",true,"A",790),
		("891076","L","2021-04-28",true,"A",395.99),
		("271291","L","2022-10-07",true,"R",309.15);
-- -------- PARTS DATA ------------
INSERT INTO `parts` (`parts_sn`,`parts_type`,`spare_pn`,`parts_desc`,`parts_cid`)
	VALUES
		("TAD45SSD5574EV",1,"74YW5JKV","M.2 SSD 960GB",839658),
		("DRI41MYI7235GI",1,"61KS3DRP","M.2 SSD 960GB",765651),
		("PNK57XVY8191JP",1,"44NL2YMK","SATA 3.5"" SSD 500GB",903700),
		("KNH71ECK4389MI",1,"05LQ8UZL","SATA SSD 240GB",378074),
		("RAA97LKE1160ZO",1,"83QF3UNN","SATA 2.5"" SSD 500GB",407925),
		("HUD04HHR2351RY",1,"15NX8AGX","SATA 3.5"" 7500rpm 1GB",233223),
		("FDX33JPY8447TL",1,"86BJ5MJF","SATA 2.5"" 7500rpm 1GB",760964),
		("COM99YUP6785MI",1,"78CT7HPI","M.2 SSD 960GB",835733),
		("RMW14KFW9775HW",1,"66IR7LQS","SATA 2.5"" 7500rpm 1GB",891076),
		("GSE13FLJ3644TW",1,"78VA5XLS","M.2 SSD 960GB",271291),
		("GCU98KAV22458754",2,"BT617fgHL35","Amd Ryzen 5",839658),
		("DXL77TVO22487224",2,"BL513ivTB75","Intel Core i3",765651),
		("SHG63PLM44154621",2,"MR471bqBL25","Amd Ryzen 5",903700),
		("EGS11DSR27786638",2,"DF393mqZO66","Intel Core i3",378074),
		("PBJ32TBQ95596127",2,"JO437anWK59","Intel Core i3",407925),
		("QKM56JMN78953847",2,"EW326gkOE48","Amd Ryzen 5",233223),
		("ZEF87EEX35863863",2,"VR752rlLT85","Intel Core i3",760964),
		("UOR72QPA33578627",2,"HP135ugKV19","Intel Core i3",835733),
		("HVH62UTQ71338871",2,"UK975vfMT26","Intel Core i5",891076),
		("XUN28CSI36974667",2,"WQ847dcOI89","Intel Core i7",271291),
        ("RM743abj869",3,"sqc644gd","DDR4 8GB",839658),
		("RM644msz913",3,"hyr113wv","DDR4 32GB",765651),
		("RM122tls368",3,"peb934yb","DDR3 16GB",903700),
		("RM676snn649",3,"ock928fq","DDR4 8GB",378074),
		("RM365eqc237",3,"peo287pr","DDR3 16GB",407925),
		("RM547wqi345",3,"rfj854mu","DDR3 32GB",233223),
		("RM378lrz341",3,"pza463oh","DDR4 16GB",760964),
		("RM892cem756",3,"lqu653hl","DDR4 32GB",835733),
		("RM967oqu861",3,"fyi211wv","DDR3 16GB",891076),
		("RM622vgh984",3,"ncg193nz","DDR3 16GB",271291),
		("NIK92349NB",4,"CYKS-8747","M.2 Wifi 6E",839658),
		("NIQ83758BH",4,"FJCP-4395","M.2 Wifi 6E",765651),
		("NIB74486YS",4,"UGUQ-7563","PCIe 1G FDDI",903700),
		("NIP44554WB",4,"HQKT-4428","PCIe Wifi 6E",378074),
		("NIP35915HV",4,"WGVT-2746","USB Wifi 5.8Ghz",407925),
		("NIK38812PH",4,"REMC-6574","PCIe 10G Base-T",233223),
		("NIF79933JU",4,"IAKG-3182","USB Wifi 5.8Ghz",760964),
		("NID74136UW",4,"QHQB-7275","USB Wifi 5.8Ghz",835733),
		("NIB65874CC",4,"PYUC-8821","M.2 Wifi 6E",891076),
        ("NIK33962SE",4,"KVIW-6338","USB Wifi 5.8Ghz",271291);
-- -------- USERS DATA -------
INSERT INTO `users` (`users_id`,`users_fname`,`users_lname`,`users_phone`,`users_cid`,`users_assign_date`,`users_dept`)
	VALUES
		("SA8478","Deborah","Rollins","(333) 568-7386",765651,"2020-12-24","Sales"),
		("FI8241","Kristen","Sharp","(375) 384-7774",903700,"2020-02-10","Finances"),
		("SA2739","Anna","Rowland","1-133-512-9870",407925,"2020-09-30","Sales"),
		("SA2285","Henry","Rojas","1-741-325-8938",760964,"2022-09-21","Sales"),
		("HR0362","Ursula","Hampton","1-645-628-0787",835733,"2022-05-30","Human Resources"),
		("HR7774","Eric","Dorsey","1-195-121-6378",891076,"2019-06-06","Human Resources"),
		("IT9944","Sharon","Beach","1-766-492-6354",271291,"2018-08-24","IT");
  
-- -------------------------------------------------------------- QUERIES --------------------------------------------------------
-- showing all contents from tables in separated queries
SELECT * FROM computer;
SELECT * FROM parts;
SELECT * FROM users;

-- retrieving data from joint tables in 1:M relationship
-- shows all components for each computer in inventory, providing also ID and computer type
-- orders rows from lowest to highest ID, same for parts_type
SELECT 	parts_desc AS PIECE,
		parts_cid AS ID,
        IF (computer_type="D",CONCAT(computer_type,"esktop"),CONCAT(computer_type,"aptop")) AS TYPE
FROM	parts
JOIN	computer
ON		parts_cid=computer_id
ORDER BY ID ASC,parts_type;

-- retrieving data from joint tables in 1:1 relationship
-- SELECTS type, ID and status for all computers in inventory, then adds info about user department
-- presents data order by status
SELECT		IF (computer_type="D",CONCAT(computer_type,"esktop"),CONCAT(computer_type,"aptop")) AS TYPE,
			computer_id AS ID,
			IFNULL(users_dept," -- ") AS DEPT,
            CASE
				WHEN computer_status='A' THEN "OK"
                WHEN computer_status='R' THEN "In repair"
                WHEN computer_status='D' THEN "To be discarded"
                WHEN computer_status='S' THEN "In stock"
			END AS "STATUS"
FROM 		computer
LEFT JOIN 	users
ON			computer_id=users_cid
ORDER BY computer_status;