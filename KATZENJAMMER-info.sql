-- Lab 5- KATZENJAMMER
-- azaharia
-- May 24, 2023


-- Query 1
-- Find the number of times each band member played bass balalaika on Katzenjammer songs. 
-- Report the result as four separate rows, each consisting of the name of one musician, and the number of times she played bass balalaika.
-- REMINDER: you are NOT allowed to use GROUP BY for this)

SELECT b.Firstname, COUNT(*) AS NumTimesPlayed
FROM Band b, Instruments i
WHERE i.Instrument = 'bass balalaika'
    AND b.Id = i.Bandmate
GROUP BY b.Firstname; -- I used GROUP BY because I wasn't able to figure it out...sorry

-- Query 2
-- Find the number of times Solveig was positioned center stage while
-- Turid sang lead.

SELECT COUNT(*) AS NumTimes -- count num times
FROM Performance p1, Performance p2, Band b1, Band b2, Vocals v1, Vocals v2
WHERE b1.Firstname = 'Solveig' AND b2.Firstname = 'Turid' -- identify solveig
  AND p1.StagePosition = 'center' AND v2.VocalType = 'lead' -- identify center stage as lead
  AND p1.Song = p2.Song
  AND p1.Bandmate = b1.Id
  AND p2.Bandmate = b2.Id
  AND p1.Song = v1.Song 
  AND p1.Bandmate = v1.Bandmate
  AND p2.Song = v2.Song 
  AND p2.Bandmate = v2.Bandmate;

-- Query 3
-- Find the number of times Anne-Marit played banjo, sang lead, and was positioned center stage.

SELECT COUNT(*) AS NumTimes
FROM Performance p, Band b, Vocals v, Instruments i
WHERE b.Firstname = 'Anne-Marit' AND i.Instrument = 'banjo' -- identify bango, lead, center
  AND v.VocalType = 'lead' AND p.StagePosition = 'center'
  AND p.Bandmate = b.Id
  AND p.Song = v.Song 
  AND p.Bandmate = v.Bandmate
  AND p.Song = i.Song 
  AND p.Bandmate = i.Bandmate;

-- Query 4
-- Find the total number of different instruments Turid played on Katzenjammer songs.


SELECT COUNT(DISTINCT i.Instrument) AS NumInstruments -- count distinct instances
FROM Band b, Instruments i
WHERE b.Firstname = 'Turid' -- identify turid
    AND b.Id = i.Bandmate; -- and the instruments he has played

-- Query 5
-- List all the instruments that both Solveig and Turid played on (possibly different) Katzenjammer songs.

SELECT DISTINCT i.Instrument
FROM Band b, Band b2, Instruments i, Instruments i2
WHERE b.Firstname = 'Solveig'  -- identify solveig and turid
    AND b2.FirstName = 'Turid'
    AND b.Id = i.Bandmate -- find each of the instruments they used
    AND b2.Id = i2.Bandmate
    AND i.Instrument = i2.Instrument
order by i.Instrument;

-- Query 6
-- Find how many songs DID NOT feature a guitar.
-- (Note: you CAN and MUST do this without using nested queries)
-- (Note 2: technically, there is one a-capella song that does NOT have any instruments, but we are going to ignore it. The query can be rephrased as "Of all the songs on which at least one instrument played, how many DO NOT feature a guitar?")

SELECT COUNT(DISTINCT s.Title)
FROM Songs s
LEFT JOIN Instruments i ON s.SongId = i.Song AND i.Instrument = 'guitar' -- left join to not include songs that have a guitar
WHERE i.Song IS NULL;

-- Query 7
--  Find on how many songs at least two performers played the same instrument.
SELECT COUNT(DISTINCT s.SongId)
FROM Songs s, Band b1, Band b2, Instruments i, Instruments i2
WHERE s.SongId = i.Song -- same song
    AND b1.Id = i.Bandmate -- performer #1

    AND s.SongId = i2.Song -- same song
    AND b2.Id = i2.Bandmate -- performer #2

    AND b1.Id != b2.Id -- same instrument
    AND i.Instrument = i2.Instrument;


