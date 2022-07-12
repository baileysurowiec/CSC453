Create Table Location (
       latitude float, 
       longitude float,
       name varchar(50),

       primary key(latitude, longitude) 
    -- i. latitude & longitude give specific location value so this would be an appropriate primary key as opposed to the name
);

-- ii.
insert into Location
    values(41.881832, -87.623177, 'Chicago');
insert into Location
    values(42.881832, -87.623177,'Chicago');
insert into Location
    values(41.881832, -86.623177,'Chicago');
    
-- iii. no because the primary key is the latitude, longitude pair which are all unique and it is not null