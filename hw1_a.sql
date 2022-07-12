-- drop Table Customers;
Create Table Customers(
    CustomerID number(3),
    CustomerName number(25),
    CustomerAddress varchar(50),
    primary key (CustomerID) -- unique identifier
);

-- drop Table Orders;
Create Table Orders(
    OrderID number(5),
    OrderDate not null,
    CustomerID number(3),
    primary key (OrderID), -- unique identifier
    foreign key (CustomerID) references Customers(CustomerID)
);

-- drop Table Products;
Create Table Products(
    ProductID number(2),
    Description varchar(28),
    Finish varchar(10),
    Price float,
    CONSTRAINT priceCheck CHECK (Price >= 0 and Price <= 899.99),
    primary key (ProductID) -- unique identifier
);

-- drop Table Requests;
Create Table Requests(
    OrderID number(5),
    ProductID number(2),
    Quantity integer,
    CONSTRAINT quantityCheck CHECK (Quantity >=1 and Quantity <= 50),
    primary key (OrderID, ProductID) -- the pair are the unique identifiers
);

insert into Customers values (2, 'CASUAL FURNITURE', 'PLANO, TX');
insert into Customers values (6, 'MOUNTAIN GALLERY', 'BOULDER, CO');
  
insert into Orders values (1006, '24-MAR-10', 2);
insert into Orders values (1007, '25-MAR-10', 6);
insert into Orders values (1008, '25-MAR-10', 6);
insert into Orders values (1009, '26-MAR-10', 2);
  
insert into Products values (10, 'WRITING DESK', 'OAK', 425);
insert into Products values (30, 'DINING TABLE', 'ASH', NULL);
insert into Products values (40, 'ENTERTAINMENT CENTER', 'MAPLE', 650);
insert into Products values (70, 'CHILDRENS DRESSER', 'PINE', 300);
  
insert into Requests values (1006, 10, 4);
insert into Requests values (1006, 30, 2);
insert into Requests values (1006, 40, 1);
insert into Requests values (1007, 40, 3);
insert into Requests values (1007, 70, 2);
insert into Requests values (1008, 70, 1);
insert into Requests values (1009, 10, 2);
insert into Requests values (1009, 40, 1);

select * from Customers;
select * from Orders;
select * from Products;
select * from Requests;

drop Table Customers;
drop Table Orders;
drop Table Products;
drop Table Requests;

-- info on SQL from w3schools was helpful in simplifying the explanations of syntax and uses
-- https://www.w3schools.com/sql/sql_check.asp
-- used mycomplier.io/new/sql to check for syntax errors