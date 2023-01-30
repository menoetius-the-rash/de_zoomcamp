/* Question 3. Count records
How many taxi trips were totally made on January 15?

Tip: started and finished on 2019-01-15.

Remember that lpep_pickup_datetime and lpep_dropoff_datetime columns are in the format timestamp (date and hour+min+sec) and not in date.

20689
20530
17630
21090*/

-- Answer is 20530
SELECT 
	CAST(lpep_dropoff_datetime AS DATE) as "DOday",
	CAST(lpep_pickup_datetime AS DATE) as "PUday",
	COUNT(1)
FROM 	
	green_taxi_trips t
WHERE
	CAST(lpep_dropoff_datetime AS DATE) = '2019-01-15' AND
	CAST(lpep_pickup_datetime AS DATE) = '2019-01-15'
GROUP BY
	"DOday", "PUday"
ORDER BY
	"DOday" ASC



/* Question 4. Largest trip for each day
Which was the day with the largest trip distance Use the pick up time for your calculations.

2019-01-18
2019-01-28
2019-01-15
2019-01-10 */

-- 2019-01-18 80.96
-- 2019-01-28 64.27
-- 2019-01-15 117.99
-- 2019-01-10 64.2

SELECT 
	CAST(lpep_pickup_datetime AS DATE) as "PUday",
	MAX(trip_distance)
FROM 
	green_taxi_trips
WHERE
	CAST(lpep_pickup_datetime AS DATE) IN ('2019-01-18', '2019-01-28', '2019-01-15', '2019-01-10')
GROUP BY
	CAST(lpep_pickup_datetime AS DATE) 
ORDER BY
	"PUday" ASC;

/* Question 5. The number of passengers
In 2019-01-01 how many trips had 2 and 3 passengers?

2: 1282 ; 3: 266
2: 1532 ; 3: 126
2: 1282 ; 3: 254
2: 1282 ; 3: 274 */

-- Passenger 2 = 1282
-- Passenger 3 = 254
SELECT 
	CAST(lpep_pickup_datetime AS DATE) as "PUday",
	COUNT(1)
FROM 
	green_taxi_trips
WHERE
	CAST(lpep_pickup_datetime AS DATE) = '2019-01-01' AND
	passenger_count IN (2)
GROUP BY
	"PUday"

SELECT 
	CAST(lpep_pickup_datetime AS DATE) as "PUday",
	COUNT(1)
FROM 
	green_taxi_trips
WHERE
	CAST(lpep_pickup_datetime AS DATE) = '2019-01-01' AND
	passenger_count IN (3)
GROUP BY
	"PUday"


/* Question 6. Largest tip
For the passengers picked up in the Astoria Zone which was the drop off zone that had the largest tip? We want the name of the zone, not the id.

Note: it's not a typo, it's tip , not trip

Central Park
Jamaica
South Ozone Park
Long Island City/Queens Plaza */

SELECT 
	MAX(gt.tip_amount),
	z1."Zone" AS "PUZone",
	z2."Zone" AS "DOZone"
FROM 
	green_taxi_trips gt
	LEFT JOIN zones z1
	ON z1."LocationID" = gt."PULocationID" 
	LEFT JOIN zones z2
	ON z2."LocationID" = gt."DOLocationID"
WHERE
	z1."Zone"= 'Astoria'
GROUP BY
	z1."Zone", z2."Zone"
ORDER BY
	MAX(gt.tip_amount) DESC
LIMIT 1;

