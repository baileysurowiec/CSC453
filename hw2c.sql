--[SQL-SingleTable]
-- [1pt] List car rental companies which have a mileage of at least 27 miles/gallon.
select rentalcompany from ByCar where mileage >= 27;

-- [1pt] List trip IDs taken on train costing strictly more than $150. 
select tid from trips where travelmode = 'Train' and fare >150;

-- [1pt] Find trip IDs and their fare that are not taken in the US i.e., `Non-US` trips.
select tid, fare from trips where tripstate = 'Non-US';

-- [2pt] Find the cheapest trip taken by each of air, rail, or car.
select min(fare) as fare from trips;

--[SQL-Join]
-- [1pt] Find the business class plane trip IDs that are greater than $1000. 
select trips.tid from trips, byplane
    where   trips.tid = byplane.tid
        and byplane.class = 'Business'
        and trips.fare > 1000;

-- [2pt] Find any car trip more expensive than a trip taken on a train in the same state or outside the country.
select * from trips trip 
    where travelmode = 'Car' -- car trip
        and fare > any -- fare for car > train fare
        (select fare from trips where travelmode ='Train' and tripstate = trip.tripstate);
 --https://www.tekstream.com/resource-center/ora-01427-error-message/
     
-- [2pt] List pairs of distinct car trips that have exactly the same value of mileage. 
-- Note a pair of distinct trips is of the format: (TID1, TID2).
-- This distinct pair is not the same as the pair (TID2, TID1)
select car1.tid as t1, car2.tid as t2, car1.mileage from bycar car1 --, trips t1, trips t2
    inner join bycar car2
    on car1.mileage = car2.mileage 
    and car1.tid < car2.tid;

-- [3pt] List pairs of distinct train trips that in which the speed of the first train trip is lower than the speed of the second train trip. 
select t1.tid, t2.tid from bytrain
t1 inner join bytrain t2 
        on t1.trainspeed < t2.trainspeed and t1.tid != t2.tid;

-- [3pt] Find those pair of trips which occur in the same state and with the same mode of travel.
--       List such pairs only once. In other words, given a pair (TID1,TID2) do NOT list (TID2,TID1).
select trip1.tid as tid1, trip1.tripstate as state1, trip1.travelmode as mode1, trip2.tid as tid2, trip2.tripstate as state2, trip2.travelmode as mode2
from trips trip1
inner join trips trip2
on trip1.tripstate = trip2.tripstate and trip1.travelmode = trip2.travelmode and trip1.tid < trip2.tid;

-- [4pt] Find a state in which trips have been taken by all three modes of transportation: train, plane, and car.
--          Note: Think 3-way self-joins with equality and non-equality join criteria.
select tripstate from trips
where travelmode = 'Car'
intersect
select tripstate from trips
where travelmode = 'Train'
intersect
select tripstate from trips
where travelmode = 'Plane';
-- https://www.geeksforgeeks.org/sql-intersect-clause/#:~:text=The%20INTERSECT%20clause%20in%20SQL,both%20of%20the%20SELECT%20statements.