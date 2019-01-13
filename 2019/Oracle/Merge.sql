--Virtual Column
create table virtualcolumn
(
total_amount int,
commision float generated always as (total_amount*0.01) virtual
)

drop table virtualcolumn;
desc virtualcolumn;

insert into virtualcolumn values(100);

select * from employees;

select AVG(COMMISSION_PCT) AS COMMISSION from employees;
select AVG(NVL(COMMISSION_PCT,0)) AS COMMISSION FROM EMPLOYEES;
select AVG(NVL2(COMMISSION_PCT,COMMISSION_PCT,0)) AS COMMISSION FROM EMPLOYEES;

CREATE TABLE TEST_MERGE
(
ID INT,
ID2 varchar2(10),
NAME VARCHAR2(30),
SALARY INT,
COMMISION INT
)

CREATE TABLE TEST_MERGE_HISTORY
(
ID INT,
ID2 varchar2(10),
NAME VARCHAR2(30),
SALARY INT
)

INSERT INTO TEST_MERGE VALUES(1,'1','Prudhviraju',1000,0.1);
update Test_merge set Name='Divya Varma' where id=1



MERGE INTO TEST_MERGE_HISTORY dest
        using Test_Merge src
        ON(dest.ID=src.ID
        AND dest.ID2=SRC.ID2)
WHEN MATCHED THEN
        UPDATE SET dest.Name=src.Name,
                   dest.Salary=SRC.Salary
WHEN NOT MATCHED THEN
        INSERT (id,id2,Name,Salary) values (src.id,src.id2,src.Name, src.Salary);
        
select * from TEST_MERGE_HISTORY;
        