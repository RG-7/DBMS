-- Creating table Student
CREATE TABLE Student (
    Rollno NUMBER,
    Name VARCHAR2(50),
    Age NUMBER,
    Mark1 NUMBER,
    Mark2 NUMBER,
    Mark3 NUMBER,
    Total NUMBER
);

-- Creating table Student-minor
CREATE TABLE Student_minor (
    Rollno NUMBER,
    Name VARCHAR2(50),
    Age NUMBER,
    Mark1 NUMBER,
    Mark2 NUMBER,
    Mark3 NUMBER,
    Total NUMBER
);

-- Inserting sample data into Student table

INSERT INTO Student (Rollno, Name, Age, Mark1, Mark2, Mark3, Total) VALUES    (1, 'John', 20, 80, 85, 90, NULL);
INSERT INTO Student (Rollno, Name, Age, Mark1, Mark2, Mark3, Total) VALUES    (2, 'Jane', 22, 75, 90, 85, NULL);
INSERT INTO Student (Rollno, Name, Age, Mark1, Mark2, Mark3, Total) VALUES    (3, 'Alice', 24, 90, 95, 80, NULL);
INSERT INTO Student (Rollno, Name, Age, Mark1, Mark2, Mark3, Total) VALUES   (4, 'Bob', 26, 85, 80, 75, NULL);
INSERT INTO Student (Rollno, Name, Age, Mark1, Mark2, Mark3, Total) VALUES   (5, 'Charlie', 21, 92, 88, 95, NULL);

-- Inserting sample data into Student-minor table
-- No data initially

-- Creating table EMP
CREATE TABLE EMP (
    empno NUMBER,
    ename VARCHAR2(50),
    job VARCHAR2(50),
    sal NUMBER,
    deptno NUMBER
);

-- Inserting sample data into EMP table

INSERT INTO EMP (empno, ename, job, sal, deptno) VALUES   (101, 'John', 'Manager', 5000, 10);
INSERT INTO EMP (empno, ename, job, sal, deptno) VALUES    (102, 'Jane', 'Developer', 4500, 20);
INSERT INTO EMP (empno, ename, job, sal, deptno) VALUES    (103, 'Alice', 'Analyst', 4800, 10);
INSERT INTO EMP (empno, ename, job, sal, deptno) VALUES    (104, 'Bob', 'Tester', 4200, 30);
INSERT INTO EMP (empno, ename, job, sal, deptno) VALUES    (105, 'Charlie', 'Designer', 4700, 20);

-- Creating table Customer
CREATE TABLE Customer (
    ID NUMBER PRIMARY KEY,
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    address VARCHAR2(40)
);

-- Inserting sample data into Customer table

INSERT INTO Customer (ID, first_name, last_name, address) VALUES(1, 'John', 'Doe', '123 Main St');
INSERT INTO Customer (ID, first_name, last_name, address) VALUES(2, 'Jane', 'Smith', '456 Elm St');
INSERT INTO Customer (ID, first_name, last_name, address) VALUES(3, 'Alice', 'Johnson', '789 Oak St');
INSERT INTO Customer (ID, first_name, last_name, address) VALUES(4, 'Bob', 'Williams', '101 Pine St');
INSERT INTO Customer (ID, first_name, last_name, address) VALUES(5, 'Ramesh', 'Kumar', '321 Maple St');
INSERT INTO Customer (ID, first_name, last_name, address) VALUES(6, 'Ramesh', 'Patel', '543 Cedar St');

-- Q1. Write a PL/SQL code using a cursor to delete records from the Student table where age < 25 and insert them into the Student-minor table.
DECLARE
    CURSOR C IS SELECT * FROM Student WHERE age < 25;
    rec C%ROWTYPE;
BEGIN
    FOR rec IN C LOOP
        INSERT INTO student_minor VALUES (rec.rollno, rec.name, rec.age, rec.mark1, rec.mark2, rec.mark3, rec.total);
        DELETE FROM student WHERE rollno = rec.rollno;
    END LOOP;
END;
/

-- Q2. Write a PL/SQL code using a cursor to find the total marks of each student and update the total column.
DECLARE
    CURSOR C IS SELECT * FROM Student;
BEGIN
    FOR rec IN C LOOP
        UPDATE student SET total = rec.mark1 + rec.mark2 + rec.mark3 WHERE rollno = rec.rollno;
        UPDATE student_minor SET total = rec.mark1 + rec.mark2 + rec.mark3 WHERE rollno = rec.rollno;
    END LOOP;
    COMMIT;
END;
/

-- Q3. Write a PL/SQL code using a cursor to find out how many students have total marks greater than 90 and display their details.
DECLARE
    count NUMBER := 0;
    CURSOR C IS SELECT * FROM student WHERE total > 90;
BEGIN
    FOR rec IN C LOOP
        DBMS_OUTPUT.PUT_LINE('Rollno: ' || rec.rollno || ', Name: ' || rec.name || ', Total Marks: ' || rec.total);
        count := count + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total students with marks greater than 90: ' || count);
END;
/

-- Q4. Write a PL/SQL code using a cursor to find the highest and lowest marks and display the corresponding student’s details.
DECLARE
    highest_mark NUMBER := 0;
    lowest_mark NUMBER := 100000;
    highest_rollno Student.Rollno%TYPE;
    lowest_rollno Student.Rollno%TYPE;
    CURSOR C IS SELECT * FROM Student;
