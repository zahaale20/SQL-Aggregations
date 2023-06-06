-- Lab 5 - WINE
-- azaharia
-- May 24, 2023


-- Query 1
-- List all 2006 vintage wines from Napa (any appellation within the county) whose total revenue exceeds that of the 2006  'Appelation
-- Series' (There is a typo there. Let it be for now.)  Paso Robles Zinfandel from 'Rosenblum' winery. For each wine report grape, winery and name, score and revenue.  Sort by revenue in descending order

SELECT w.Grape, w.Winery, w.Name, w.Score, (w.Price * w.Cases * 12) AS Revenue -- calculate revenue (12 bottles a case)
FROM wine w, appellations a, wine w2
WHERE w.Appellation = a.Appellation
    AND w.Vintage = 2006 -- identify all 2006 wines from napa
    AND a.County = 'Napa'
    AND (w.Price * w.Cases) > (w2.Price * w2.Cases)
    AND w2.Vintage = 2006 -- identify all 2006 Paso Rebles Zinfandel from Resonblum
    AND w2. Grape = 'Zinfandel'
    AND w2.Appellation = 'Paso Robles'
    AND w2.Winery = 'Rosenblum'
ORDER BY Revenue DESC;

-- Query 2
-- Find the average score of a Sonoma Valley Zinfandel.

SELECT AVG(Score) -- calculate avg score
FROM wine w, appellations a
WHERE a.Appellation = 'Sonoma Valley' -- identify sonoma valley zinfandel wines to acquire score
  AND w.Grape = 'Zinfandel'
  AND w.Appellation = a.Appellation;

-- Query 3
-- Find the total revenue from all 2009 Sauvignon Blanc wines with a score of 89 or higher.

SELECT SUM(Price * Cases * 12) -- calculate revenue (12 bottles a case)
FROM wine
WHERE Vintage = 2009 -- identify the 2009 Sauvignon Blanc wines
  AND Grape = 'Sauvignon Blanc'
  AND Score >= 89; -- score >= 89

-- Query 4
-- Find the average number of cases of a Zinfandel produced from  grapes sourced from the Central Coast.

SELECT AVG(Cases) AS AverageCases
FROM wine w, appellations a
WHERE w.Grape = 'Zinfandel' -- identify zindandel from central coast
  AND a.Area = 'Central Coast'
  AND w.Appellation = a.Appellation;

-- Query 5
-- Report the overall number of different red wines produced in
-- Russian River Valley during the year when this AVA had a wine with a score of 98.

SELECT COUNT(*)
FROM wine w, appellations a, grapes g
WHERE a.Appellation = 'Russian River Valley'  -- from russian river valley
  AND w.Score = 98 -- score of 98
  AND g.Color = 'Red' -- red wine
  AND w.Appellation = a.Appellation;


