/*
1. The first trigger, named NewContract, will fire when a user attempts to INSERT a row into CONTRACT.
This trigger will check the value of ContractCount for the corresponding task.
If ContractCount is less than 3, then there is still room in the task for another worker, so it will allow the 
INSERT to occur and will increase the value of ContractCount by one.
If ContractCount is equal to 3, then the task is full, so it will cancel the 
INSERT and display an error message stating that the task is full.
*/

create or replace trigger newContract 
before insert on contract -- fire before a user attempts to insert into contract
for each row -- row-level

declare
acontractCount task.contractcount%TYPE;

begin
    select contractcount into acontractcount from task
        where taskid = :new.taskid;
        
        if acontractCount = 3 then -- no more room
            raise_application_error (-20888, 'Error: the task is full');         
        else
        -- allow insert and increase val of contractcount
            update task
            set contractcount = contractcount +1
            where taskid = :new.taskid;
        end if;
end;
/


/*  
2. The second trigger, named EndContract, will fire when a user attempts to DELETE one or more rows from CONTRACT. 
This trigger will update the values of ContractCount for any affected tasks to make sure they are accurate after the rows are deleted, 
by decreasing the value of ContractCount by one each time a worker is removed from a task.
*/

create or replace trigger EndContract
after delete on contract -- fire when a user attempts to DELETE one or more rows from CONTRACT

for each row -- row-level

begin
    -- update val of contractcount for affected tasks
    update task
    set contractcount = contractcount -1
    where taskid = :old.taskid;
end;
/

 /* 3. The third trigger, named NoChanges, will fire when a user attempts to UPDATE one or more rows of CONTRACT.
The trigger will cancel the UPDATE and display an error message stating that no updates are permitted to existing rows of CONTRACT.
*/

create or replace trigger NoChanges
before update on contract

begin
    raise_application_error (-20889, 'Error: no updates are permitted to existing rows of CONTRACT');         
end;
/


-- test newContract trigger
insert into contract values (333, 2123457, 175);
insert into contract values (322, 2123457, 175);

-- test endContract trigger
delete from contract where taskid = 333;
delete from contract where taskid = 896;

-- test noChanges trigger
update contract set payment = 700 where taskid = 333;