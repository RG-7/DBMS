-- Question: How would you modify the code to insert a new employee with a total salary of 50,000?

-- Create table for employees
CREATE TABLE EMP (
    eno NUMBER PRIMARY KEY,
    ename VARCHAR2(100),
    bp NUMBER,
    da NUMBER,
    hra NUMBER,
    total NUMBER
);

-- Insert employee records with NULL for total salary
INSERT INTO EMP (eno, ename, bp, da, hra, total) VALUES (101, 'Garima', 30000, 15000, 8000, NULL);
INSERT INTO EMP (eno, ename, bp, da, hra, total) VALUES (102, 'jhanvi', 32000, 16000, 9000, NULL);
INSERT INTO EMP (eno, ename, bp, da, hra, total) VALUES (103, 'Aastha', 28000, 14000, 7000, NULL);

-- Procedure to compute and update the total salary of an employee
CREATE OR REPLACE PROCEDURE compute_and_update_total(p_eno IN EMP.eno%TYPE) IS
    v_total EMP.total%TYPE;
BEGIN
    SELECT bp + da + hra INTO v_total FROM EMP WHERE eno = p_eno;
    UPDATE EMP SET total = v_total WHERE eno = p_eno;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total for employee ' || p_eno || ': ' || v_total);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with eno = ' || p_eno);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END compute_and_update_total;
/

-- Example usage of the procedure
BEGIN
    compute_and_update_total(101);
END;
/

-- Function to compute the factorial of a number
DECLARE
    FUNCTION compute_factorial(n IN NUMBER) RETURN NUMBER IS
        factorial NUMBER := 1;
    BEGIN
        IF n = 0 OR n = 1 THEN
            RETURN 1;
        ELSE
            FOR i IN 2..n LOOP
                factorial := factorial * i;
            END LOOP;
            RETURN factorial;
        END IF;
    END;
    result NUMBER;
BEGIN
    result := compute_factorial(5);
    DBMS_OUTPUT.PUT_LINE('Factorial: ' || result);
END;
/

