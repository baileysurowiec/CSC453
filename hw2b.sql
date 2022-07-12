--[1pt] Find the name of all restaurants offering Indian cuisine
select name from restaurant where cuisine = 'Indian';
--[2pt] Find restaurants which have a 'street' in their address.
select name from restaurant where address like '%St%';

--[SQL-Join]
--[2pt] Find restaurant names that received a rating of 4 or 5, sort them in increasing order of rating.
select name from restaurant, rating where restaurant.rid = rating.rid and (stars = 4 or stars = 5)
order by rating.stars;

--[2pt] Find the names of all restaurants that have no rating.
select name from restaurant where rid not in (select rid from rating);

--[2pt] Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
    --Note: Checking for NULL is performed with "<attribute_name> IS NULL" condition and not  "<attribute_name> = NULL"
select name from reviewer, rating where reviewer.vid = rating.vid and rating.ratingdate is null;

--[3pt] For all cases where the same reviewer rated the same restaurant more than once and gave it a higher rating the second time, 
--      return the reviewer's name and the name of the restaurant.
select distinct reviewer.name, restaurant.name from reviewer, restaurant, rating, rating no2
    where   restaurant.rid = rating.rid -- same restaurant
        and reviewer.vid = rating.vid   -- same reviewer
        and restaurant.rid = no2.rid     -- check 2nd = same resaurant
        and no2.vid = rating.vid         -- check 2nd = same reviewer
            -- higher 2nd review
        and rating.stars < no2.stars
        and rating.ratingdate < no2.ratingdate;

--[3pt] Find reviewers with no ratings.
select name from reviewer where vid not in (select vid from rating);