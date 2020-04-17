
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
