--1. [2pt] Retrieve the names of all employees who work on at least one of the projects.
    --(In other words, look at the list of projects given in the PROJECT table,
    --  and retrieve the names of all employees who work on at least one of them.)
select fname, lname from employee where
    ssn in (select essn from works_on);

--2. [2pt] For each department, retrieve the department number, department name,
--      and the average salary of all employees working in that department.
--      Order the output by department number in ascending order.
select department.dnumber, department.dname, avg(salary) from employee, department
    where employee.dno = department.dnumber
    group by department.dname, department.dnumber
    order by department.dnumber asc;

--3. [3pt] List the last names of all department managers who have no dependents.
select lname from employee
where ssn not in(select essn from dependent)
and ssn in (select mgr_ssn from department);


--4. [3pt] Determine the department that has the employee with the lowest salary among all employees.
--          For this department retrieve the names of all employees.
--          Write one query for this question using subquery.
select fname from employee
    where dno in ( 
        select dno from employee
            where salary in (select min(salary) from employee)
    );

--5. [2pt] Find the total number of employees and the total number of dependents for every department
--      (the number of dependents for a department is the sum of the number of dependents for each employee working for that department)
--          Return the result as department name, total number of employees, and total number of dependents.

select t1.departmentname, t1.numemployees, t2.numdependents from
    -- dept name & total employees
    (select dname departmentname, count(ssn) numemployees from employee, department
        where 
            employee.dno = department.dnumber
        group by dname
    ) 
t1 left join
    -- department name & dependent count
    (select dname departmentname, count(ssn) numdependents from employee, dependent, department
        where 
            ssn=essn
        and 
            employee.dno = department.dnumber
        group by dname
    )
t2 on t1.departmentname = t2.departmentname;


--6. [3pt] Determine if, in the company, male employees earn more than female employees.

select sex, avg(salary) from employee 
    where sex = 'M'
    group by sex

union

select sex, avg(salary) from employee 
    where sex = 'F'  
    group by sex ;


--7. [5pt] Retrieve the names of employees whose salary is within $20,000 of the salary of the employee who is paid the most in the company
--      (e.g., if the highest salary in the company is $80,000, retrieve the names of all employees that make at least $60,000).
select fname, lname from employee where
    salary >= ((select max(salary) from employee) - 20000);

--8. [5pt] Find the names and addresses of all employees whose departments have no location in Houston
--  (that is, whose departments do not have a Dlocation of Houston) but who work on at least one project that is located in Houston
--  (that is, who work on at least one project that has a Plocation of Houston).
--      Note that the first condition is not equivalent to the employee's department having some Dlocation that is not in Houston
--      the department must not have any Dlocation that is in Houston in order to be included in the result.

select fname, address from employee, dept_locations, works_on
    where 
        employee.dno = dept_locations.dnumber
    and
        dlocation != 'Houston'
    and 
        works_on.essn = employee.ssn
    and
        works_on.pno = any (select pnumber from project where plocation = 'Houston') -- project nums where location is houston
        
    group by fname, address;
