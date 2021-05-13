USE election;

-- 5.	Extras: Items 1-4 can earn you at most a grade of 90. To get to 100 you have to go beyond
-- a.	Triggers

-- a. 1. trigger -> after order to polling station go to polling table and update the new budget , without using new/old
DELIMITER $$ 
CREATE TRIGGER trigger_after_insert
AFTER INSERT ON supply_table FOR EACH ROW
BEGIN
	DECLARE p_id_by INT;
	DECLARE cost_order INT;
		SELECT p_id INTO p_id_by FROM supply_table
		WHERE e_id>=ALL(SELECT e_id FROM supply_table);
        
		SELECT cost INTO cost_order FROM supply_table
		WHERE e_id>=ALL(SELECT e_id FROM supply_table);
        
		UPDATE polling_table
		SET budget=budget-cost_order
		WHERE polling_table.p_id = p_id_by;
END $$
DELIMITER ;

SELECT * FROM polling_table; -- before insert

INSERT INTO supply_table VALUES
(1,5,3111),
(2,6,2999);

SELECT * FROM polling_table; -- after insert
-- ---------------------------------------------
-- a. 2. trigger ->after delete a employee x delete him in staff table (the pk) 
DELIMITER $$ 
CREATE TRIGGER trigger_delete_staff_in_all_refernce_before_delete
AFTER DELETE ON employee_table FOR EACH ROW
BEGIN      
		DELETE FROM staff_table
		WHERE staff_id = old.emp_id;
END $$
DELIMITER ;
-- for check it's works
INSERT INTO staff_table VALUES
(777777777,'lalo','robi','0542331119','counting staff');
INSERT INTO employee_table VALUES
(777777777,1,1000);

SELECT * FROM staff_table; -- before delete
SELECT * FROM employee_table; -- before delete

DELETE FROM employee_table
WHERE emp_id=777777777;

SELECT * FROM staff_table; -- after delete
SELECT * FROM employee_table; -- after delete
-- ----------------------------------------------------
-- a. 3. trigger -> after insert employee salary update budget
DELIMITER $$ 
CREATE TRIGGER trigger_after_insert_emp_salary
AFTER INSERT ON employee_table FOR EACH ROW
BEGIN
		UPDATE polling_table
		SET budget=budget-new.salary
        WHERE p_id=new.p_id;
END $$
DELIMITER ;

SELECT * FROM polling_table; -- before insert

INSERT INTO staff_table VALUES
(777777777,'lalo','robi','0542331119','counting staff');
INSERT INTO employee_table VALUES
(777777777,1,1333);


SELECT * FROM polling_table; -- after insert