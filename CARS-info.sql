-- Lab5 - CARS
-- azaharia
-- May 24, 2023

-- Query 1
-- Find all cars made after 1980 with gas mileage better than the 1982 honda civic. 
-- Report full name of the car, year it was made and the name of the manufacturer. Sort output in descending order by gas mileage.

select m2.Make, cd2.Year, cm.Maker
from makes m, cardata cd, makes m2, cardata cd2, models mo, carmakers cm
where m.Make = 'honda civic' -- identify 1982 honda civics
    AND cd.Year = 1982
    AND m.Id = cd.Id
    
    AND cd2.Year > 1980 -- identify cars made after 1980
    
    AND cd2.MPG > cd.MPG -- compare mpg
    AND m2.Id = cd2.Id
    
    AND m2.Model = mo.Model
    AND mo.Maker = cm.Id
order by cd2.MPG DESC;


-- Query 2
--  Find the average, maximum and minimum horsepower for 4-cylinder
-- vehicles manufactured by French automakers between 1971 and 1976 inclusively.

select AVG(cd.Horsepower), MAX(cd.Horsepower), MIN(cd.Horsepower) 
from countries co, carmakers cm, models mo, makes ma, cardata cd
where co.Name = 'france' -- identify country of france
    and co.Id = cm.Country -- connection
    and cm.Id = mo.Maker -- connection
    and mo.Model = ma.Model -- connection
    and ma.Id = cd.Id -- connection
    and cd.Cylinders = 4 -- make sure it has 4 cylinders
    and (cd.Year >= 1971 and cd.Year <= 1976) -- between 1971 and 1976;


-- Query 3
-- Find how many cars produced in 1971 had better acceleration than a 1972
-- volvo 145e (sw). Report just the number.

select COUNT(*)
from makes ma, cardata cd, makes ma2, cardata cd2
where ma.Make = 'volvo 145e (sw)' -- Identify volvo 145e made in 1972
    and ma.Id = cd.Id
    and cd.Year = 1972
    
    and cd2.Year = 1971 -- identify all cars made in 1971
    
    and cd2.Accelerate > cd.Accelerate -- compare accelerations of volvo and 1971 cars
    and ma2.Id = cd2.Id;


-- Query 4
--  Find how many different car manufacturers produced a vehicle heavier
-- than 5000 lbs.

select COUNT(*) -- count them
from cardata cd, makes ma, models mo, carmakers cm
where cd.Weight > 5000 -- identify cars that weigh over 5000 lbs
    and cd.Id = ma.Id
    and mo.Model = ma.Model
    and mo.Maker = cm.Id;


