/*
  Assignment 6
  Feb  , 2024
*/
-- Prequisites
CREATE TABLE DEPT (
    DEPTNO NUMBER(2) NOT NULL CONSTRAINT DEPT_PK PRIMARY KEY,
    DEPTNAME VARCHAR2(20)
);

CREATE TABLE EMP (
    EMPNO NUMBER(4) NOT NULL CONSTRAINT EMP_PK PRIMARY KEY,
    EMPNAME VARCHAR2(10),
    DEPTNO NUMBER(2) CONSTRAINT EMP_REF_DEPT_FK REFERENCES DEPT(DEPTNO),
    JOB VARCHAR2(9),
    SALARY NUMBER(7,2)
);

-- 1. Insert 10 appropriate records in each table as per the SQL queries mentioned below.
-- Insert 10 records into the DEPT table
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (10, 'ACCOUNTING');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (20, 'RESEARCH');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (30, 'SALES');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (40, 'OPERATIONS');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (50, 'MARKETING');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (60, 'EXECUTIVE');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (70, 'FINANCE');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (80, 'PURCHASING');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (90, 'HUMAN RESOURCES');
INSERT INTO DEPT (DEPTNO, DEPTNAME) VALUES (95, 'CLERICAL');

-- Insert 10 records into the EMP table
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7839, 'SMITH', 20, 'CLERK', 800);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7698, 'BLAKE', 30, 'MANAGER', 2850);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7782, 'CLARK', 10, 'MANAGER', 2450);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7566, 'JONES', 20, 'MANAGER', 2975);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7788, 'SCOTT', 20, 'ANALYST', 3000);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7902, 'FORD', 20, 'ANALYST', 3000);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7369, 'SMITH', 20, 'CLERK', 800);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7934, 'MILLER', 10, 'CLERK', 1300);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7521, 'WARD', 30, 'SALESMAN', 1250);
INSERT INTO EMP (EMPNO, EMPNAME, DEPTNO, JOB, SALARY) VALUES (7499, 'ALLEN', 30, 'SALESMAN', 1600);

-- 2. List the total number of employees?
SELECT COUNT(*) AS total_employees FROM EMP;

-- 3. List the total no of departments?
SELECT COUNT(*) AS total_departments FROM DEPT;

-- 4. Display the employee details of each department for which they are working.
SELECT E.EMPNO, E.EMPNAME, E.JOB, E.SALARY, D.DEPTNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO ORDER BY D.DEPTNAME;

-- 5. List the total, maximum, & minimum salary for deptno 30?
SELECT SUM(salary) AS total_salary, MAX(salary) AS max_salary, MIN(salary) AS min_salary FROM emp WHERE deptno = 30;

-- 6. Display the name of the employee getting maximum salary?
SELECT empname FROM emp WHERE salary = (SELECT MAX(salary) FROM emp);

-- 7. Display the total salary for each department?
SELECT D.DEPTNAME, SUM(E.SALARY) AS TOTAL_SALARY FROM DEPT D JOIN EMP E ON D.DEPTNO = E.DEPTNO GROUP BY D.DEPTNAME;

-- 8. Display the total salary for each job.
SELECT JOB, SUM(SALARY) AS TOTAL_SALARY FROM EMP GROUP BY JOB;

-- 9. Display the total salary for each job within each department.
SELECT D.DEPTNAME, E.JOB, SUM(E.SALARY) AS TOTAL_SALARY FROM DEPT D JOIN EMP E ON D.DEPTNO = E.DEPTNO GROUP BY D.DEPTNAME, E.JOB;

-- 10. Display the average salary for each job in deptno 20.
SELECT AVG(SALARY) AS AVERAGE_SALARY, JOB FROM EMP WHERE DEPTNO = 20 GROUP BY JOB;

-- 11. Display the total salary for each job excluding the ‘manager’ and ‘salesman’ job.
SELECT job, SUM(salary) as total_salary FROM emp WHERE job NOT IN ('manager', 'salesman') GROUP BY job;

-- 12. Display the average salary for each job in deptno 20, but only display those jobs where average salary is greater than 2000 & display the output in descending order of salary?
SELECT DEPTNO, JOB, AVG(SALARY) AS AVERAGE_SALARY FROM EMP WHERE DEPTNO = 20 GROUP BY DEPTNO, JOB HAVING AVG(SALARY) > 2000 ORDER BY AVERAGE_SALARY DESC;

-- 13. Display the total no of employees for each department excluding the deptno 10 & display only those departments where more than five employees work. Display the output in descending order of total no of employees?
SELECT D.DEPTNO, COUNT(E.EMPNO) AS TOTAL_EMPLOYEES FROM DEPT D LEFT JOIN EMP E ON D.DEPTNO = E.DEPTNO WHERE D.DEPTNO <> 10 GROUP BY D.DEPTNO HAVING COUNT(E.EMPNO) > 5 ORDER BY TOTAL_EMPLOYEES DESC;

-- 14. Display the total no of employees for each department excluding the ‘comp’ dept & display only those departments where more than five employees work. Display the output in descending order of total no of employees?
SELECT D.DEPTNO, COUNT(E.EMPNO) AS TOTAL_EMPLOYEES FROM DEPT D JOIN EMP E ON D.DEPTNO = E.DEPTNO WHERE D.DEPTNAME != 'comp' GROUP BY D.DEPTNO HAVING COUNT(E.EMPNO) > 5 ORDER BY TOTAL_EMPLOYEES DESC;

-- 15. Display total number of emp working in each job in each dept.
SELECT D.DEPTNAME, E.JOB, COUNT(E.EMPNO) AS TOTAL_EMP FROM DEPT D JOIN EMP E ON D.DEPTNO = E.DEPTNO GROUP BY D.DEPTNAME, E.JOB;

-- 16. List all the department name and their employees name even if for a department there is no employees (A newly created department).
SELECT D.DEPTNAME, E.EMPNAME FROM DEPT D LEFT JOIN EMP E ON D.DEPTNO = E.DEPTNO ORDER BY D.DEPTNAME;

-- 17. List all the employees name and their department name even if for an employee there is no department assigned (A newly joined employee).
SELECT E.EMPNAME, D.DEPTNAME FROM EMP E LEFT JOIN DEPT D ON E.DEPTNO = D.DEPTNO ORDER BY E.EMPNAME;

-- 18. List all the departments name and their employees name irrespective whether for a department any employees are there are not, and irrespective whether for an employee there is any department assigned or not.
SELECT D.DEPTNAME, E.EMPNAME FROM DEPT D FULL OUTER JOIN EMP E ON D.DEPTNO = E.DEPTNO ORDER BY D.DEPTNAME, E.EMPNAME;

-- End of Code --
