/* 
-- Pre-requisites
*/

CREATE TABLE Sailors(
    S_ID INT PRIMARY KEY,
    S_Name VARCHAR(50) NOT NULL,
    S_Rating INT NOT NULL,
    S_Age REAL NOT NULL
);

CREATE TABLE Boat(
    B_ID INT PRIMARY KEY,
    B_Name VARCHAR(50) NOT NULL,
    B_Color VARCHAR(50) NOT NULL
);

CREATE TABLE Reserves(
    S_ID INT, B_ID INT,
    Travel_Day DATE NOT NULL,
    FOREIGN KEY(S_ID) REFERENCES Sailors(S_ID),
    FOREIGN KEY(B_ID) REFERENCES Boat(B_ID)
);

INSERT INTO Sailors VALUES (22, 'Dustin', 7, 45.0);
INSERT INTO Sailors VALUES (29, 'Brutus', 1, 33.0);
INSERT INTO Sailors VALUES (31, 'Lubber', 8, 55.5);
INSERT INTO Sailors VALUES (32, 'Andy', 8, 25.5);
INSERT INTO Sailors VALUES (58, 'Rusty', 10, 35.0);
INSERT INTO Sailors VALUES (64, 'Horatio', 7, 35.0);
INSERT INTO Sailors VALUES (71, 'Zorba', 10, 16.0);
INSERT INTO Sailors VALUES (74, 'Horatio', 9, 35.0);
INSERT INTO Sailors VALUES (85, 'Art', 3, 25.5);
INSERT INTO Sailors VALUES (95, 'Bob', 3, 63.5);

INSERT INTO Boat VALUES (101, 'Interlake', 'Blue');
INSERT INTO Boat VALUES (102, 'Interlake', 'Red');
INSERT INTO Boat VALUES (103, 'Clipper', 'Green');
INSERT INTO Boat VALUES (104, 'Marine', 'Red');

INSERT INTO Reserves VALUES (22, 101, TO_DATE('1998-10-10','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (22, 102, TO_DATE('1998-10-10','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (22, 103, TO_DATE('1998-8-10','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (22, 104, TO_DATE('1998-7-10','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (31, 102, TO_DATE('1998-10-11','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (31, 103, TO_DATE('1998-6-11','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (31, 104, TO_DATE('1998-12-11','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (64, 101, TO_DATE('1998-5-9','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (64, 101, TO_DATE('1998-8-9','YYYY-MM-DD'));
INSERT INTO Reserves VALUES (74, 103, TO_DATE('1998-8-9','YYYY-MM-DD'));

/* 
-- Question 1: Find the names of sailors who have reserved a red or a green boat.
*/

SELECT DISTINCT S.S_Name
FROM Sailors S
JOIN Reserves R ON S.S_ID = R.S_ID
JOIN Boat B ON R.B_ID = B.B_ID
WHERE B.B_Color IN ('Red', 'Green');

/* 
-- Question 2: Find the names of sailors who have reserved both a red and a green boat.
*/

SELECT S.S_Name
FROM Sailors S
JOIN Reserves R ON S.S_ID = R.S_ID
JOIN Boat B ON R.B_ID = B.B_ID
WHERE B.B_Color = 'Red'
AND S.S_ID IN (
    SELECT S_ID
    FROM Reserves
    JOIN Boat ON Reserves.B_ID = Boat.B_ID
    WHERE Boat.B_Color = 'Green'
);

/* 
-- Question 3: Find the names of sailors who have reserved boat 103.
*/

SELECT S.S_Name
FROM Sailors S
JOIN Reserves R ON S.S_ID = R.S_ID
WHERE R.B_ID = 103;

/* 
-- Question 4: Find the names of sailors who have reserved a red boat.
*/

SELECT DISTINCT S.S_Name
FROM Sailors S
JOIN Reserves R ON S.S_ID = R.S_ID
JOIN Boat B ON R.B_ID = B.B_ID
WHERE B.B_Color = 'Red';

/* 
-- Question 5: Find the names of sailors who have NOT reserved a red boat.
*/

SELECT S.S_Name
FROM Sailors S
WHERE S.S_ID NOT IN (
    SELECT R.S_ID
    FROM Reserves R
    JOIN Boat B ON R.B_ID = B.B_ID
    WHERE B.B_Color = 'Red'
);

/* 
-- Question 6: Find the names of sailors who have reserved at least one boat.
*/

SELECT DISTINCT S.S_Name
FROM Sailors S
JOIN Reserves R ON S.S_ID = R.S_ID;

/* 
-- Question 7: Find sailors whose rating is better than some sailor called Horatio.
*/

SELECT S.S_Name
FROM Sailors S
WHERE S.S_Rating > (SELECT MAX(S_Rating) FROM Sailors WHERE S_Name = 'Horatio');

/* 
-- Question 8: Find sailors whose rating is better than every sailor called Horatio.
*/

SELECT S.S_Name
FROM Sailors S
WHERE S.S_Rating > ALL (
    SELECT S_Rating
    FROM Sailors
    WHERE S_Name = 'Horatio'
);

/* 
-- Question 9: Find the sailors with the highest rating.
*/

SELECT S.S_Name
FROM Sailors S
WHERE S.S_Rating = (
    SELECT MAX(S_Rating)
    FROM Sailors
);

/* 
-- Question 10: Find the names of sailors who have reserved all boats.
*/

SELECT S.S_Name
FROM Sailors S
WHERE NOT EXISTS (
    SELECT B_ID
    FROM Boat
    WHERE NOT EXISTS (
        SELECT *
        FROM Reserves R
        WHERE R.B_ID = Boat.B_ID AND R.S_ID = S.S_ID
    )
);

-- Ratn Govindam
