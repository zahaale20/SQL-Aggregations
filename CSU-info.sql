-- Lab 5 - CSU
-- azaharia
-- May 24, 2023


-- Query 1
-- Report the average  of degrees granted  by California Polytechnic State University-San Luis Obispo in the period between 1995 and 2000 (inclusively).

SELECT AVG(d.degrees)
FROM degrees d, campuses c
WHERE d.year >= 1995 AND d.year <= 2000 -- between 1995 and 2000
    AND d.CampusId = c.Id
    AND c.Campus = 'California Polytechnic State University-San Luis Obispo'; -- identify cal poly slo

-- Query 2
-- Find the largest, the smallest and the average fee on a CSU campus in  2002.

SELECT MIN(f.fee), AVG(f.fee), MAX(f.fee) -- calculate min, avg, and max
FROM campuses c, fees f
WHERE c.Id = f.CampusId
AND f.Year = 2002; -- identify year, 2002

-- Query 3
-- Report the average student to faculty (use student FTE to faculty FTE ratio) ratio in 2004 among the campuses where 2004 enrollment (FTE numbers) was greater than 15000.

select AVG(e.FTE/f.FTE) -- calculate avg of all (e.FTE/f.FTE)
from faculty f, enrollments e, campuses c
where f.CampusId = c.Id
    AND e.CampusId = c.Id
    AND e.Year = 2004 -- students enrolled in 2004
    AND e.FTE > 15000 -- FTE > 15000;

-- Query 4
--  Report all years in which either there were more than 17000 students (NOT FTEs) on California Polytechnic State University-San Luis Obispo campus, or California Polytechnic State University-San Luis Obispo graduated (gave degrees) to more than 3500 students. Report years in chronological order, with each year reported once.

SELECT DISTINCT e.Year
FROM campuses c, enrollments e, degrees d
WHERE c.Campus = 'California Polytechnic State University-San Luis Obispo' 
    AND (e.Enrolled > 17000 OR d.degrees > 3500) -- ANSWER IS MORE SIMILAR TO EXPECTED RESULT 
    AND c.Id = e.CampusId                        -- WHEN 'OR' IS REPLACED WITH 'AND'
    AND c.Id = d.CampusId                        -- however, the problem uses 'or' in its wording
ORDER BY e.Year;


