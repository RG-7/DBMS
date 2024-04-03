/*
    Assignment 5
    Feb , 2024
*/


-- 1. Create department table
CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dept_name VARCHAR(50) CHECK (dept_name IN ('Acc', 'comp', 'elect'))
);

-- 2. Create employee table
CREATE TABLE emp (
    empno INT PRIMARY KEY,
    emp_name VARCHAR(50) UNIQUE,
    job VARCHAR(20),
    sal INT,
    deptno INT,
    mgr_no INT,
    FOREIGN KEY (deptno) REFERENCES dept(deptno),
    FOREIGN KEY (mgr_no) REFERENCES emp(empno)
);

-- 3. Create salesperson table
CREATE TABLE S (
    sno INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50)
);

-- 4. Create part table
CREATE TABLE P (
    pno INT PRIMARY KEY,
    pname VARCHAR(50),
    color VARCHAR(20)
);

-- 5. Create project table
CREATE TABLE J (
    jno INT PRIMARY KEY,
    jname VARCHAR(50),
    city VARCHAR(50)
);

-- 6. Create SPJ table
CREATE TABLE SPJ (
    sno INT,
    pno INT,
    jno INT,
    qty INT,
    PRIMARY KEY (sno, pno, jno),
    FOREIGN KEY (sno) REFERENCES S(sno),
    FOREIGN KEY (pno) REFERENCES P(pno),
    FOREIGN KEY (jno) REFERENCES J(jno)
);

-- 7. Insert records into tables
INSERT INTO dept (deptno, dept_name) VALUES(101, 'Acc');
INSERT INTO dept (deptno, dept_name) VALUES(102, 'comp');
INSERT INTO dept (deptno, dept_name) VALUES(103, 'elect');
INSERT INTO dept (deptno, dept_name) VALUES(104, 'Acc');
INSERT INTO dept (deptno, dept_name) VALUES(105, 'comp');
INSERT INTO dept (deptno, dept_name) VALUES(106, 'elect');


INSERT INTO emp (empno, emp_name, job, sal, deptno, mgr_no) VALUES(100, 'John Doe', 'Prof', 50000, 101, NULL);
INSERT INTO emp (empno, emp_name, job, sal, deptno, mgr_no) VALUES(101, 'Jane Smith', 'AP', 40000, 102, 100);
INSERT INTO emp (empno, emp_name, job, sal, deptno, mgr_no) VALUES(102, 'Michael Johnson', 'Lect', 30000, 103, 100);
INSERT INTO emp (empno, emp_name, job, sal, deptno, mgr_no) VALUES(103, 'Emily Davis', 'Lect', 32000, 101, 101);
INSERT INTO emp (empno, emp_name, job, sal, deptno, mgr_no) VALUES(104, 'Robert Brown', 'AP', 45000, 102, 102);

INSERT INTO S (sno, sname, city) VALUES(1, 'Alice', 'New York');
INSERT INTO S (sno, sname, city) VALUES(2, 'Bob', 'Los Angeles');
INSERT INTO S (sno, sname, city) VALUES(3, 'Charlie', 'Chicago');
INSERT INTO S (sno, sname, city) VALUES(4, 'David', 'Houston');
INSERT INTO S (sno, sname, city) VALUES(5, 'Eva', 'San Francisco');

INSERT INTO P (pno, pname, color) VALUES(1, 'Widget', 'Red');
INSERT INTO P (pno, pname, color) VALUES(2, 'Gadget', 'Blue');
INSERT INTO P (pno, pname, color) VALUES(3, 'Thingamajig', 'Green');
INSERT INTO P (pno, pname, color) VALUES(4, 'Doohickey', 'Yellow');
INSERT INTO P (pno, pname, color) VALUES(5, 'Whatchamacallit', 'Purple');

INSERT INTO J (jno, jname, city) VALUES(1, 'Project A', 'New York');
INSERT INTO J (jno, jname, city) VALUES(2, 'Project B', 'Los Angeles');
INSERT INTO J (jno, jname, city) VALUES(3, 'Project C', 'Chicago');
INSERT INTO J (jno, jname, city) VALUES(4, 'Project D', 'Houston');
INSERT INTO J (jno, jname, city) VALUES(5, 'Project E', 'San Francisco');

INSERT INTO SPJ (sno, pno, jno, qty) VALUES(1, 1, 1, 10);
INSERT INTO SPJ (sno, pno, jno, qty) VALUES(2, 2, 2, 15);
INSERT INTO SPJ (sno, pno, jno, qty) VALUES(3, 3, 3, 20);
INSERT INTO SPJ (sno, pno, jno, qty) VALUES(4, 4, 4, 25);
INSERT INTO SPJ (sno, pno, jno, qty) VALUES(5, 5, 5, 30);

-- 8.
