-- Create a Retirement Titles table for employees who are born between January 1, 1952 and December 31, 1955
select e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
Into retirement_titles
from employees e
Inner Join titles t 
on (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by emp_no;


-- Create a Unique Titles table that contains the employee number, first and last name, and most recent title.
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
into unique_titles
FROM retirement_titles
ORDER BY emp_no asc, to_date DESC;

-- Create a Retiring Titles table that contains the number of titles filled by employees who are retiring
SELECT DISTINCT(count(title)) as count, title
into retiring_titles
FROM unique_titles
group by title
order by count desc;

 -- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
Select DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
into mentorship_eligibilty
from employees as e
inner join dept_emp as de
on (e.emp_no = de.emp_no)
inner join titles as t
on (e.emp_no = t.emp_no)
where de.to_date = '9999-01-01' AND
(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by emp_no;