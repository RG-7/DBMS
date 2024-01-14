/*
    Assignmnet 1
    Jan 14, 2024
*/

/*
    Question 1:- 
    Create table Student (Rno, Name, DOB, Gender, Class, College, City, Marks)
*/

CREATE TABLE Student (
    Rno NUMBER NOT NULL PRIMARY KEY,
    Name VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    Class VARCHAR(20),
    College VARCHAR(50),
    City VARCHAR(30),
    Marks FLOAT
);


/*
	Question 2 : -
	Insert 5 records in student table
*/
INSERT INTO Student VALUES (102397020, 'Rahul Kumar', '10-JUL-1997', 'Male', '12th', 'Thapar', 'Patiala', 78.5);
INSERT INTO Student VALUES (102397021, 'Priya Sharma', '22-JAN-1998', 'Female', '10th', 'VIT', 'Vellore', 92.0);
INSERT INTO Student VALUES(102397022, 'Amit Singh', '15-MAR-1999', 'Male', '11th', 'BITs', 'Pilani', 85.5);
INSERT INTO Student VALUES (102397023, 'Neha Gupta', '05-JAN-2000', 'Female', '9th', 'SRM', 'Chennai', 71.0);
INSERT INTO Student VALUES (102397024, 'Sandeep Verma', '18-AUG-2001', 'Male', '12th', 'Thapar', 'Patiala', 90.5);

/*
	Question 3: -
	Display the information of all the students.
*/
SELECT * FROM Student;

/*
	Question 4: -
	Display the detail structure of student table.
*/
DESC[RIBE] Student;

/*
	Question 5: -
	Display Rno, Name and Class information of ‘Patiala’ students.
*/
SELECT Rno, Name, Class FROM Student WHERE City = 'Patiala';

/*
	Question 6: -
    Display information on ascending order of marks
*/
SELECT * FROM Student ORDER BY Marks ASC;

/*
	Question 7: -
    Change the marks of Rno 102397024 to 89.
*/
UPDATE Student SET Marks = 89 WHERE Rno = 102397024;

/*
	Question 8: -
	Change the name and city of Rno 102397020.
*/
UPDATE Student SET Name = 'Ratn Govindam', City = 'Samastipur' WHERE Rno = 102397020;

/*
	Question 9: -
	Delete the information of ‘Pilani’ city records
*/
DELETE FROM Student WHERE City='Pilani';

/*
	Question 10: -
	Delete the records of student where marks<80.
*/
DELETE FROM Student WHERE Marks<80;

SELECT * FROM Student;
