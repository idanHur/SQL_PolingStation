CREATE SCHEMA election;

USE election;
-- ------------------------------------- 3.	Creating the database
										-- a.	Create the database with CREATE commands
										-- b.	Fill the database with data using either INSERT commands or UPLOAD from a file

  -- ----------------------------------- CREATE commend
CREATE TABLE staff_Table
(staff_id INT NOT NULL ,
firstName VARCHAR(50),
lastName VARCHAR(50),
phone_num VARCHAR(15),
title VARCHAR(50),
PRIMARY KEY (staff_id));

CREATE TABLE polling_table
(p_id INT NOT NULL AUTO_INCREMENT,
type_of_polling VARCHAR(50),
city VARCHAR(50),
street_name VARCHAR(50),
address_num INT NOT NULL,
zip_code INT NOT NULL,
budget INT NOT NULL,
num_of_voters INT NOT NULL,
PRIMARY KEY (p_id));

CREATE TABLE manager_Area_Table
(area_manager_id INT NOT NULL,
area VARCHAR(50),
PRIMARY KEY (area_manager_id),
CONSTRAINT fk_my_id FOREIGN KEY (area_manager_id)
            REFERENCES staff_Table(staff_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION);
            
            
CREATE TABLE polling_manager_table
(manager_id INT NOT NULL,
p_id INT NOT NULL,
area_manager_id INT NOT NULL,
PRIMARY KEY (manager_id),
UNIQUE(p_id),
CONSTRAINT fk_staff_id FOREIGN KEY (manager_id)
            REFERENCES staff_Table(staff_id)
			ON UPDATE CASCADE
            ON DELETE NO ACTION,
CONSTRAINT fk_pid FOREIGN KEY (p_id)
            REFERENCES polling_table(p_id),
CONSTRAINT fk_manager_id FOREIGN KEY (area_manager_id)
            REFERENCES manager_Area_Table(area_manager_id));

CREATE TABLE city_Table
(area_manager_id INT NOT NULL,
city VARCHAR(50),
CONSTRAINT fk_city_manager FOREIGN KEY (area_manager_id)
            REFERENCES manager_Area_Table(area_manager_id));

CREATE TABLE employee_Table
(emp_id INT NOT NULL,
p_id INT NOT NULL,
salary INT NOT NULL DEFAULT 0,
PRIMARY KEY (emp_id),
CHECK (salary>=0),
CONSTRAINT fk_emp_id FOREIGN KEY (emp_id)
            REFERENCES staff_Table(staff_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
CONSTRAINT fk_work_at_id FOREIGN KEY (p_id)
            REFERENCES polling_table(p_id));

CREATE TABLE equipment_Table
(e_id INT NOT NULL AUTO_INCREMENT,
equip_type VARCHAR(50),
amount INT DEFAULT 0,
CHECK (amount>=0),
PRIMARY KEY (e_id));

CREATE TABLE citizen_Table
(c_id INT NOT NULL ,
p_id INT NOT NULL,
firstName VARCHAR(50),
lastName VARCHAR(50),
type_of_citizen  VARCHAR(50),
vote BOOLEAN,
city VARCHAR(50),
street_name VARCHAR(50),
house_num INT NOT NULL,
zip_code INT NOT NULL,
PRIMARY KEY (c_id),
CONSTRAINT fk_vote_at_id FOREIGN KEY (p_id)
            REFERENCES polling_table(p_id));


CREATE TABLE parties_table
(name_party VARCHAR(50) NOT NULL,
PRIMARY KEY (name_party));

CREATE TABLE supply_table
(p_id INT NOT NULL,
e_id INT NOT NULL,
cost INT NOT NULL,
CHECK (cost>=0),
PRIMARY KEY (e_id),
CONSTRAINT fk_supply_to FOREIGN KEY (p_id)
            REFERENCES polling_table(p_id),
CONSTRAINT fk_equipment FOREIGN KEY (e_id)
            REFERENCES equipment_Table(e_id));
            
CREATE TABLE get_votes_table
(p_id INT NOT NULL,
name_party VARCHAR(50) NOT NULL,
CONSTRAINT fk_vote_at FOREIGN KEY (p_id)
            REFERENCES polling_table(p_id),
CONSTRAINT fk_vote_to FOREIGN KEY (name_party)
            REFERENCES parties_table(name_party));
  
  -- ----------------------------------- insert

  INSERT INTO polling_table VALUES
(1,'corona','tel-aviv','abo-gosh',5,123432,100000,130),
(2,'regular','holon','revivm',7,1453332,70000,20000),
(3,'isolation','hadera','yoni-ha-moshe',9,145432,50000,15000),
(4,'soliders','tel-aviv','neot-afeka',8,12131132,40000,17000),
(5,'regular','bat-yam','david hamelech',10,1233332,20000,50000),
(6,'regular','REHOVOT','david hamelech',10,3333333,-300,17000);


INSERT INTO staff_Table VALUES
(318248635,'Or','levi','0501234567','counting staff'),
(318111635,'nissim','choen','0501114567','manager polling'),
(318333335,'yoni','robi','0501233567','area manager'),
(311118635,'yuoval','shasha','0501444567','logistic staff'),
(111111113,'GIDI','shasha','0501334567','manager polling'),
(312222635,'moni','mone','0501234567','counting staff');

INSERT INTO manager_Area_Table VALUES
(318333335,'gosh-dan');

INSERT INTO city_Table VALUES
(318333335,'tel-aviv'),
(318333335,'holon'),
(318333335,'bat-yam');

 INSERT INTO polling_manager_table VALUES
(318111635,2,318333335),
(111111113,6,318333335);   
    

 INSERT INTO employee_Table VALUES
(318248635,2,2000), 
(311118635,3,5000),
(312222635,1,6000);

INSERT INTO equipment_Table VALUES
(1,'tabels',15), 
(2,'tabels',25),
(3,'chair',24),
(4,'box vote',26),
(5,'chair',24),
(6,'tabels',26);


INSERT INTO citizen_Table VALUES
(318222222,1,'yori','shem tov','corona',true,'tel-aviv','shalom',2,1111),
(111111635,2,'shlomi','levi','regular',false,'holon','baroch',3,33333),
(222333335,3,'barel','chichi','isolation',true,'hadera','shalom aleyhem',2,4444),
(333118635,4,'michal','shlomi','soliders',false,'yeroham','pinat hgolshim',2,55555),
(555222635,5,'dana','levi','regular',true,'bat-yam','david',2,177777);


INSERT INTO parties_table VALUES
('lev'),
('beyahad'),
('benifrad'),
('shalom'),
('kolam');

INSERT INTO supply_table VALUES
(1,1,4000),
(1,2,5000),
(2,3,6000),
(2,4,7000);

  INSERT INTO get_votes_table VALUES
(1,'lev'),
(3,'lev'),
(5,'beyahad');

       
