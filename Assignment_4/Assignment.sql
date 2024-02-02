/*
    Assignment 4
    Feb 02, 2024
*/
-- 1.) Display the system date
SELECT SYSDATE FROM DUAL;

-- 2.) Display current day
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;

-- 3.) Display current month and spell out year
SELECT TO_CHAR(SYSDATE,'Month') AS MONTH FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YEAR') AS SPELLED_OUT_YEAR FROM DUAL;

-- 4.) Display spell out current date
SELECT CURRENT_DATE AS SPELL_OUT FROM DUAL;

-- 5.) Check whether it is AM or PM right now
SELECT TO_CHAR(SYSDATE,'PM') AS CURR_TIME_INDICATOR FROM DUAL;

-- 6.) Display the date of next Friday
SELECT NEXT_DAY(SYSDATE,'FRIDAY') AS NEXT_FIDAY FROM DUAL;

-- 7.) Round the system date on month
SELECT ROUND(SYSDATE,'MONTH') AS ROUNDED_DATE FROM DUAL;

-- 8.) Truncate the system date on month
SELECT TRUNC(SYSDATE,'MONTH') AS TRUNCATED_DATE FROM DUAL;

-- 9.) Round the system date on year
SELECT ROUND(SYSDATE,'YEAR') AS ROUNDED_YEAR FROM DUAL;

-- 10.) Truncate the system date on year
SELECT TRUNC(SYSDATE,'YEAR') AS TRUNCATED_YEAR FROM DUAL;

-- 11.) Find the day after three days
SELECT TO_CHAR(SYSDATE+3,'DAY') AS DAY_AFTER_3_DAYS FROM DUAL;

-- Queries Based on EMP table
-- 12.) Create an EMP table (Empno number, Name Varchar2(20), date_of_joining date)
CREATE TABLE EMP(
    Empno NUMBER,
    Name VARCHAR(50),
    Date_of_joining DATE
);

-- Inserting few dummy data for coming questions
INSERT INTO EMP (Empno, Name, Date_of_Joining) VALUES (1, 'John Doe', TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO EMP (Empno, Name, Date_of_Joining) VALUES (2, 'Jane Smith', TO_DATE('2023-02-20', 'YYYY-MM-DD'));
INSERT INTO EMP (Empno, Name, Date_of_Joining) VALUES (3, 'Alice Johnson', TO_DATE('2023-03-05', 'YYYY-MM-DD'));
INSERT INTO EMP (Empno, Name, Date_of_Joining) VALUES (4, 'Bob Williams', TO_DATE('2023-04-10', 'YYYY-MM-DD'));
INSERT INTO EMP (Empno, Name, Date_of_Joining) VALUES (5, 'Charlie Brown', TO_DATE('2023-05-25', 'YYYY-MM-DD'));

-- 13.) Display day of date of joining column
SELECT Empno,Name, EXTRACT(DAY FROM Date_of_joining) AS Day_of_joining FROM EMP;

-- 14.) Display those employees who join the company on Monday
SELECT Empno,Name,Date_of_joining FROM EMP WHERE TO_CHAR(Date_of_joining,'FMDAY')='MONDAY';

-- 15.) Display those employees who join the company this month
SELECT Empno,Name,Date_of_joining FROM EMP WHERE TO_CHAR(Date_of_joining,'MONTH') = TO_CHAR(SYSDATE,'MONTH');

-- 16.) Display those employees who join the company in last 30 days
SELECT * FROM EMP WHERE Date_of_joining >= SYSDATE-30;

-- Queries based on Train Arrival and Departure
-- 17.) Create a table Train having four columns (TrainNo Number (6) primary key, date of departure, time of departure, time of arrival)
CREATE TABLE Train(
    TrainNo NUMBER(6) PRIMARY KEY,
    Date_of_Departure DATE,
    Time_of_Departure TIMESTAMP,
    Time_of_Arrival TIMESTAMP
);

-- 18.) Insert five records into the table Train.
INSERT INTO Train VALUES (101, TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_TIMESTAMP('08:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('12:00:00', 'HH24:MI:SS'));
INSERT INTO Train VALUES (102, TO_DATE('2023-03-16', 'YYYY-MM-DD'), TO_TIMESTAMP('10:30:00', 'HH24:MI:SS'), TO_TIMESTAMP('14:45:00', 'HH24:MI:SS'));
INSERT INTO Train VALUES (103, TO_DATE('2023-03-17', 'YYYY-MM-DD'), TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('18:30:00', 'HH24:MI:SS'));
INSERT INTO Train VALUES (104, TO_DATE('2023-03-18', 'YYYY-MM-DD'), TO_TIMESTAMP('16:45:00', 'HH24:MI:SS'), TO_TIMESTAMP('21:15:00', 'HH24:MI:SS'));
INSERT INTO Train VALUES (105, TO_DATE('2023-03-19', 'YYYY-MM-DD'), TO_TIMESTAMP('20:15:00', 'HH24:MI:SS'), TO_TIMESTAMP('01:30:00', 'HH24:MI:SS'));

-- 19.) Display all the three records
SELECT * FROM Train;

-- 20.) Display the time values inserted in the columns
SELECT TrainNo, Time_of_Departure, Time_of_Arrival FROM Train;

-- 21.) Display those trains which arrived on PM
SELECT TrainNo, Date_of_Departure, Time_of_Departure, Time_of_Arrival FROM Train WHERE EXTRACT(HOUR FROM Time_of_Arrival) > 12;

-- 22.) Display train number who are going to depart in next one hour.
SELECT TrainNo, Time_of_Departure FROM Train WHERE Time_of_Departure BETWEEN SYSTIMESTAMP AND SYSTIMESTAMP + INTERVAL '1' HOUR;
