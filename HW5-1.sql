/* 1. Use the Restaurants.sql file from HW2, which creates three tables Restaurant, Reviewer, and Rating. 
In this problem, we are concerned with the Restaurant table, which has a single attribute 'Address' of type 'varchar2(100)'. 
We would like address to be searchable.  So we would like to create another table Restaurant_Locations with the following attributes:
rID, name, street_address,  city, state, zipcode, cuisine
a. Create Restaurant_Locations table. Use the source dataset to determine the data types (and sizes) to use for each of the attributes.
b. Write a cursor (using SQL and PL/SQL) to process each row from the original Restaurant table, extracting information 
    as necessary to populate the new Restaurant_Locations table. 
The original address field must be split up and parsed into the new street_address, city, state, and zipcode fields.
*/

--drop table Restaurant_Locations;
Create table Restaurant_Locations(
	rID int, 
	street_address varchar2(100),
	city varchar2(100), 
	state varchar(3), 
	zipcode varchar2(5), 
	cuisine varchar2(100));

declare
 rid restaurant.rid%type;
 street_address restaurant.address%TYPE;
 city restaurant.address%TYPE;
 state restaurant.address%TYPE;
 zipcode restaurant.address%TYPE;
 cuisine restaurant.cuisine%TYPE;
 
 cursor rl is 
 select rid,
        REGEXP_SUBSTR(address, '(\d)*(\s)(\S*)(\s)(\S*)(\s)(\S*)'),
        -- remove comma
        rtrim(
            (REGEXP_SUBSTR (address, '[^ ]*,',1, 1)), ','),
        -- remove comma 
        ltrim(
            (REGEXP_SUBSTR (address, ', [^ ]*',1, 1)), ','), 
        -- get last 5 digits for zipcode
        substr(address, length(address)-4, 5), 
        cuisine
 from Restaurant;
 
 begin
 
 open rl;
 loop
 fetch rl
    into rid, street_address, city, state, zipcode, cuisine;
 exit when rl%NotFound;
 
 insert into Restaurant_Locations
    values(rid, street_address, city, state, zipcode, cuisine);
 
 end loop; 
 close rl;
 
 end;
 
 -- check table
 select * from restaurant_locations;

 --  https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/REGEXP_SUBSTR.html#GUID-2903904D-455F-4839-A8B2-1731EF4BD099
 -- https://www.sqlsplus.com/oracle-regexp_substr-function/