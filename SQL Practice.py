
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