BEGIN
    FOR rec IN C LOOP
        IF rec.total > highest_mark THEN
            highest_mark := rec.total;
            highest_rollno := rec.Rollno;
        END IF;
        IF rec.total < lowest_mark THEN
            lowest_mark := rec.total;
            lowest_rollno := rec.Rollno;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Highest Marks: ' || highest_mark || ', Student Rollno: ' || highest_rollno);
    DBMS_OUTPUT.PUT_LINE('Lowest Marks: ' || lowest_mark || ', Student Rollno: ' || lowest_rollno);
END;
/

-- Q5. Write a PL/SQL code using a cursor to find the average mark of all the students and display it on the screen.
DECLARE
    total_marks NUMBER := 0;
    student_count NUMBER := 0;
    average_mark NUMBER;
    CURSOR C IS SELECT * FROM Student;
BEGIN
    FOR rec IN C LOOP
        total_marks := total_marks + rec.total;
        student_count := student_count + 1;
    END LOOP;
    average_mark := total_marks / student_count;
    DBMS_OUTPUT.PUT_LINE('Average Mark: ' || average_mark);
END;
/

-- Q6. Write a stored procedure using a parameterized cursor to display the student details whose rollno is passed as a parameter.
CREATE OR REPLACE PROCEDURE get_student_details (rno IN Student.Rollno%TYPE)
IS
    CURSOR C IS SELECT * FROM Student WHERE rollno = rno;
BEGIN
    FOR rec IN C LOOP
        DBMS_OUTPUT.PUT_LINE('Rollno: ' || rec.rollno || ', Name: ' || rec.name || ', Age: ' || rec.age || ', Total Marks: ' || rec.total);
    END LOOP;
END;
/

-- Q7. Write a PL/SQL code to demonstrate %TYPE and %ROWTYPE to display details of employees in EMP table.
DECLARE
    E EMP%ROWTYPE;
BEGIN
    SELECT * INTO E FROM EMP WHERE ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('Employee Number: ' || E.empno);
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || E.ename);
    DBMS_OUTPUT.PUT_LINE('Job: ' || E.job);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || E.sal);
    DBMS_OUTPUT.PUT_LINE('Department Number: ' || E.deptno);
END;
/

-- Q8. Write a stored function to display the empno, ename, and job of employees of a department using a parameterized cursor.
CREATE OR REPLACE FUNCTION emp_fun(dno NUMBER) RETURN NUMBER AS
    CURSOR c1(dn NUMBER) IS SELECT empno, name, job FROM emp WHERE deptno = dn;
    flag NUMBER := 0;
BEGIN
    FOR rec IN c1(dno) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.empno || ' ' || rec.ename || ' ' || rec.job);
        flag := 1;
    END LOOP;
    RETURN flag;
END;
/

-- Q9. Write a local function to display the employee number and name of the top ‘n’ highest-paid employees using a parameterized cursor.
DECLARE
    n NUMBER;
    x NUMBER;
    CURSOR c2(n NUMBER) IS SELECT empno, name, sal FROM emp ORDER BY sal DESC;
FUNCTION sal_fun(n NUMBER) RETURN NUMBER AS
    flag NUMBER := 0;
BEGIN
    FOR rec IN c2(n) LOOP
        EXIT WHEN c2%ROWCOUNT > n;
        DBMS_OUTPUT.PUT_LINE(rec.empno || ' ' || rec.ename || ' ' || rec.sal);
        flag := 1;
    END LOOP;
    RETURN flag;
END;
BEGIN
    n := &n;
    x := sal_fun(n);
    IF x = 0 THEN
        DBMS_OUTPUT.PUT_LINE('n records are there in the EMP table');
    ELSE
        DBMS_OUTPUT.PUT_LINE('n records are not there in the EMP table');
    END IF;
END;
/

-- Q10. Write a local procedure to calculate the total salary of the first ‘n’ records of EMP table using parameterized cursor.
DECLARE
    empno EMP.empno%TYPE;
    ename EMP.ename%TYPE;
BEGIN
    SELECT empno, ename INTO empno, ename FROM EMP WHERE ROWNUM <= 1;
    DBMS_OUTPUT.PUT_LINE('Employee Number: ' || empno || ', Employee Name: ' || ename);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Too many rows returned.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No data found.');
END;
/

-- Q11. Write a PL/SQL program to demonstrate the following exceptions: Too Many Rows, No Data Found.
DECLARE
    c_id customers.id%TYPE := 5;
    c_fname customers.first_name%TYPE;
    c_lname customers.last_name%TYPE;
    c_addr customers.address%TYPE;
BEGIN
    SELECT address INTO c_addr FROM customers WHERE id = c_id;
    DBMS_OUTPUT.PUT_LINE ('Address: ' || c_addr);
    SELECT last_name INTO c_lname FROM customers WHERE first_name = 'Ramesh';
    DBMS_OUTPUT.PUT_LINE ('Last Name: ' || c_lname);
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE ('Your SELECT statement retrieved multiple rows.');
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

-- Q12. Write a PL/SQL program to demonstrate User Defined Exceptions.
DECLARE
    x INTEGER := &x;
    y INTEGER := &y;
    div FLOAT;
    ex1 EXCEPTION;
    ex2 EXCEPTION;
BEGIN
    IF y = 0 THEN
        RAISE ex1;
    ELSIF y > x THEN
        RAISE ex2;
    ELSE
        div := x / y;
        DBMS_OUTPUT.PUT_LINE('The result is ' || div);
    END IF;
EXCEPTION
    WHEN ex1 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Division by zero not allowed');
    WHEN ex2 THEN
        DBMS_OUTPUT.PUT_LINE('Error: y is greater than x. Please check the input.');
END;
/
-- All codes updated one....
