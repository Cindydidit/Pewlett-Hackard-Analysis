--DROP TABLE retirement_info;




SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date--no comma
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Specify wanted columns from each table
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
-- ^New table creation
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
-- ^Matching column from each table
WHERE de.to_date = ('9999-01-01');
-- ^Filters current employees (as the to date specifies they are still employed)


---Aliases
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;


-- Employee COUNT GROUP(ed) BY department number
SELECT COUNT(ce.emp_no), de.dept_no
-- ^Table data is retreived from is in parentheses
-- ^^ Statement highlights how many employees per department are leaving
FROM current_emp as ce
LEFT JOIN dept_emp as de
-- ^LEFT JOIN query because all employee numbers from "Table 1" need to be included in returned data
ON ce.emp_no = de.emp_no
-- ^Matching columns from each table
GROUP BY de.dept_no;
--^Magic clause for desired outcome
ORDER BY de.dept_no;


--------Use Count, Group By, and Order By
-- Join current_emp and dept_emp tables
-- Employee COUNT GROUP(ed) BY department number
SELECT COUNT(ce.emp_no), de.dept_no
-- ^Table data is retreived from is in parentheses
-- ^^ Statement highlights how many employees per department are leaving
INTO dept_retirement_info
FROM current_emp as ce
LEFT JOIN dept_emp as de
-- ^LEFT JOIN query because all employee numbers from "Table 1" need to be included in returned data
ON ce.emp_no = de.emp_no
-- ^Matching columns from each table
GROUP BY de.dept_no
-- ^Magic clause for desired outcome
ORDER BY de.dept_no;
-- ^Order outcome by desired column

-- Employee Information table containing employee number, last name, name, gender, salary
SELECT emp_no,
    first_name,
	last_name,
    gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Add aliases
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
--INTO emp_info
FROM employees as e
-- Join two tables
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
-- Join third table
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
-- Add filters
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);


--Department Retirees table with an updated current_emp list that includes everything it currently has, but also the employee's departments
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- we don't need to see a column from each table in a join, but we do need the foreign and primary keys to link them together
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);














