-- (i)  Find the total feeding time for all of the rare animals.
select sum(timetofeed) from animal where
    acategory = 'rare';

-- (ii) Which animal(s) have a `time to feed' larger than every rare animal? Give the id and name of the animal.
select aid, aname from animal where
    timetofeed > all (select timetofeed from animal where acategory = 'rare');
-- largest time to feed is 3.5 in rare category, there are no other animals with a feeding time greater than that

-- (iii)Name zookeepers handling at least 4 animals.
select zname, zookeepid from zookeeper, 
                -- returns zookeepid w largest handling count
                (select zookeepid, handlingcount from 
                    -- returns zookeepids and their handling count
                    (select zookeepid, count(zookeepid) as handlingcount from handles
                         group by zookeepid)
                    where handlingcount >= 4 )
    where zookeeper.zid = zookeepid;

-- (iv) Find the names of the animals that are not related to the bear.
select aname from animal 
    where aname not like '%bear%';

-- (v)  List zookeepers earning the most while feeding animals.
select zname from zookeeper
    where hourlyrate = (select max(hourlyrate) from zookeeper);