SELECT *
FROM USER_TABLES;

 

Utworz kopie tabeli employees pod nazwa copy_employees wraz z danymi.

 

CREATE TABLE
copy_employees
AS (SELECT * FROM employees);

 

desc copy_employees;
select * from copy_employees;

 

Utwórz tabelê zawieraja kolumny ID, Imiê, Nazwisko, wynagrodzenie, stanowisko 
na bazie tabeli employees pod nazwa copy2_employees w odniesieniu do stanowisk zawierajacych "rep".

 


SELECT employee_id as "ID", first_name "Imiê", last_name "Nazwisko", salary "wynagrodzenie", job_id "stanowisko" 
FROM employees
WHERE job_id like '%REP%';
 

 

CREATE TABLE
copy2_employees
AS 
(SELECT employee_id as "ID", first_name "Imiê", last_name "Nazwisko", salary "wynagrodzenie", job_id "stanowisko" 
FROM employees
WHERE job_id like '%REP%');

 


select * from copy2_employees;
DESCRIBE copy2_employees;

 

 

 

create table copy_departments as (select * from departments); 
describe copy_departments;

 

 

 

 

INSERT INTO copy_departments
(department_id , department_name , manager_id , location_id)
VALUES
(200,'Human Resources', 205, 1500);

 

select * from copy_departments;

 


INSERT INTO copy_departments
(department_name , manager_id)
VALUES
('Zarzad', 100);

 

INSERT INTO copy_departments
(manager_id)
VALUES
(100);

 

INSERT INTO copy_departments
(department_id , department_name , manager_id , location_id)
VALUES
('','Zarzad 2', 101, '');
 

 

INSERT INTO copy_departments
VALUES
(210,'Estate Management', 102, 1700);
 

 

INSERT INTO copy_departments
VALUES
('','Zarzadzanie flota', 150, 1500);

 


INSERT INTO copy_departments
(department_name , department_id , location_id, manager_id)
VALUES
('zarzad 4',100,200,300);
 

 

 

INSERT INTO copy_employees
(employee_id , first_name , last_name , phone_number , hire_date , job_id, salary)
VALUES
(302,'Piotr','Duda', '8586667641', '15 Jun 2015', 'IT_PROG',4200);

 

describe copy_employees;

 

 

 

INSERT INTO copy_employees
(employee_id , first_name , last_name , phone_number , hire_date , job_id, salary, email)
VALUES
(302,'Piotr','Duda', '8586667641', '15 Jun 2015', 'IT_PROG' ,4200,'xxx');

 

select to_char(hire_date, 'DD MON YEAR') from employees;
select to_date('15 cze 2015','DD MON YYYY') from dual;

 

select to_date('15 Cze 15','DD MON YY') from dual;
 

 

INSERT INTO copy_employees
(employee_id , first_name , last_name , phone_number , hire_date , job_id, salary, email)
VALUES
(302,'Piotr','Duda', '8586667641', to_date('15 Cze 2015','DD MON YYYY'), 'IT_PROG' ,4200,'xxx');

 

select * from copy_employees;
 

 

INSERT INTO copy_employees
(first_name, last_name, hire_date, email, job_id)
VALUES
('Konrad','Duda', SYSDATE, 'kd', 'BOSS');

 

 
copy_employees; (first_name, last_name, hire_date, email, job_id); REP

 

 

 

INSERT INTO copy_employees
(first_name, last_name, hire_date, email, job_id)
SELECT
first_name, last_name, hire_date, email, job_id
FROM employees
WHERE
job_id LIKE '%REP%';

 


select * from copy_employees;

 

PROG; (first_name, last_name, hire_date, email, job_id); salary 11111; zatrud dziœ

 


INSERT INTO
copy_employees
(first_name, last_name, hire_date, email, job_id, salary)
SELECT
first_name, last_name, SYSDATE, email, job_id, 11111
FROM employees
WHERE
job_id LIKE '%PROG%';

 


IT_PROG -> programist

 


UPDATE
copy_employees
SET
job_id = 'programist'
WHERE
job_id = 'IT_PROG';

 


select * from copy_employees;

 

wynagrodzenia w dept 50 zostaly po3jone.

 

UPDATE
copy_employees
SET
salary=3 * salary
WHERE
department_id = 50;

 


select * from copy_employees;

 

ustaw wynagrodzenia w dept 60 na wartoœæ œrednia w tym dpart

 

UPDATE
copy_employees
SET
salary= (select avg(salary) from copy_employees where department_id=60)
WHERE
department_id = 60;

 

select * from copy_employees;

 


usunac pracownika o id = 124

 

DELETE FROM copy_employees 
where employee_id=124;

 

usunac BOSSa

 

delete from copy_employees where job_id='BOSS';

 

usunac podwaladnych mgr o id 100

 

delete from copy_employees where manager_id=100;

 

usun pracownikow zarabiajacych powyzej sredniej w firmie

 

delete from copy_employees 
where salary > (select avg(salary) from copy_employees);

 

select * from copy_employees; 

 

drop table copy_employees;
drop table copy2_employees;
drop table copy_departments;

 

 

 

 

 

CREATE TABLE my_cd_collection
(cd_number NUMBER(3),
title VARCHAR2(20),
artist VARCHAR2(20),
purchase_date DATE DEFAULT SYSDATE);

 

 

 

select * from my_cd_collection; 
desc my_cd_collection;

 

 

 

insert into my_cd_collection
values
(1, 'Back to black', 'Amy Winehouse', to_date('1.08.2021','dd.mm.yyyy'));
 
insert into my_cd_collection
values
(2, '1000 gecs', '100 gecs', to_date('1.08.2020','dd.mm.yyyy'));

 

insert into my_cd_collection
(title, artist)
values
('AM','Arctic Monkeys');

 

select * from my_cd_collection;
 
insert into my_cd_collection
values
(4, 'Kwarantanna', 'Chopin', to_date('11-12-2020','dd-mm-yyyy'));

 

 

 

insert into my_cd_collection
(cd_number, title, artist)
values
(8, 'Bajkowe piosenki', 'Edyta Górniak');
 
select * from my_cd_collection;
 

 

update my_cd_collection 
set
cd_number = 3
where title = 'AM';

 

update my_cd_collection 
set
cd_number = 99,
artist ='100 gecs'
where title = 'AM';

 


Utworz tabele podwyzka (id, nazwisko, podw) i za³aduj rekordy, gdzie:
1) dla osób zarabiaj¹cych ponizej sredniej w firmie pensja zostanie podwyzszona o 80%
2) dla osob =< avg zostanie obnizona o 200.

 


create table podwyzka as (select employee_id ID, last_name NAZWISKO, 0 PODW FROM employees);
select * from podwyzka;

 

update podwyzka
set podw=-200
where ID in (select employee_id from employees where salary >= (select avg(salary) from employees));

 

update podwyzka
set podw= (select 0.8*salary from employees where employee_id=ID) 
where ID in (
select employee_id from employees where salary < (select avg(salary) from employees));