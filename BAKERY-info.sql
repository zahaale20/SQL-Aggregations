-- Lab 5 - BAKERY
-- azaharia
-- May 24, 2023


-- Query 1
--  Find all customers who purchased, during the same trip to the bakery,
-- two different (i.e., different flavor)  Cookies, one of which is Tuile. Report the date of the purchase, and the first and last names of the customers in chronological order.

SELECT r.SaleDate, c.FirstName, c.LastName
FROM goods g, items i, receipts r, customers c, goods g2, items i2, receipts r2
WHERE g.Food = 'Cookie' -- identify tuile (flavor) cookies(food)
  AND g.Flavor = 'Tuile'
  AND i.Item = g.GId
  AND r.RNumber = i.Receipt
  AND r.Customer = c.CId
  
  AND g2.Food = 'Cookie' -- find all cookies that arent tuile
  AND g2.Flavor <> 'Tuile'
  AND g2.FLavor <> g.Flavor
  AND i2.Item = g2.GId
  AND r2.RNumber = i2.Receipt
  AND r2.Customer = c.CId
  
  AND r.RNumber = r2.RNumber  -- compare receipts and sale date
  AND r.SaleDate = r2.SaleDate
ORDER BY r.SaleDate;

-- Query 2
--  Find all days on which either ASHARRON TOUSSAND made
-- a purchase that contained five items, or someone purchased a Gongolais Cookie. Sort dates in chronological order. Each date shall appear exactly once.

SELECT r.SaleDate -- count all dates she has 5 items
FROM customers c, receipts r, items i, goods g
WHERE c.FirstName = 'SHARRON'  -- identify sharron toussand
    AND c.LastName = 'TOUSSAND'
    AND c.CId = r.Customer -- her id
    AND r.RNumber = i.Receipt -- her receipts
    AND i.Item = g.GId -- items
GROUP BY r.SaleDate 
HAVING COUNT(*) = 5

UNION 

SELECT r2.SaleDate
FROM receipts r2, items i2, goods g2
WHERE r2.RNumber = i2.Receipt -- and in the receipts
    AND i2.Item = g2.GId -- get it in items
    AND g2.Food = 'Cookie' -- identify gongolais cookie in goods
    AND g2.Flavor = 'Gongolais'

ORDER BY SaleDate;

-- Query 3
--  Report the total amount of money  JULIET LOGAN  spent at the bakery
-- during the first ten days of the month of October, 2007.

SELECT SUM(g.Price) AS TotalAmountSpent --sum representing amoount spent by juliet logan
FROM customers c, receipts r, items i, goods g
WHERE c.FirstName = 'JULIET' -- identify juliet logan
  AND c.LastName = 'LOGAN'
  AND c.CId = r.Customer -- her id,
  AND r.RNumber = i.Receipt -- receipts,
  AND i.Item = g.GId -- and items
  AND r.SaleDate >= '2007-10-01' -- in the first ten days of october
  AND r.SaleDate <= '2007-10-10';

-- Query 4
--  Report the total number of purchases (i.e., unique receipts)  that included a cake.

SELECT COUNT(DISTINCT r.RNumber) -- total number of purchases... r.RNumber is distinct bc there can be multiple cakes in a purchase
FROM goods g, items i, receipts r
WHERE g.Food = 'Cake' -- cakes
    AND g.GId = i.Item
    AND i.Receipt = r.RNumber;

-- Query 5
-- Report the total number of  cakes  bought in the bakery during the month of October of 2007.
SELECT COUNT(*) -- count instances
FROM goods g, items i, receipts r
WHERE r.SaleDate >= '2007-10-01' -- identify october 2007
    AND r.SaleDate < '2007-11-01'
    AND r.RNumber = i.Receipt
    AND i.Item = g.GId
    AND g.Food = 'Cake'; -- where cake was bought


