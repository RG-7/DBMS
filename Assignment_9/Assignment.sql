
-- 1. WAP to find the greatest of three numbers.
-- OUTPUT: <<Q1>>
SET SERVEROUTPUT on
declare
    n1 number;
    n2 number;
    n3 number;
    g number;
    function findmax(x in number, y in number, z in number)
    return number
    is
    l_g number;
    begin
        l_g:=x;
        if y > l_g then
            g:=y;
        end if;
        if z > l_g then
            l_g:=z;
        end if;
        return l_g;
    end findmax;
begin
    dbms_output.put_line('Executing Q1');
    n1 := &n1;
    n2 := &n2;
    n3 := &n3;
    g := findmax(n1, n2, n3);
    dbms_output.put_line('Maximum number between ' || n1 || ', '|| n2 || ', and ' || n3 || ' is: ' || g);
end Q1;
/

-- 2. WAP to check whether number is odd or even.
-- OUTPUT: <<Q2>>
SET SERVEROUTPUT on
declare
    n number := &n;
begin
    dbms_output.put_line('Executing Q2');
    if MOD(n, 2) = 0 then
        dbms_output.put_line(n || ' is Even.');
    else
        dbms_output.put_line(n || ' is Odd.');
    end if;
end Q2;
/

-- 3. WAP to find the grade.
-- OUTPUT: <<Q3>>
SET SERVEROUTPUT on
declare
    marks number;
begin
    dbms_output.put_line('Executing Q3');
    marks := &marks;
    case
        when marks between 81 and 100 then dbms_output.put_line('A Grade');
        when marks between 71 and 80 then dbms_output.put_line('B Grade');
        when marks between 51 and 60 then dbms_output.put_line('C Grade');
        when marks between 41 and 50 then dbms_output.put_line('D Grade');
        when marks between 0 and 40 then dbms_output.put_line('E Grade');
        else dbms_output.put_line('Not a Valid input');
    end case;
end Q3;
/

-- 4. WAP to print the table of a given number. (use for loop)
-- OUTPUT: <<Q4>>
SET SERVEROUTPUT on
declare
    n number;
begin
    dbms_output.put_line('Executing Q4');
    n := &n;
    dbms_output.put_line('Table of '||n ||' :');
    for i in 1..20 loop
        dbms_output.put_line( n || ' x ' || i || ' = ' || n*i);
    end loop;
end Q4;
/

-- 5. WAP to find out the factorial of a given number. (use while loop)
-- OUTPUT: <<Q5>>
SET SERVEROUTPUT on
declare
    n number;
    f number := 1;
    i number;
begin
    dbms_output.put_line('Executing Q5');
    n := &n ;
    i := n ;
    while i <> 0 loop
        f := f * i;
        i := i - 1;
    end loop;
    dbms_output.put_line('Factorial of ' || n || ' is ' || f);
end Q5;
/

-- 6. WAP to find out the Fibonacci series.
-- OUTPUT: <<Q6>>
SET SERVEROUTPUT on
declare
    n number;
    f_n number;
    f_n1 number := 1;
    f_n2 number := 0;
    i number;
begin
    dbms_output.put_line('Executing Q6');
    n := &n;
    if n >=1 then
        dbms_output.put_line('Fibonacci terms upto ' || n || ' terms: ');
        dbms_output.put(f_n1 ||' ');
        for i in 3..(n+1) loop
            f_n := f_n1 + f_n2;
            dbms_output.put(f_n ||' ');
            f_n2 := f_n1;
            f_n1 := f_n;
        end loop;
        dbms_output.put_line(' ');
    else
        dbms_output.put_line('Number of terms should not be less than 1');
    end if;
end Q6;
/

-- 7. WAP to find the reverse of a number
-- OUTPUT: <<Q7>>
SET SERVEROUTPUT on
declare
    n number;
    r_n number := 0;
    i number;
begin
    dbms_output.put_line('Executing Q7');
    n := &n;
    i := n;
    while i>0 loop
        r_n := r_n*10 + mod(i,10);
        i := trunc(i/10);
    end loop;
    dbms_output.put_line('Number is ' || n);
    dbms_output.put_line('Reversed Number is ' || r_n);
end Q7;
/

-- 8. Write PL/SQL block that performs addition (+), subtraction (-),
-- multiplication (*), and division (/) of two numbers as choice by the user.
-- <<Q8>>
SET SERVEROUTPUT on
DECLARE
    a NUMBER;
    b NUMBER;
    choice VARCHAR2(2);
BEGIN
    a := &a;
    b := &b;
    choice := TRIM('&choice'); -- Use TRIM to remove whitespace
    dbms_output.put_line('a: ' || a);
    dbms_output.put_line('b: ' || b);
    dbms_output.put_line('choice: ' || choice);
    CASE
        WHEN choice='+' THEN dbms_output.put_line(TO_CHAR(a) || ' + ' || TO_CHAR(b) || ' = ' || TO_CHAR(a + b));
        WHEN choice='-' THEN dbms_output.put_line(TO_CHAR(a) || ' - ' || TO_CHAR(b) || ' = ' || TO_CHAR(a - b));
        WHEN choice='*' THEN dbms_output.put_line(TO_CHAR(a) || ' * ' || TO_CHAR(b) || ' = ' || TO_CHAR(a * b));
        WHEN choice='/' THEN dbms_output.put_line(TO_CHAR(a) || ' / ' || TO_CHAR(b) || ' = ' || TO_CHAR(a / b));
        ELSE dbms_output.put_line('Feature not implemented yet');
    END CASE;
END;
/

-- 9. Write PL/SQL block to print 5, 10, 15, 20 by using For Loop.
-- OUTPUT: <<Q9>>
SET SERVEROUTPUT on
declare
    i number;
begin
    dbms_output.put_line('Executing Q9');
    dbms_output.put_line('Series of 5, 10, 15, 20 using for loop');
    for i in 1..5 loop
        dbms_output.put_line(5*i || ' ');
    end loop;
end Q9;
/

-- 10. Write Pl/SQL block to display a welcome message like good
-- morning, good afternoon, good night depending on system time
-- OUTPUT: <<Q10>>
SET SERVEROUTPUT on
declare
    hod number;
begin
   

 dbms_output.put_line('Executing Q10');
    select to_number(to_char(sysdate, 'hh24')) into hod from dual;
    case
        when hod between 6 and 12 then dbms_output.put_line('Good Morning');
        when hod between 12 and 18 then dbms_output.put_line('Good Afternoon');
        when hod between 18 and 24 then dbms_output.put_line('Good Evening');
        when hod between 0 and 6 then dbms_output.put_line('Good Night');
        else dbms_output.put_line('Not a Valid Input');
    end case;
end Q10;
/

-- End
