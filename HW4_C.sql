-- 1. People to whom Brad can reach to either directly or transitively.
with bradsfriends(people, friend, path) as(
    (select people, friend, people || '.' || friend from socialnetwork)
union all
    (select s.people, bf.friend, s.people || '.' || path
    from socialnetwork s, bradsfriends bf
    where   s.friend = bf.people 
    and     path not LIKE '%' || s.people || '%')
)
select unique friend, path from bradsfriends where path like  '%' || 'Brad' || '%';

-- 2. People in DePauledIN network to whom Brad cannot reach to.
with notbradsfriends(people, friend, path) as(
-- get brads friends
    (select people, friend, people || '.' || friend from socialnetwork)
union all
    (select s.people, bf.friend, s.people || '.' || path
    from socialnetwork s, notbradsfriends bf
    where   s.friend = bf.people 
    and     path not LIKE '%' || s.people || '%')
)
select * from notbradsfriends where path not like  '%' || notbradsfriends.friend || '%';

-- 3. Only those people who are connected to Christine via transitive relationship i.e not an immediate follower.
with christinesfof(people, friend, path) as(
    (select people, friend, people || '.' || friend from socialnetwork)-- where people = 'Christine')
union all
    (select s.people, cf.friend, s.people || '.' || path
    from socialnetwork s, christinesfof cf
    where   s.friend = cf.people 
    and     path not LIKE '%' || s.people || '%')
)
select * from christinesfof where people = 'Christine' and friend not in (select friend from socialnetwork where people = 'Christine');

-- 4. Find the shortest path to reach from Amy to James.
with a2j(people, friend, path) as(
    (select people, friend, people || '.' || friend from socialnetwork)
union all
    (select s.people, aj.friend, s.people || '.' || path
    from socialnetwork s, a2j aj
    where   s.friend = aj.people 
    --and     s.people = 'Christine'
    and     path not LIKE '%' || s.people || '%')
)
select * from a2j
    where   people = 'Amy'
    and     friend = 'James'
    and     length(path) = (select min(length(path)) from a2j where people = 'Amy' and friend = 'James')