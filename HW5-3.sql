/*
The restaurants in the database continue to be visited and reviewed.
Information about new restaurant reviews is made available as:
(RestaurantName, UserName, Rating, RatingDate)
Restaurant names and user names are assumed to be unique. 
Write a PL/SQL stored procedure that accepts the above input string and inserts new restaurant rating information into the Rating table.
If a new user appears, it inserts into the Reviewer table.
task */
create or replace procedure newReviews(RestaurantName in Restaurant.name%TYPE, UserName in Reviewer.name%TYPE, Rating in Rating.stars%TYPE, ratingDate in varchar2)
as
restaurantrid Restaurant.rID%TYPE;
aReviewer Reviewer.vID%TYPE;
reviewercount int := 0;
  
begin
--find restaurant
select rid into restaurantrid from Restaurant 
    where name = RestaurantName;

--check for reviewer
   select count(name) into reviewercount from Reviewer where name = UserName;
   if reviewercount = 0 then
       -- add new reviewer and increase vid number
       insert into Reviewer values ( (select max(vID) + 1 from Reviewer), UserName );
   else
   -- find current reviewer
    select vid into aReviewer from reviewer
        where name = UserName;
   end if;
   
   -- add rating
   insert into Rating values( restaurantrid, aReviewer, rating, to_date(ratingDate, 'MM/DD/YYYY') );
  
exception
  when NO_DATA_FOUND then
       dbms_output.put_line('No data in selected variable');
  
   when others then
    dbms_output.put_line('data in selected variable');
end;
/

/* Bonus(+5/+10): Create a table ‘Top5Restaurants’ restaurants in the database as:
Create table Top5Restaurants(rID int)
Top5Restaurants holds the rIDs of top 5 restaurants in Chicago. 
Write a statement (+5) or row-level trigger(+10) on the Rating table that computes top 5 restaurants and populates the Top5Restaurants table. 
This trigger is fired every time a restaurant receives a new rating. 
Test your procedure and trigger in SQL Developer to insert the following four strings:
(‘Jade Court’,`Sarah M.’, 4, ‘08/17/2017’)
(‘Shanghai Terrace’,`Cameron J.’, 5, ‘08/17/2017’)
(‘Rangoli’,`Vivek T.’,3,`09/17/2017’)
(‘Shanghai Inn’,`Audrey M.’,2,`07/08/2017’);
(‘Cumin’,`Cameron J.’, 2, ‘09/17/2017’)*/

Create table Top5Restaurants(rID int)

create or replace trigger top5trigger
after insert on rating -- new restaurant ratings need to be in table already

begin
    delete from top5restaurants; -- clear table
    -- update table
    insert into top5restaurants select rid from 
        (select * from 
        -- restaurants have multiple reviews, get avg so no dupes in top 5 list
           (select rid, sum(stars)/count(stars) as avg from rating
                group by rid
                order by rid)
        order by avg desc )
        
        where rownum < 6; -- only need top 5
end;
/

begin
newReviews('Jade Court', 'Sarah M.', 4, '08/17/2017');
newReviews('Shanghai Terrace', 'Cameron J.', 5, '08/17/2017');
newReviews('Rangoli', 'Vivek T.', 3, '09/17/2017');
newReviews('Shanghai Inn', 'Audrey M.', 2, '07/08/2017');
newReviews('Cumin', 'Cameron J.', 2, '09/17/2017');
end;
/ 

select * from rating;
select * from top5restaurants;


-- https://www.w3schools.com/sql/sql_stored_procedures.asp
-- https://www.tekstream.com/resource-center/ora-01403-no-data-found/