-- Procedure to check the type of a number
CREATE OR REPLACE PROCEDURE check_number_type(p_num IN NUMBER) IS
BEGIN
    IF p_num > 0 THEN
        DBMS_OUTPUT.PUT_LINE(p_num || ' is positive.');
    ELSIF p_num < 0 THEN
        DBMS_OUTPUT.PUT_LINE(p_num || ' is negative.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(p_num || ' is zero.');
    END IF;
END;
/

-- Example usage of the procedure
BEGIN
    check_number_type(-1); -- Replace -1 with any number
END;

-- Function to compute the sum of marks from 1 to a given number
CREATE OR REPLACE FUNCTION sum_from_1_to_n(p_n IN NUMBER) RETURN NUMBER IS
    total_sum NUMBER := 0;
BEGIN
    FOR i IN 1..p_n LOOP
        total_sum := total_sum + i;
    END LOOP;
    RETURN total_sum;
END;
/

DECLARE
    n_sum NUMBER;
BEGIN
    n_sum := sum_from_1_to_n(5); -- Replace 5 with any number
    DBMS_OUTPUT.PUT_LINE('Sum from 1 to N: ' || n_sum);
END;
/

-- Procedure to compute the average of marks from a given range
DECLARE
    PROCEDURE sum_of_avg(n1 IN NUMBER, n2 IN NUMBER, result OUT NUMBER) IS
        sum NUMBER := 0;
        count NUMBER := 0;
    BEGIN
        FOR i IN n1..n2 LOOP
            sum := sum + i;
            count := count + 1;
        END LOOP;
        IF count != 0 THEN
            result := sum / count;
        ELSE
            result := 0;
        END IF;
    END;

    avg_result NUMBER;
BEGIN
    sum_of_avg(1, 10, avg_result);
    DBMS_OUTPUT.PUT_LINE('Average Sum: ' || avg_result);
END;
/

-- Procedure to print "Hello World" a given number of times
CREATE OR REPLACE PROCEDURE hello_world(p_times IN NUMBER) IS
    PROCEDURE print_hello(p_count IN NUMBER) IS
    BEGIN
        IF p_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Hello World');
            print_hello(p_count - 1);
        END IF;
    END;
BEGIN
    print_hello(p_times);
END;
/

BEGIN
    hello_world(10); -- This procedure is now fixed to display "Hello World" 10 times
END;

-- Create table for students
CREATE TABLE student (
    rollno NUMBER,
    name VARCHAR(30),
    sub_id NUMBER,
    mark1 NUMBER,
    mark2 NUMBER,
    mark3 NUMBER
);

-- Insert student records
INSERT INTO student (rollno, name, sub_id, mark1, mark2, mark3) VALUES (101, 'Janvi', 1, 80, 75, 85);
INSERT INTO student (rollno, name, sub_id, mark1, mark2, mark3) VALUES (102, 'Jia', 1, 90, 85, 88);
INSERT INTO student (rollno, name, sub_id, mark1, mark2, mark3) VALUES (103, 'Dimple', 1, 70, 65, 75);

-- Procedure to compute the total marks of a student
CREATE OR REPLACE PROCEDURE p1(p_rollno IN student.rollno%TYPE, p_total OUT NUMBER) IS
BEGIN
    SELECT mark1 + mark2 + mark3 INTO p_total FROM student WHERE rollno = p_rollno;
END;
/

DECLARE
    v_total_marks NUMBER;
BEGIN
    p1(101, v_total_marks);
    DBMS_OUTPUT.PUT_LINE('Total Marks for Rollno 101: ' || v_total_marks);
END;
/

-- Function to compute the average marks of a student
CREATE OR REPLACE FUNCTION fun2(p_rollno IN student.rollno%TYPE) RETURN NUMBER IS
    v_total NUMBER;
    v_avg NUMBER;
BEGIN
    p1(p_rollno, v_total);
    v_avg := v_total / 3;
    RETURN v_avg;
END;
/

DECLARE
    v_avg_marks NUMBER;
BEGIN
    v_avg_marks := fun2(101);
    DBMS_OUTPUT.PUT_LINE('Average Marks for Rollno 101: ' || v_avg_marks);
END;
/

-- Function to compute the highest mark of a student
CREATE OR REPLACE FUNCTION fun3(p_rollno IN student.rollno%TYPE) RETURN NUMBER IS
    v_highest_mark NUMBER;
BEGIN
    SELECT GREATEST(mark1, mark2, mark3) INTO v_highest_mark FROM student WHERE rollno = p_rollno;
    RETURN v_highest_mark;
END;
/

DECLARE
    v_highest_mark NUMBER;
BEGIN
    v_highest_mark := fun3(101);
    DBMS_OUTPUT.PUT_LINE('Highest Mark for Rollno 101: ' || v_highest_mark);
END;
/

-- Procedure to compute the individual marks of a student
DECLARE
    PROCEDURE p2(p_rollno IN student.rollno%TYPE, p_mark1 OUT NUMBER, p_mark2 OUT NUMBER, p_mark3 OUT NUMBER, p_total OUT NUMBER) IS
    BEGIN
        SELECT mark1, mark2, mark3, mark1 + mark2 + mark3 INTO p_mark1, p_mark2, p_mark3, p_total
        FROM student
        WHERE rollno = p_rollno;
    END;
BEGIN
    NULL; -- This block doesn't have any specific operation. It's just a declaration.
END;
/

DECLARE
    v_mark1 NUMBER;
    v_mark2 NUMBER;
    v_mark3 NUMBER;
    v_total_marks NUMBER;
BEGIN
    p2(101, v_mark1, v_mark2, v_mark3, v_total_marks);
    DBMS_OUTPUT.PUT_LINE('Marks for Rollno 101:');
    DBMS_OUTPUT.PUT_LINE('Mark1: ' || v_mark1);
    DBMS_OUTPUT.PUT_LINE('Mark2: ' || v_mark2);
    DBMS_OUTPUT.PUT_LINE('Mark3: ' || v_mark3);
    DBMS_OUTPUT.PUT_LINE('Total Marks: ' || v_total_marks);
END;
/


---- End
