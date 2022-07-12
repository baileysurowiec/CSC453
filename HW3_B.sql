--Part B
--1. [5pt] For each restaurant that has at least one rating, find the highest number of stars that a restaurant received.
--          Return the restaurant name and number of stars. Sort by restaurant name.
select name, max(stars) from restaurant, rating
where restaurant.rid = rating.rid
group by name
order by name;

--2. [5pt] For each restaurant, return the name and the 'rating spread', that is,
--          the difference between highest and lowest ratings given to that restaurant.
--          Sort by rating spread from highest to lowest, then by restaurant name.
select name, (max(stars)-min(stars)) as ratingSpread from restaurant, rating
where restaurant.rid = rating.rid
group by name
order by ratingSpread desc, name;

--3. [5pt] Find the difference between the average rating of Indian restaurants and the average rating of Chinese restaurants.
--          (Make sure to calculate the average rating for each restaurant, then the average of those averages for Indian and Chinese restaurants.
--          Don't just calculate the overall average rating for Indian and Chinese restaurants.) Note: The difference can be negative.
select distinct(
    (select avg(rt1.stars) from rating rt1, restaurant r1
        where 
            r1.rid = rt1.rid
        and
            r1.cuisine = 'Indian')   
-
    (select avg(rt2.stars) from rating rt2, restaurant r2
        where 
            r2.cuisine = 'Chinese'
        and 
            r2.rid = rt2.rid)
) as averagediff from restaurant r, rating rt;



--4. [5pt] Are there reviewers who reviewed both Indian and Chinese restaurants? Write a query and answer Yes/No.

select reviewer.vid, reviewer.name from reviewer, rating, restaurant
    where
        reviewer.vid = rating.vid
    and
        rating.rid = restaurant.rid
    and
        restaurant.cuisine = 'Indian'
        
intersect

select reviewer.vid, reviewer.name from reviewer, rating, restaurant
    where
        reviewer.vid = rating.vid
    and
        rating.rid = restaurant.rid
    and
        restaurant.cuisine = 'Chinese';

