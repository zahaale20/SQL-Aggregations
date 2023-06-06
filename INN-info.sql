-- Lab 5 - INN
-- azaharia
-- May 24, 2023


-- Query 1
-- Find all rooms that were occupied on all three of the following 
-- dates:  February 16, 2010, July 12, 2010 and  October 20, 2010. Report just the full name of the room and the room code. Sort output in alphabetical order by room name.

select DISTINCT rm.RoomCode, rm.RoomName
from rooms rm, reservations rs1, reservations rs2, reservations rs3
where rm.RoomCode = rs1.Room
    and rm.RoomCode = rs2.Room
    and rm.RoomCode = rs3.Room
    and (rs1.CheckIn <= '2010-02-16' and rs1.CheckOut >= '2010-02-16') -- identify all dates 
    and (rs2.CheckIn <= '2010-07-12' and rs2.CheckOut >= '2010-07-12')
    and (rs3.CheckIn <= '2010-10-20' and rs3.CheckOut >= '2010-10-20')
order by rm.RoomName;

-- Query 2
-- Find the total number of seven-night stays in rooms with modern decor.

SELECT COUNT(*) AS total_seven_night_stays
FROM reservations rs, rooms rm
WHERE rm.decor = 'modern' -- modern decor
    AND rm.RoomCode = rs.Room 
    AND DATEDIFF(rs.CheckOut, rs.CheckIn) = 7; -- seven night stay

-- Query 3
-- Find the number of  August reservations (both check-in and checkout dates are in August) where two adults are staying with  two children. 

SELECT COUNT(*)
FROM reservations
WHERE MONTH(CheckIn) = 8 -- identify august numerically
  AND MONTH(CheckOut) = 8
  AND Adults = 2 -- 2 adults and 2 kids
  AND Kids = 2;

-- Query 4
-- Find the average number of nights of stay in the 'Interim but salutary' room for all reservations that commenced May 1, 2010 or later and ended before August 31, 2010.

SELECT AVG(DATEDIFF(rs.CheckOut, rs.CheckIn))
FROM reservations rs, rooms rm
WHERE rm.Roomname = 'Interim but salutary' -- ibs room
    AND rm.RoomCode = rs.Room
    AND rs.CheckIn >= '2010-05-01' -- check in for May 1st and August 31
    AND rs.CheckOut < '2010-08-31';

-- Query 5
-- Find how many different durations of stay for trips that commenced and ended in July of 2010 were in 'Interim but salutary' room.

SELECT COUNT(DISTINCT DATEDIFF(CheckOut, CheckIn))
FROM reservations rs, rooms rm
WHERE rm.Roomname = 'Interim but salutary' -- ibs room
    AND rm.RoomCode = rs.Room
  AND YEAR(rs.CheckIn) = 2010 -- check in/out for July of 2010
  AND MONTH(rs.CheckIn) = 7
  AND YEAR(rs.CheckOut) = 2010
  AND MONTH(rs.CheckOut) = 7;


