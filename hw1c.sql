-- cars table
CREATE TABLE Cars(
CarID number(5) primary key,
VIN number(10) UNIQUE,
Color char(15),
YearofMake number(4),
Model_id number(5),
foreign key model_id references Models(model_id)
);

-- model table
CREATE TABLE Models(
model_id number(5) primary key,
modelBrand varchar(15),
modelName varchar(15)
);

INSERT INTO Cars VALUES (123, 3456783412, 'Red', 2010, 1);
INSERT INTO Cars VALUES (234, 2876309034, 'Blue', 2003, 2);

--INSERT INTO Cars VALUES (235, 3456783412, 'Silver', 2010, 1);
-- i. don't think I'm getting the intended error for this insert statement but looking at it and the cars table
        --the VIN number is defined as unique so you can't add another with the same number

-- DELETE FROM Model;
-- ii. the table was already created so a delete statement wouldn't work correctly without an alter statement first
-- iii.
-- https://www.w3schools.com/sql/sql_alter.asp

ALTER Table Cars

DELETE FROM Model;