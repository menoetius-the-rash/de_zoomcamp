-- SQL refresher

SELECT 
	*
FROM 	
	yellow_taxi_trips t,
	zones zpu,
	zones zdo
WHERE
	t."PULocationID" = zpu."LocationID" AND
	t."DOLocationID" = zdo."LocationID"
LIMIT 100;


--
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	CONCAT(zpu."Borough", '/', zpu."Zone") AS "pick_up_loc",
	CONCAT(zdo."Borough", '/', zpu."Zone") AS "dropoff_loc"
FROM 	
	yellow_taxi_trips t,
	zones zpu,
	zones zdo
WHERE
	t."PULocationID" = zpu."LocationID" AND
	t."DOLocationID" = zdo."LocationID"
LIMIT 100;

--

SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	CONCAT(zpu."Borough", '/', zpu."Zone") AS "pick_up_loc",
	CONCAT(zdo."Borough", '/', zpu."Zone") AS "dropoff_loc"
FROM 	
	yellow_taxi_trips t JOIN zones zpu
	ON t."PULocationID" = zpu."LocationID"
	JOIN zones zdo
	ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;

-- 

SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID" 
FROM 	
	yellow_taxi_trips t
WHERE
	"DOLocationID" NOT IN (
		SELECT "LocationID" 
		FROM zones)
LIMIT 100;

---

SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID" 
FROM 	
	yellow_taxi_trips t LEFT JOIN zones zpu
	ON t."PULocationID" = zpu."LocationID"
	JOIN zones
	ON
WHERE
	"PULocationID" NOT IN (
		SELECT "LocationID" 
		FROM zones)
LIMIT 100;

---

SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	DATE_TRUNC('DAY', tpep_dropoff_datetime),
	total_amount
FROM 	
	yellow_taxi_trips t
LIMIT 100;

---
SELECT 
	CAST(tpep_dropoff_datetime AS DATE) as "day",
	total_amount
FROM 	
	yellow_taxi_trips t
LIMIT 100;

--

SELECT 
	CAST(tpep_dropoff_datetime AS DATE) as "day",
	COUNT(1)
FROM 	
	yellow_taxi_trips t
GROUP BY
	CAST(tpep_dropoff_datetime AS DATE)
ORDER BY "day" ASC;

--

SELECT 
	CAST(tpep_dropoff_datetime AS DATE) as "day",
	COUNT(1) as "count",
	MAX(total_amount),
	MAX(passenger_count)
FROM 	
	yellow_taxi_trips t
GROUP BY
	CAST(tpep_dropoff_datetime AS DATE)
ORDER BY "day" ASC;

---

SELECT 
	CAST(tpep_dropoff_datetime AS DATE) as "day",
	"DOLocationID",
	COUNT(1) as "count",
	MAX(total_amount),
	MAX(passenger_count)
FROM 	
	yellow_taxi_trips t
GROUP BY
	1, 2
ORDER BY 
	"day" ASC,
	"DOLocationID" ASC;