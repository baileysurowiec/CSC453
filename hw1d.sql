
-- employee table
-- "All managers are employees" manager number references employee number if employee is also a manager
create table Emps(
    empID number(9),
    ssNO number(9),
    employeName varchar(15),
    primary key(empID),
    foreign key(mgrID) REFERENCES Emps(empID);
);