
1.  Query the two cities in STATION with the shortest and longest CITY names,
as well as their respective lengths (i.e.: number of characters in the name).
If there is more than one smallest or largest city, choose the one that comes
first when ordered alphabetically.
/*
Enter your query here.
*/

SELECT CITY, CHAR_LENGTH(CITY) FROM STATION
WHERE CITY = (SELECT MIN(CITY) FROM STATION
WHERE CHAR_LENGTH(CITY) = 
(SELECT MIN(CHAR_LENGTH(CITY)) FROM STATION ORDER BY CITY ASC LIMIT 1));

SELECT CITY, CHAR_LENGTH(CITY) FROM STATION
WHERE CITY = (SELECT MAX(CITY) FROM STATION
WHERE CHAR_LENGTH(CITY) = 
(SELECT MAX(CHAR_LENGTH(CITY)) FROM STATION ORDER BY CITY ASC LIMIT 1));

2. Query the list of CITY names from STATION which have
vowels (i.e., a, e, i, o, and u) as both their first and last
characters. Your result cannot contain duplicates.

SELECT DISTINCT CITY 
FROM STATION 
WHERE
CITY RLIKE '^[aeiouAEIOU].*[aeiouAEIOU]$';

3. Do not begin with vowels

SELECT DISTINCT CITY FROM STATION WHERE
CITY NOT RLIKE  '^[aeiouAEIOU].*$';


4. Query the list of CITY names from STATION that do not end with vowels.
SELECT DISTINCT CITY FROM STATION WHERE
CITY REGEXP '[^aeiou]$';

5.Query the list of CITY names from STATION that either do not start
with vowels or do not end with vowels. Your result cannot contain
duplicates.

SELECT DISTINCT CITY FROM STATION WHERE
CITY NOT REGEXP '^[aeiou]' OR CITY NOT REGEXP '[aeiou]$' ;

5.1 Query the list of CITY names from STATION that do not start with vowels
and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION 
WHERE CITY NOT RLIKE '^[aeiouAEIOU]' AND CITY NOT RLIKE '[aeiouAEIOU]$';

6. Write a query to output the start and end dates of projects
listed by the number of days it took to complete the project in ascending order.
If there is more than one project that have the same number of completion days,
then order by the start date of the project.

SELECT Start_Date, MIN(End_Date) FROM 
(SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects) ) AS s,
(SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) AS e
WHERE Start_Date < End_Date
GROUP BY Start_Date
ORDER BY DATEDIFF(MIN(End_Date), Start_Date), Start_Date;

7. Write a query to output the names of those students whose best friends
got offered a higher salary than them. Names must be ordered by the salary
amount offered to the best friends. It is guaranteed that no two students
got same salary offer.

SELECT s.Name FROM
( SELECT s.ID ID, s.Name Name, p.Salary Salary, f.Friend_ID FID from 
 Students s 
 JOIN Friends f ON f.ID = s.ID
 JOIN Packages p ON p.ID = s.ID) S
 JOIN Students s1 ON s1.ID = S.FID
 JOIN Packages fp ON fp.ID = S.FID
WHERE S.Salary < fp.Salary
ORDER BY fp.Salary;


8. Write a query to output all such symmetric pairs in ascending order
by the value of X.

SELECT f1.x AS x, 
       f1.y AS y 
FROM   functions f1, 
       functions f2 
WHERE  f1.x = f2.y 
       AND f1.y = f2.x 
       AND f1.x < f1.y
UNION 
SELECT x, 
       y 
FROM   functions 
WHERE  x = y 
GROUP  BY x, 
          y 
HAVING Count(x) > 1 
ORDER  BY x ASC

9.Given the CITY and COUNTRY tables, query the sum of the populations
of all cities where the CONTINENT is 'Asia'.Given the CITY and COUNTRY tables,
query the sum of the populations of all cities where the CONTINENT is 'Asia'.

SELECT SUM(C.POPULATION) FROM CITY AS C
JOIN COUNTRY AS CO ON CO.CODE = C.COUNTRYCODE
WHERE CO.CONTINENT = 'Asia';

10. Given the CITY and COUNTRY tables, query the names of all the continents
(COUNTRY.Continent) and their respective average city populations
(CITY.Population) rounded down to the nearest integer.

SELECT CO.CONTINENT, FLOOR(AVG(C.POPULATION)) FROM COUNTRY AS CO
JOIN CITY AS C ON C.COUNTRYCODE = CO.CODE
GROUP BY CO.CONTINENT 

11. Ketty gives Eve a task to generate a report containing three columns:
    Name, Grade and Mark. Ketty doesn not want the NAMES of those students
    who received a grade lower than 8. The report must be in descending order
    by grade -- i.e. higher grades are entered first. If there is more than one
    student with the same grade (8-10) assigned to them, order those particular
    students by their name alphabetically. Finally, if the grade is lower than
    8, use "NULL" as their name and list them by their grades in descending
    order. If there is more than one student with the same grade (1-7) assigned
    to them, order those particular students by their marks in ascending order.

SELECT IF(G.Grade<8, NULL, S.Name), G.Grade, S.Marks FROM Students AS S
JOIN Grades AS G ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark
ORDER BY G.Grade DESC, S.Name, S.Marks;

12.Write a query calculating the amount of error (i.e.:actual-miscalculated
average monthlysalaries), and round it up to the next integer.

SELECT CEILING(AVG(Salary)-AVG(REPLACE(SALARY,'0',''))) FROM EMPLOYEES

13.We define an employee's total earnings to be their monthly  worked, and
the maximum totalearnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total 
number of employees who have maximum total earnings. Then print these values as  space-
separated integers.

SELECT (months*salary) AS earnings, COUNT(*)
FROM Employee
GROUP BY earnings
ORDER BY earnings DESC
LIMIT 1;

14 Write a query identifying the type of each record in the TRIANGLES table using its 
three side lengths. Output one of the following statements for each record in the table:
Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.

SELECT 
CASE 
WHEN A+B <= C OR B+C <= A OR C+A <= B THEN 'Not A Triangle'
WHEN A=B AND B=C THEN 'Equilateral'
WHEN A=B OR B=C OR C=A THEN 'Isosceles'
ELSE 'Scalene' 
END
FROM TRIANGLES

15. lists the employees that have registered more than 10 orders

SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM (Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID)
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;

16.lists if the employees "Davolio" or "Fuller" have registered more than 25 orders
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;

17. Copies data from more than one table into a new table

SELECT Customers.CustomerName, Orders.OrderID
INTO CustomersOrderBackup2017
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
