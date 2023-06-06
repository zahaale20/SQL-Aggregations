-- Lab 5 - STUDENTS
-- azaharia
-- May 24, 2023


-- Query 1
-- Find all pairs of students with the same first name. Report each pair of students
-- exactly once. Report first and last names of each of the two students, and their grades.


SELECT DISTINCT s1.FirstName, s1.LastName, s1.Grade, s2.FirstName, s2.LastName, s2.Grade
FROM list s1, list s2
WHERE s1.FirstName = s2.FirstName  -- first names match
    AND s1.LastName < s2.LastName
ORDER BY s1.LastName, s2.LastName;


-- Query 2
--  Find all fourth-grade students who are NOT taught by GORDON KAWA. Report
-- their first and last names in alphabetical order by last name.


SELECT DISTINCT l.firstname, l.lastname
FROM list l, teachers t
WHERE l.Grade = '4' -- identify 4th grade students not in gordon kawa class
    AND t.Last != 'KAWA'
    AND t.first != 'GORDON'
ORDER BY l.LastName;


USE `STUDENTS`;
-- Query 3
-- Report the total number of  first graders and second graders in the school.
SELECT 1 AS Grade, COUNT(*) AS 'Number of Students'
FROM list
WHERE Grade = '1' -- num first graders
UNION
SELECT 2 As Grade, COUNT(*)
FROM list
WHERE Grade = '2' -- num second graders;


USE `STUDENTS`;
-- Query 4
--  Find the number of classmates of ELTON FULVIO (excluding Elton himself).
SELECT COUNT(*)
FROM list l1, list l2
WHERE l1.FirstName = "ELTON" -- identify elton fulvio
    AND l1.LastName = "FULVIO"
    AND l1.classroom = l2.classroom; -- and those in his classroom
    AND l2.FirstName != l1.FirstName  -- that arent him
    AND l2.LastName  != l1.LastName


