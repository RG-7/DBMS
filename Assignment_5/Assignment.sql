/*
    Assignment 5
    Feb , 2024
*/

-- Question 1: Create table dept which has the following attributes (department table) (deptno, dept_name) where deptno is primary key, dept_name in (Acc, comp, elect) 
CREATE TABLE dept(
    dept_no NUMBER PRIMARY KEY,
    dept_name VARCHAR(50) CHECK (dept_name IN ('Acc','Comp','Elect'))
);


-- Question 2: Create table emp which has the following attributes (employee table) (empno, emp_name, job, sal, deptno, mgr_no) where empno is primary key, emp_name is unique, job in (Prof, AP, and Lect), sal is NOT NULL, deptno is foreign key, mgr_no is a self-referential foreign key. 
CREATE TABLE emp(
    emp_no NUMBER PRIMARY KEY,
    emp_name VARCHAR(50) UNIQUE,
    job VARCHAR(50) CHECK (job IN ('Prof','AP','Lect')),
    sal FLOAT NOT NULL,
    dept_no NUMBER,
    mgr_no NUMBER,
    FOREIGN KEY (dept_no) REFERENCES dept(dept_no),
    FOREIGN KEY (mgr_no) REFERENCES emp(emp_no)
);


-- Question 3: Create table S which has the following attributes (Salesperson table) (sno, sname, city) where sno is primary key 
CREATE TABLE S(
    s_no NUMBER PRIMARY KEY,
    s_name VARCHAR(50),
    city VARCHAR(50)
);


-- QUESTION 4: Create table P which has the following attributes (Part table) (pno, pname, color) where pno is primary key 
CREATE TABLE P(
    p_no NUMBER PRIMARY KEY,
    p_name VARCHAR(50),
    color VARCHAR(20)
);


-- QUESTION 5: Create table J which has the following attributes (ProJect table) (jno, jname, city) where jno is primary key 
CREATE TABLE J(
    j_no NUMBER PRIMARY KEY,
    j_name VARCHAR(50),
    city VARCHAR(20)
);


-- QUESTION 6: Create table SPJ which has the following attributes (sno, pno, jno, qty) where combination of (sno, pno, jno) is a composite primary key. Also, sno, pno, jno are foreign keys. 
CREATE TABLE SPJ(
    s_no NUMBER,
    p_no NUMBER,
    j_no NUMBER,
    qty NUMBER,
    PRIMARY KEY (s_no,p_no,j_no),
    FOREIGN KEY (s_no) REFERENCES S(s_no),
    FOREIGN KEY (p_no) REFERENCES P(p_no),
    FOREIGN KEY (j_no) REFERENCES J(j_no)
);
