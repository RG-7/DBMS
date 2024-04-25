
-- Q1. Write a pl/sql code using cursor, which will delete all those records from the Student table 
-- where age < 25 and insert those records into another table called Student-minor.

DECLARE 
    CURSOR C IS SELECT * FROM Student WHERE age < 25; 
    rec C%ROWTYPE; 
BEGIN 
    FOR rec IN C LOOP 
        INSERT INTO student_minor VALUES (rec.rollno, rec.name, rec.age, rec.mark1, 
        rec.mark2, rec.mark3, rec.total); 
        DELETE FROM student WHERE rollno = rec.rollno; 
    END LOOP; 
END; 

-- Q2. Write a pl/sql code using cursor, which will find the total marks of each student and update 
-- the total column (assume that initially, the total is zero for all the students).

DECLARE 
    CURSOR C IS SELECT * FROM Student; 
BEGIN 
    FOR rec IN C LOOP 
        UPDATE student SET total = rec.mark1 + rec.mark2 + rec.mark3 WHERE rollno = rec.rollno; 
        UPDATE student_minor SET total = rec.mark1 + rec.mark2 + rec.mark3 WHERE rollno = rec.rollno; 
    END LOOP; 
    COMMIT; 
END; 

-- Q3. Write a pl/sql code using cursor to find out how many students are there whose total marks 
-- are greater than 90, and then display their details.

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

-- Q4. Write a pl/sql code using cursor to find the highest and lowest marks and display the 
-- corresponding student’s details.

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

-- Q5. Write a pl/sql code using cursor to find the average mark of all the students and display it on 
-- the screen.

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

-- Q6. Write a stored procedure using a parameterized cursor, which will display the student details 
-- whose rollno is passing as a parameter to the cursor from the stored procedure.

CREATE OR REPLACE PROCEDURE get_student_details (rno IN Student.Rollno%TYPE) 
IS 
    CURSOR C IS SELECT * FROM Student WHERE rollno = rno; 
BEGIN 
    FOR rec IN C LOOP 
        DBMS_OUTPUT.PUT_LINE('Rollno: ' || rec.rollno || ', Name: ' || rec.name || ', Age: ' || rec.age || ', Total Marks: ' || rec.total); 
    END LOOP; 
END; 

-- Q7. Write a PL/SQL code to demonstrate %TYPE and %ROWTYPE to display details of 
-- employees in EMP table.

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

-- Q8. Write a stored function to display the empno, ename, and job of employees of a department 
-- for EMP table using a parameterized cursor where deptno will be sent as a parameter to the cursor 
-- from the stored function.

CREATE OR REPLACE FUNCTION emp_fun(dno NUMBER) RETURN NUMBER AS 
    CURSOR c1(dn NUMBER) IS SELECT empno, ename, job FROM emp WHERE deptno = dn; 
    flag NUMBER := 0; 
BEGIN 
    FOR rec IN c1(dno) LOOP 
        DBMS_OUTPUT.PUT_LINE(rec.empno || ' ' || rec.ename || ' ' || rec.job); 
        flag := 1; 
    END LOOP; 
    RETURN flag; 
END; 

-- Q9. Write a local function to display the employee number and name of the top ‘n’ highest-paid 
-- Employees using parameterized cursor.

DECLARE 
    n NUMBER; 
    x NUMBER; 
    CURSOR c2(n NUMBER) IS SELECT empno, ename, sal FROM emp ORDER BY sal DESC; 
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

-- Q10. Write a local procedure to calculate the total salary of the first ‘n’ records of EMP table using 
-- parameterized cursor.

DECLARE 
    empno EMP.empno%TYPE; 
    ename EMP.ename%TYPE; 
BEGIN 
    SELECT emp

no, ename INTO empno, ename FROM EMP WHERE ROWNUM <= 1; 
    DBMS_OUTPUT.PUT_LINE('Employee Number: ' || empno || ', Employee Name: ' || ename); 
EXCEPTION 
    WHEN TOO_MANY_ROWS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: Too many rows returned.'); 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Error: No data found.'); 
END; 

-- Q11. Write a PL/SQL program to demonstrate the following exceptions: 
-- • Too Many Rows 
-- • No Data Found

CREATE TABLE Customer (
    ID NUMBER PRIMARY KEY,
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    address VARCHAR2(40)
);

-- Insert 4 records with ID from 1 to 4 and two records with first_name ‘Ramesh’.

DECLARE 
    c_id customers.id%TYPE := 5; 
    c_fname customers.first_name%TYPE; 
    c_lname customers.last_name%TYPE; 
    c_addr customers.address%TYPE; 
BEGIN 
    SELECT address INTO c_addr FROM customers WHERE id = c_id; 
    DBMS_OUTPUT.PUT_LINE ('Address: ' || c_addr); 
    SELECT last_name INTO c_lname FROM customers WHERE first_name= ‘Ramesh’; 
    DBMS_OUTPUT.PUT_LINE ('Last Name: ' || c_lname); 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No such customer!'); 
    WHEN TOO_MANY_ROWS THEN 
        DBMS_OUTPUT.PUT_LINE ('Your SELECT statement retrieved multiple rows.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error!'); 
END; 

-- Q12. Write a PL/SQL program to demonstrate the User Defined Exceptions 
-- Divide non-negative integer x by y such that the result is greater than or equal to 1. From the 
-- given question we can conclude that there exist two exceptions 
-- • Division by zero. 
-- • If result is greater than or equal to 1 means y is less than or equal to x.

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
        DBMS_OUTPUT.PUT_LINE('Error'); 
        DBMS_OUTPUT.PUT_LINE('Division by zero not allowed'); 
    WHEN ex2 THEN 
        DBMS_OUTPUT.PUT_LINE('Error'); 
        DBMS_OUTPUT.PUT_LINE('y is greater than x please check the input'); 
END;
