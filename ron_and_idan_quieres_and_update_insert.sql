USE election;

-- ------------------------4.	Querying the database
							-- a.	Write at least twelve SELECT commands to be performed by the user. Credit will be given for complexity of the queries
						    -- b.	Write at least four INSERT/UPDATE/DELETE commands to be performed by the user
							-- Be sure to include commands for both users defined in 2(c).
                            
-- a.	Write at least twelve SELECT commands to be performed by the user. Credit will be given for complexity of the queries
-- 1. Get the winner of the election. 
SELECT name_party FROM 
					(SELECT name_party,COUNT(name_party) AS VotesNumber FROM get_votes_table
					GROUP BY name_party
					ORDER BY VotesNumber DESC
					LIMIT 1) AS getTheWinner;

-- 2. What is the citizen voting percentage.
SELECT CONCAT(ROUND((voteCount/allCitizens)*100,1),'%') AS VotingPresent FROM
(SELECT COUNT(vote) AS voteCount  FROM citizen_table
WHERE vote = TRUE) AS voters,(SELECT COUNT(c_id) AS allCitizens FROM citizen_table) AS citizens;
								

-- 3. The average salary of each manger's employees.
SELECT * FROM staff_table,
			(SELECT manager_id,salaryOfAllEmp FROM polling_manager_table,
									(SELECT p_id, ROUND(AVG(salary),1) AS salaryOfAllEmp FROM employee_table
									GROUP BY p_id) AS AllSalarySum
									WHERE polling_manager_table.p_id=AllSalarySum.p_id) AS manager_id_with_salarys
WHERE staff_table.staff_id=manager_id_with_salarys.manager_id;
                                    
 -- 4. Which polling station is over the budget.
 SELECT * FROM polling_table
 WHERE p_id= ANY(SELECT p_id FROM polling_table
				WHERE budget<0);
                
 -- 5. Show the num of employees needed in every polling station.
  SELECT polling_table.*,(ROUND((polling_table.num_of_voters/80),0))*2 AS employee_Needed FROM polling_table,
			(SELECT p_id,num_of_voters FROM polling_table) AS numOfVoters
WHERE polling_table.p_id=numOfVoters.p_id;
		
-- 6. Show all the staff order by alphabetic.    
SELECT * FROM staff_table
ORDER BY firstName,lastName;

-- 7. Show all orders of polling station x.
SELECT e_id AS num_of_oreder,cost FROM supply_table
WHERE p_id=1;

-- 8. show all citizens that are assigned to polling station x.
SELECT * FROM citizen_table
WHERE p_id=1;

-- 9. Show all managers that their polling station is over the budget.
SELECT staff_table.* FROM staff_table,
						(SELECT manager_id,area_manager_id FROM polling_manager_table
							WHERE p_id=ANY(SELECT p_id FROM polling_table
							WHERE budget<0)) AS managers_id_budget_exp
WHERE staff_table.staff_id=managers_id_budget_exp.manager_id OR staff_table.staff_id=managers_id_budget_exp.area_manager_id;

-- 10. Show the number of polling station in each city.
SELECT city,COUNT(city) FROM polling_table
GROUP BY city;

-- 11. show all employee that work in corona and isolation polling stations.
SELECT * FROM staff_table
WHERE staff_id=ANY(SELECT emp_id FROM employee_table
					WHERE p_id= ANY(SELECT p_id FROM polling_table
					WHERE type_of_polling='corona' OR type_of_polling='isolation'));
                    
-- 12. show all the corona virus sick citizens.
SELECT * FROM citizen_table
WHERE type_of_citizen LIKE 'corona';

-- b.	Write at least four INSERT/UPDATE/DELETE commands to be performed by the user
-- 1. update citizen x vote
UPDATE citizen_table
SET vote = TRUE
WHERE c_id= 111111635;

UPDATE citizen_table
SET vote = TRUE
WHERE c_id= 333118635;

SELECT * FROM citizen_table; -- for see update
-- --------------------------------------------
-- 2. insert the pick of citizen votes
INSERT INTO get_votes_table VALUES
(2,'lev'),
(4,'benifrad');

SELECT * FROM get_votes_table; -- for see update
-- --------------------------------------------
-- 3. update the salary of all employee at corona polling stations (30% present)
SELECT * FROM employee_table; -- before raise

UPDATE employee_table
SET salary = (salary)*1.3
WHERE p_id= ANY(SELECT p_id FROM polling_table WHERE type_of_polling='corona');

SELECT * FROM employee_table; -- after raise
-- ----------------------------------------
-- 4. update cost of recervation that we get discont (35%)
SELECT * FROM supply_table; -- before discont

UPDATE supply_table
SET cost = (cost)*0.65
WHERE e_id=1;

UPDATE supply_table
SET cost = (cost)*0.65
WHERE e_id=2;

SELECT * FROM supply_table; -- after discont