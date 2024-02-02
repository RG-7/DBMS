/*
    Assignment 3
    Feb 02, 2024
*/

/*
Q1) Use the following functions 
*/
-- 1. chr (n):
SELECT chr(97) from dual;

-- 2. cancat(char1,char2):
SELECT concat('Hi, ','Ratn') from dual;

-- 3. instr(string,char):
SELECT instr('Ratn Govindam','G') FROM dual;

-- 4. length(n)
SELECT length('Ratn Govindam') FROM dual;

-- 5. lpad(char1 ,n [,char2]):
SELECT lpad('Ratn Govindam',22,'$') FROM dual;

-- 6. ltrim(string [,char(s)]):
SELECT ltrim ('ratn','r') FROM dual;

-- 7. rpad(char1 ,n [,char2]):
SELECT rpad('Ratn Govindam',22,'$') FROM dual;

-- 8. rtrim(string [,char(s)]):
SELECT rtrim('Ratn','n') FROM dual;

-- 9. replace(char ,search_string , replacement_string):
SELECT replace('Ratn Govindam','am','') FROM dual;

-- 10. substr(string ,position ,substring length):
SELECT substr('Ratn Govindam',3,6) FROM dual;

-- 11. initcap(char):
SELECT initcap('ratn') FROM dual;

-- 12. lower(string):
SELECT lower('RATN GOVINDAM') FROM dual;

-- 13. upper(string):
SELECT upper('ratn govindam (lower)---> (upper) str') FROM dual;

-- 14. translate(char ,from string ,to string):
SELECT translate('ratn','atn','ose') FROM DUAL;

-- 15. abs(n):
SELECT abs(-45678.9475) FROM dual;

-- 16. ceil(n):
SELECT ceil(4587.975) FROM dual;

-- 17. cos(n):
SELECT cos(45) FROM dual;

-- 18. exp(n):
SELECT exp(3) FROM dual;

-- 19. floor(n):
SELECT floor(375864.9879) FROM DUAL;

-- 20. mod(m ,n):
SELECT mod(5,2) FROM DUAL;

-- 21. power(x ,y):
SELECT power(2,3) FROM DUAL;

-- 22. round(x [,y]):
SELECT round(8475.93875,3) FROM DUAL;

-- 23. sign(n):
SELECT sign(-34) FROM DUAL;

-- 24. sqrt(n);
SELECT sqrt(49) FROM DUAL;

-- 25. trunc(x ,n):
SELECT trunc(34875.736427634346,4) FROM DUAL;

-- 26. sysdate:
SELECT SYSDATE FROM DUAL;

-- 27. add_months(d ,n):
SELECT ADD_MONTHS('02-FEB-24',4) FROM DUAL;

-- 28. last_day(DATE):
SELECT LAST_DAY('02-FEB-24') FROM DUAL;

-- 29. months_between(date1 ,date2):
SELECT MONTHS_BETWEEN('02-FEB-24','02-DEC-23') FROM DUAL;

-- 30. next_day(date ,char):
SELECT NEXT_DAY('02-FEB-24','MONDAY') FROM DUAL;

-- 31. greatest(expr):
SELECT GREATEST(3584,3475843,437586374385,325432,35434,3543,33232,575) FROM DUAL;

-- 32. least(expr):
SELECT LEAST(3584,3475843,437586374385,325432,35434,3543,33232,575) FROM DUAL;
