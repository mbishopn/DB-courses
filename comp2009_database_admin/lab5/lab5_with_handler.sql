CREATE DATABASE IF NOT EXISTS comp2009_lab5;

USE comp2009_lab5;
DROP TABLE IF EXISTS employees;
DROP PROCEDURE IF EXISTS addEmployee;

CREATE TABLE employees (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(25),
department VARCHAR(25),
salary DECIMAL(10,2)
);

INSERT INTO employees(name,department,salary)
VALUES 
("Jeff Bezos", "Sales", 75000),
("Jordan Belfort", "Sales", 75000),
("Napoleon Bonaparte", "Operations", 93000.50),
("Genghis Khan", "Management", 125000),
("Nicola Tesla", "R&D", 50000),
("Leonardo Da Vinci", "Design", 50000),
("JR Talkien", "Writing", 50000);

delimiter //
CREATE PROCEDURE addEmployee(_name VARCHAR(25), _department VARCHAR(25), _salary DECIMAL(10,2))
BEGIN
declare err bool;
declare msg varchar(50);

declare continue handler for sqlstate '45000' set err=false;

set err=false;
	IF _name IS NULL OR _department IS NULL OR _salary IS NULL THEN
		SIGNAL SQLSTATE '45000';
        SET msg='Record not added. Missing required fields';
        set err=true;
	END IF;
    
   
    IF (SELECT COUNT(*) FROM employees WHERE name=_name AND department=_department)>0 THEN
		SIGNAL SQLSTATE '45000';
        SET msg='Record not added. Duplicate entry';
        set err=true;
    END IF;



    
	if not err then
		IF _salary > 100000 THEN
			SET _department= CONCAT(_department,' (Management)');
		END IF;
		
		INSERT INTO employees (name, department, salary)
		VALUES (_name, _department, _salary);
		SELECT * FROM employees where id=LAST_INSERT_ID();
	else
		SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT=msg;

	end if;

END
//
delimiter ;


call addEmployee("Armando Maradona", "Sports", 15000); -- just adds the record and shows it
call addEmployee("IT guy",NULL, 40000); -- can't be completed because a parameter is missing
call addEmployee("Jeff Bezos", "Sales", 135000); -- can't be completed due to records duplicity
call addEmployee("IT Director", "IT", 135000); -- appends (Management) to department because salary > 100000

