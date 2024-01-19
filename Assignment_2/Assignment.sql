/*
    Assignmnet 2
    Jan 19, 2024
*/

/*
  Based on Emp table Columns are EmpNo, Ename, Job, Salary, Commission, DeptNO Insert 5 records by stroring Null value in some records for commission column.
  Pre-Requisities
*/
CREATE TABLE Emp (
    EmpNo INT PRIMARY KEY,
    Ename VARCHAR(50),
    Job VARCHAR(30),
    Salary FLOAT,
    Commission FLOAT,
    DeptNo INT
);

INSERT INTO Emp VALUES (1, 'John', 'Manager', 3000, NULL, 10);
INSERT INTO Emp VALUES (2, 'Alice', 'Clerk', 2500, NULL, 20);
INSERT INTO Emp VALUES (3, 'Bob', 'Salesperson', 2800, 300, 10);
INSERT INTO Emp VALUES (4, 'Sara', 'Clerk', 2200, NULL, 20);
INSERT INTO Emp VALUES (5, 'Mike', 'Salesperson', 3200, 500, 30);

/*
  Q1) Get employee no and employee name who works in dept no 10 ?
*/
Select EmpNo, Ename from Emp Where DeptNo = 10;

/*
  Q2) Display the employee names of those clerks whose salary > 2000 ?
*/
SELECT Ename FROM Emp WHERE Salary > 2000 AND Job='Clerk';

/*
  Q3) Display name and job of Salesperson & Clerks ?
*/
SELECT Ename, Job FROM Emp WHERE Job IN('Salesperson','Clerk');

/*
  Q4) Display all details of employees whose salary between 2000 and 3000 ?
*/
SELECT * FROM Emp WHERE Salary >2000 AND Salary <3000;

/*
    Q5) Display all details of employees whose dept no is 10, 20, or 30 ?
*/
SELECT * FROM Emp WHERE DeptNo IN(10,20,30);

/*
    Q6) Display name of those employees whose commission is NULL?
*/
SELECT Ename FROM Emp WHERE Commission IS NULL;

/*
    Q7) Display dept no & salary in ascending order of dept no and within each dept no salary should be in descending order ?
*/
SELECT DeptNo, Salary FROM Emp ORDER BY DeptNo ASC, Salary DESC;

/*
    Q8) Display name of employees having two ‘a’ or ‘A’ chars in the name ?
*/
SELECT Ename FROM Emp WHERE Ename LIKE '%A%' OR Ename LIKE '%a%';

/*
    Q9) Display the name of the employees whose second char is ‘b’ or ‘B’ ?
*/
SELECT Ename FROM Emp WHERE UPPER(SUBSTR(Ename, 2, 1)) = 'B';

/*
    Q10) Display the name of the employees whose first or last char is ‘a’ or ‘A’ ?
*/
SELECT Ename FROM Emp WHERE UPPER(SUBSTR(Ename,1,1))='A' OR UPPER(SUBSTR(Ename,-1,1))='A';

/*
    Q11) Display maximum, minimum, average salary of deptno 10 employees.
*/
SELECT MAX(Salary) as MaxSalary, MIN(Salary) as MinSalary, AVG(Salary) as AvgSalary FROM Emp WHERE DeptNo = 10;

/*
    Q12) Display total number of employees working in deptno 20
*/
SELECT COUNT(*) AS TotalEmployees FROM Emp WHERE DeptNo = 20;

/*
    Q13) Display total salary paid to clerks
*/
SELECT SUM(Salary) AS TotalSalary FROM Emp WHERE Job='Clerk'; 

/*
    Q14) Display system date
*/
SELECT SYSDATE AS CurrentDate FROM dual;

/*
    Q15) Display the result of (12*12)/13
*/
SELECT (12 * 12) / 13 AS res FROM dual;

/*
    Q16) Display info of ‘raj’ irrespective to the case in which the data is stored.
*/
Select * from Emp where LOWER(Ename)='sara';
