/*
    Assignment 5
    Feb , 2024
*/

-- 1. Create table dept which has the following attributes (deptno, dept_name) where deptno is primary key, dept_name in (Accounts, Computer, Elect).
CREATE TABLE dept (
deptno INT PRIMARY KEY,
 dept_name VARCHAR2(10),
 CONSTRAINT chk_dept_name CHECK (dept_name IN ('Accounts', 'Computer', 'Elect'))
);

-- 2. .Create table emp which has the following attributes (empno, emp_name, job, sal, deptno, mgr_no) where empno is primary key, emp_name is unique, job in (Professor, Assistant Professor, and Lecturer), sal is NOT NULL, deptno is foreign key, mgr_no is a self-referential foreign key.
CREATE TABLE emp (
empno INT PRIMARY KEY,
 emp_name VARCHAR2(20),
 job VARCHAR2(40) CHECK (job IN ('Professor', 'Assistant Professor', 'Lecturer')),
 sal INT NOT NULL,
 deptno INT,
 mgr_no INT,
 CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno),
 CONSTRAINT uc_emp_name UNIQUE (emp_name),
 CONSTRAINT fk_mgr_no FOREIGN KEY (mgr_no) REFERENCES emp(empno)
);

-- 3. Create table S which has the following attributes (Salesperson table) (sno, sname, city) where sno is primary key
CREATE TABLE S (
 sno INT PRIMARY KEY,
 sname VARCHAR2(20),
 city VARCHAR2(20)
);

-- 4.Create table P which has the following attributes (Part table) (pno, pname, color) where pno is primary key.
CREATE TABLE P (
 pno INT PRIMARY KEY,
 pname VARCHAR2(20),
 color VARCHAR2(20)
);

-- 5. Create table J which has the following attributes (ProJect table) (jno, jname, city) where jno is primary key.
CREATE TABLE J (
 jno INT PRIMARY KEY,
 jname VARCHAR2(20),
 city VARCHAR2(20)
);

-- 6. Create table SPJ which has the following attributes (sno, pno, jno, qty) where combination of (sno, pno, jno) is a composite primary key. Also, sno, pno, jno are foreign keys.
CREATE TABLE SPJ (
 sno INT,
 pno INT,
 jno INT,
 qty INT,
 CONSTRAINT PK_SPJ PRIMARY KEY (sno, pno, jno),
 CONSTRAINT fk_sno FOREIGN KEY (sno) REFERENCES S(sno),
 CONSTRAINT fk_pno FOREIGN KEY (pno) REFERENCES P(pno),
 CONSTRAINT fk_jno FOREIGN KEY (jno) REFERENCES J(jno)
);

-- 7.Insert at least 3/5 appropriate records in the above tables.
INSERT INTO dept VALUES (101, 'Accounts');
INSERT INTO dept VALUES (102, 'Elect');
INSERT INTO dept VALUES (2, 'Computer');
INSERT INTO emp VALUES (95, 'Raj Bansal', 'Professor', 20000, 101, NULL);
INSERT INTO emp VALUES (96, 'Amit Tingal', 'Lecturer', 17000, 101, 95);
INSERT INTO emp VALUES (97, 'Sumit Aeron', 'Assistant Professor', 19000, 101, 95);
INSERT INTO emp VALUES (98, 'Anamika Dharan', 'Lecturer', 16000, 101, 95);
INSERT INTO emp VALUES (99, 'Ravi Bindal', 'Lecturer', 18000, 101, 95);
INSERT INTO emp VALUES (100, 'Vaibhav Garg', 'Professor', 15000, 102, 96);
INSERT INTO emp VALUES (101, 'Raj Nangal', 'Assistant Professor', 12000, 101, 96);
INSERT INTO emp VALUES (102, 'Ananya Goel', 'Lecturer', 7000, 2, 96);
INSERT INTO emp VALUES (103, 'Ravi Garg', 'Lecturer', 9000, 2, 97);
INSERT INTO emp VALUES (104, 'Anju Bansal', 'Professor', 8500, 102, 97);
INSERT INTO emp VALUES (105, 'Ishika Singhal', 'Lecturer', 10000, 2, 97);
INSERT INTO emp VALUES (106, 'Deepak Mangal', 'Lecturer', 10000, 102, 98);
INSERT INTO emp VALUES (107, 'Ansh Tayal', 'Assistant Professor', 12000, 102, 98);
INSERT INTO emp VALUES (108, 'Ansh Goyan', 'Assistant Professor', 15000, 101, 98);
INSERT INTO emp VALUES (109, 'Ravi Mittal', 'Professor', 12000, 2, 99);
INSERT INTO emp VALUES (110, 'Mayur Singhla', 'Lecturer', 13500, 101, 99);
INSERT INTO emp VALUES (111, 'Arsh Goyal', 'Lecturer', 11000, 101, 99);
INSERT INTO emp VALUES (112, 'Ravi Goyan', 'Professor', 10000, 101, 99);
INSERT INTO emp VALUES (113, 'Ravi Tayal', 'Lecturer', 9000, 101, 112);
INSERT INTO emp VALUES (114, 'Akansha Garg', 'Lecturer', 8600, 101, 111);
INSERT INTO emp VALUES (115, 'Ananya Tingal', 'Lecturer', 8600, 101, 112);

