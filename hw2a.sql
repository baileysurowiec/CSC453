/* Lets say we have two relations of the form:
R(A,B) = {(0,1),(2,3),(0,1),(2,4),(3,4)}
S(B,C) = {(0,1),(2,4),(2,5),(3,4),(0,2),(3,4)}
*/

 create table R(
     A integer,
     B integer
 );

 create table S(
     B integer,
     C integer
 );

 insert into R values (0,1),(2,3),(0,1),(2,4),(3,4);
 insert into S values (0,1),(2,4),(2,5),(3,4),(0,2),(3,4);

--(i) [2pts] Finds A+B on R.
select (A+B) from R;

--(ii) [2pts] Sorts R based on B,A.
select * from R order by B, A; 

--(iii) [2pts] Turns R from a bag to a set.
select distinct * from R;

--(iv) [2pts] Computes the sum of B for each A value in R.
select A, sum(B) from R 
    Group by A;

--(v) [4pts] Joins R and S and computes the max value of C for each A.
select A, max(C) from R, S
    where R.b = S.b
    group by A;

--(vi) [2pts] Finds tuples of R which match and unmatch with S.
select R.A, R.B from R
    left outer join S on 
            R.B = S.B
        and R.A = S.C;

--(vii) [2pts] Finds tuples of S which match and unmatch with R.
select S.B, S.C from S 
    left outer join R on
            S.C = R.A
        and S.B = R.B;

--(viii) [4pts] Finds tuples of R which match and unmatch with S but in which R.B is less than S.B.
select R.A, R.B from R
    full outer join S on 
            R.B < S.B
        and R.A = S.C;
