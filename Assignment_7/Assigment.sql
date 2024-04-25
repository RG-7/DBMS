-- 1) Create the tables and insert records:
CREATE TABLE SalesPeople (
    Snum INT PRIMARY KEY,
    Sname VARCHAR(255) UNIQUE,
    City VARCHAR(255),
    Comm DECIMAL(5, 2)
);

CREATE TABLE Customers (
    Cnum INT PRIMARY KEY,
    Cname VARCHAR(255),
    City VARCHAR(255) NOT NULL,
    Snum INT,
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);

CREATE TABLE Orders (
    Onum INT PRIMARY KEY,
    Amt DECIMAL(10, 2),
    Odate DATE,
    Cnum INT,
    Snum INT,
    FOREIGN KEY (Cnum) REFERENCES Customers(Cnum),
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);


INSERT INTO SalesPeople (Snum, Sname, City, Comm) VALUES(1001, 'Peel', 'London', 0.12);
INSERT INTO SalesPeople (Snum, Sname, City, Comm) VALUES(1002, 'Serres', 'Sanjose', 0.13);
INSERT INTO SalesPeople (Snum, Sname, City, Comm) VALUES(1004, 'Motika', 'London', 0.11);
INSERT INTO SalesPeople (Snum, Sname, City, Comm) VALUES(1007, 'Rifkin', 'Barcelona', 0.15);
INSERT INTO SalesPeople (Snum, Sname, City, Comm) VALUES(1003, 'Axelrod', 'New York', 0.10);


INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES(2001, 'Hoffman', 'London', 1001);
INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES(2002, 'Giovanni', 'Rome', 1003);
INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES(2003, 'Liu', 'Sanjose', 1002);
INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES(2004, 'Grass', 'Berlin', 1002);
INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES(2006, 'Clemens', 'London', 1001);
INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES(2008, 'Cisneros', 'Sanjose', 1007);
INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES(2007, 'Pereira', 'Rome', 1004);


INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3001, 18.69,TO_DATE('1990-10-03','yyyy-mm-dd'), 2008, 1007);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3003, 767.19,TO_DATE( '1990-10-03','yyyy-mm-dd'), 2001, 1001);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3002, 1900.10,TO_DATE ('1990-10-03','yyyy-mm-dd'), 2007, 1004);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3005, 5160.45,TO_DATE( '1990-10-03','yyyy-mm-dd'), 2003, 1002);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3006, 1098.16,TO_DATE( '1990-10-03','yyyy-mm-dd'), 2008, 1007);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3009, 1713.23,TO_DATE( '1990-10-04','yyyy-mm-dd'), 2002, 1003);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3007, 75.75,TO_DATE( '1990-10-04','yyyy-mm-dd'), 2004, 1002);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3008, 4273.00, TO_DATE('1990-10-05','yyyy-mm-dd'), 2006, 1001);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3010, 1309.95, TO_DATE('1990-10-06','yyyy-mm-dd'), 2004, 1002);
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES(3011, 9891.88,TO_DATE( '1990-10-06','yyyy-mm-dd'), 2006, 1001);

-- 2) Display salespeople with orders worth more than Rs. 2000:
SELECT DISTINCT S.Snum, S.Sname
FROM SalesPeople S
JOIN Orders O ON S.Snum = O.Snum
GROUP BY S.Snum, S.Sname
HAVING SUM(O.Amt) > 2000;

-- 3) Display salespeople handling at least two customers:
SELECT Snum
FROM Customers
GROUP BY Snum
HAVING COUNT(DISTINCT Cnum) >= 2;

-- 4) Display salespeople names handling at least two customers:
SELECT S.Sname
FROM SalesPeople S
JOIN (
    SELECT Snum
    FROM Customers
    GROUP BY Snum
    HAVING COUNT(DISTINCT Cnum) >= 2
) C ON S.Snum = C.Snum;

-- 5) Display the number of Salespeople belonging to London and Paris:
SELECT City, COUNT(*) AS Num_Salespeople
FROM SalesPeople
WHERE City IN ('London', 'Paris')
GROUP BY City;

-- 6) Display the customer names corresponding to salespeople belonging to London and Paris:
SELECT C.Cname
FROM Customers C
JOIN SalesPeople S ON C.Snum = S.Snum
WHERE S.City IN ('London', 'Paris');

-- 7) Display the customer names whose order amount is worth 1200:
SELECT DISTINCT C.Cname
FROM Customers C
JOIN Orders O ON C.Cnum = O.Cnum
WHERE O.Amt = 1200;

-- 8) Display the customer names who belong to the same city as their salesperson:
SELECT C.Cname
FROM Customers C
JOIN SalesPeople S ON C.Snum = S.Snum
WHERE C.City = S.City;

-- 9) Display the salesperson names having commission more than 10 percent and who handled more than two customers:
SELECT S.Sname
FROM SalesPeople S
JOIN (
    SELECT Snum
    FROM Customers
    GROUP BY Snum
    HAVING COUNT(DISTINCT Cnum) > 2
) C ON S.Snum = C.Snum
WHERE S.Comm > 0.10;

-- 10) Display the customer’s name who orders exactly one order and his salesperson name:
SELECT C.Cname, S.Sname
FROM Customers C
JOIN SalesPeople S ON C.Snum = S.Snum
JOIN (
    SELECT Cnum
    FROM Orders
    GROUP BY Cnum
    HAVING COUNT(*) = 1
) O ON C.Cnum = O.Cnum;

-- 11) Insert the details of a salesperson who is a new join and did not handle any customer:
INSERT INTO SalesPeople (Snum, Sname, City, Comm)
VALUES (1010, 'New Join', 'New City', 0.10);

-- Query to find salespersons who have not handled any customers:
SELECT *
FROM SalesPeople
WHERE Snum NOT IN (SELECT DISTINCT Snum FROM Customers);

-- 12) Write a query that counts the number of Salespeople registering orders for each day:
SELECT Odate, COUNT(DISTINCT Snum) AS Num_Salespeople
FROM Orders
GROUP BY Odate;

-- 13) Find out the number of Salespeople who belong to the same city and have the same commission percentage:
SELECT City, Comm, COUNT(*) AS Num_Salespeople
FROM SalesPeople
GROUP BY City, Comm
HAVING COUNT(*) > 1;