-- Q8.Drop the NOT NULL constraints from EMP table.
ALTER TABLE emp MODIFY sal INT NULL;

-- Q9.Check all the constraints name and their type of EMP table.
SELECT * FROM USER_CONSTRAINTS WHERE table_name = 'EMP';

-- Q10. Drop the unique constraint on EMP_NAME of EMP table.
ALTER TABLE emp DROP CONSTRAINT uc_emp_name

-- Q11. Drop the Foreign Key constraint on DEPTNO.
ALTER TABLE emp DROP CONSTRAINT fk_deptno;

-- Q12. Add Foreign Key constraint on DEPTNO as a table label constraint.
ALTER TABLE emp ADD CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno);

-- Q13. Drop the Check constraint from DEPT table.
ALTER TABLE dept DROP CONSTRAINT chk_dept_name;

-- Q14. Add COMM column in EMP table (default value 0).
ALTER TABLE emp ADD comm INT DEFAULT 0;

-- Q15. Drop Default constraint from EMP.
ALTER TABLE emp MODIFY comm DEFAULT NULL;

-- Q16. Create duplicate copy of EMP table.
CREATE TABLE emp_copy AS SELECT * FROM emp;

-- Q17. Copy the structure of DEPT table to a new table with different column names.
CREATE TABLE dept_copy_1 AS SELECT deptno AS new_deptno, dept_name AS new_dept_name FROM dept;

-- Q18. Copy the structure of DEPT table to a new table with different column names without any records copied from DEPT.
CREATE TABLE dept_copy_2 AS SELECT deptno AS new_deptno, dept_name AS new_dept_name FROM dept WHERE 1=0;

-- Q19. Change the name and job of the employee whose EMPNO = 100.
UPDATE emp SET emp_name = 'Shaurya Jindal', job = 'Professor' WHERE empno = 100;

-- Q20. Delete the record of employee who belong to computer department.
DELETE FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE dept_name = 'Computer');

-- Q21. Delete deptno 101 from Dept table and set NULL to the corresponding deptno in EMP table.
UPDATE emp SET deptno = NULL WHERE deptno = 101;
DELETE FROM dept WHERE deptno = 101;

-- Q22. Delete deptno 102 from Dept table and its corresponding record from EMP table.
DELETE FROM emp WHERE deptno = 102;
DELETE FROM dept WHERE deptno = 102;

-- Q23. Delete the empno 111 who is the manager of the employee whose empno is 114.
UPDATE emp SET mgr_no = NULL WHERE empno = 114;
DELETE FROM emp WHERE empno = 111;

-- Q24. Delete the record of ‘Ravi’ whose empno is 112 and set the mgr_no to NULL for all the employees for whom Ravi is the manager.
UPDATE emp SET mgr_no = NULL WHERE mgr_no = 112;
DELETE FROM emp WHERE empno = 112;

-- Q25. Drop the duplicate table of EMP.
DROP TABLE emp_copy;

---- End of Code -----
