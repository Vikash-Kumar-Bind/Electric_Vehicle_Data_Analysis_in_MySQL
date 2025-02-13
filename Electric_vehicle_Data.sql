create database MCT;
select * from electric_vehicle_population_data;

#(1).. Write a query to list all electric vehicles with their VIN (1-10), Make, and Model.
select `vin (1-10)`,make,model 
from electric_vehicle_population_data;

# (2).. Write a query to display all columns for electric vehicles with a Model Year of 2020 or later.
select * from electric_vehicle_population_data
where `Model Year`>=2020;

# (3).. Write a query to list electric vehicles manufactured by Tesla.
SELECT * FROM electric_vehicle_population_data 
WHERE Make = 'Tesla';

# (4).. Write a query to find all electric vehicles where the Model contains the word Leaf.
SELECT * FROM electric_vehicle_population_data 
WHERE Model LIKE '%Leaf%';

#(5).. Write a query to count the total number of electric vehicles in the dataset.
SELECT COUNT(*) AS TotalVehicles 
FROM electric_vehicle_population_data;

# (6).. Write a query to find the average Electric Range of all electric vehicles.
SELECT AVG(`Electric Range`) AS AverageRange 
FROM electric_vehicle_population_data;

# (7).. Write a query to list the top 5 electric vehicles with the highest Base MSRP, sorted in descending order.
SELECT * FROM electric_vehicle_population_data 
ORDER BY `Base MSRP` DESC LIMIT 5;

# (8).. Write a query to list all pairs of electric vehicles that have the same Make and Model Year. Include columns for VIN_1, VIN_2, Make, and Model Year.
SELECT EV1.`VIN (1-10)` AS VIN_1,
EV2.`VIN (1-10)` AS VIN_2, EV1.Make, EV1.`Model Year`
FROM electric_vehicle_population_data EV1
JOIN electric_vehicle_population_data EV2
ON EV1.Make = EV2.Make 
   AND EV1.`Model Year` = EV2.`Model Year` 
   AND EV1.`VIN (1-10)` < EV2.`VIN (1-10)`;


# (9).. Write a query to find the total number of electric vehicles for each Make. Display Make and the count of vehicles.
Select Make, COUNT(*) AS VehicleCount 
FROM electric_vehicle_population_data GROUP BY Make;

# (10).. Write a query using a CASE statement to categorize electric vehicles into three categories based on their Electric Range: Short Range for ranges less than 100 miles, Medium Range for ranges between 100 and 200 miles, and Long Range for ranges more than 200 miles.
SELECT `VIN (1-10)`, Make, Model, `Electric Range`,
       CASE 
           WHEN `Electric Range` < 100 THEN 'Short Range'
           WHEN `Electric Range` BETWEEN 100 AND 200 THEN 'Medium Range'
           ELSE 'Long Range'
       END AS RangeCategory
FROM electric_vehicle_population_data;

# (11).. Write a query to add a new column Model_Length to the electric vehicles table that calculates the length of each Model name.
ALTER TABLE electric_vehicle_population_data ADD Model_Length INT;

UPDATE electric_vehicle_population_data
SET Model_Length = LENGTH(Model);

# (12).. Write a query using an advanced function to find the electric vehicle with the highest Electric Range.
SELECT * FROM electric_vehicle_population_data 
ORDER BY `Electric Range` DESC LIMIT 1;

# (13).. Create a view named HighEndVehicles that includes electric vehicles with a Base MSRP of $50,000 or higher.

CREATE VIEW HighEndVehicles AS
SELECT * FROM electric_vehicle_population_data 
WHERE `Base MSRP` >= 50000;

# (14).. Write a query using a window function to rank electric vehicles based on their Base MSRP within each Model Year.
SELECT `VIN (1-10)`, Make, Model, `Model Year`, `Base MSRP`,
RANK() OVER (PARTITION BY `Model Year` ORDER BY `Base MSRP` DESC) AS Rank_1
FROM electric_vehicle_population_data;

# (15).. Write a query to calculate the cumulative count of electric vehicles registered each year sorted by Model Year.
SELECT `Model Year`, COUNT(*) AS VehiclesRegistered,
       SUM(COUNT(*)) OVER (ORDER BY `Model Year`) AS CumulativeCount
FROM electric_vehicle_population_data
GROUP BY `Model Year`
ORDER BY `Model Year`;



# (16).. Write a stored procedure to update the Base MSRP of a vehicle given its VIN (1-10) and new Base MSRP.
DELIMITER $$

CREATE PROCEDURE UpdateBaseMSRP(
    IN VehicleVIN VARCHAR(10),
    IN NewBaseMSRP DECIMAL(10, 2)
)
BEGIN
    UPDATE electric_vehicle_population_data
    SET `Base MSRP` = NewBaseMSRP
    WHERE `VIN (1-10)` = VehicleVIN;
END$$
DELIMITER ;



# (17).. Write a query to find the county with the highest average Base MSRP for electric vehicles. Use subqueries and aggregate functions to achieve this.
SELECT County, AVG(`Base MSRP`) AS AverageMSRP
FROM electric_vehicle_population_data
GROUP BY County
ORDER BY AverageMSRP DESC
LIMIT 1;

# (18).. Write a query to find pairs of electric vehicles from the same City where one vehicle has a longer Electric Range than the other. Display columns for VIN_1, Range_1, VIN_2, and Range_2.
SELECT EV1.`VIN (1-10)` AS VIN_1, EV1.`Electric Range` AS Range_1, EV2.`VIN (1-10)` AS VIN_2, EV2.`Electric Range` AS Range_2
FROM electric_vehicle_population_data EV1
JOIN electric_vehicle_population_data EV2
ON EV1.City = EV2.City
   AND EV1.`Electric Range` > EV2.`Electric Range`;












