Œrednie pensje
select avg(salary) from employees;

Œrednia na stanowisku clerk
select avg(salary) from employees where job_id='ST_CLERK';

Ilu pracowników dostaje bonus
select count(*) from employees where bonus is not null;
select count(bonus) from employees;
select avg(bonus) from employees;
select avg(bonus) from employees where bonus is not null;
-- COUNT returns the number of rows returned by the query

Oblicz sredni bonus w podziale na wszystkich pracownikow (bez bonus rowniez)
select sum(bonus)/count(*) from employees;

Fundusz wynagrodzeñ
select sum(salary)+sum(bonus) from employees;
select sum(nvl(salary,0)+nvl(bonus,0)) from employees; ---!!!
-- NVL lets you replace null with a string in the results of a query

Pokaz najnizsze wyn
select min(salary) from employees;

Pokaz najnizsze wyn na st clerk
select min(salary) from employees where job_id='ST_CLERK';

Pokaz najwyzsze wyn
select max(salary) from employees;

Pokaz najwyzsze wyn pracow z inicjalem zawierajacym  A
select max(salary) from employees where substr(first_name, 1,1)='A' or substr(last_name, 1,1)='A';

Ilu pracowników pracuje jako MK_REP, ST_CLERK, IT_PROG? [1,4,3]
select count(*) from employees where job_id='MK_REP';
select count(*) from employees where job_id='ST_CLERK';
select count(*) from employees where job_id='IT_PROG';

Unikalne stanowiska:
select distinct job_id from employees;
-- DICTINCT getting rid of dublicate rows and shows only one position each time

select job_id, count(*)
from employees
group by job_id;

Ilu pracowników pracuje jako MK_REP, ST_CLERK, IT_PROG? [1,4,3]
select job_id, count(*) 
from employees 
where job_id IN ('MK_REP', 'ST_CLERK', 'IT_PROG')
group by job_id;

Ilu pracowników maj¹ nasi managerowie i ile im placa srednio?
select manager_id, count(*), avg(salary)
from employees
group by manager_id;

Ilu pracowników maj¹ nasi managerowie w podziale na wg pierwszej litery imienia.
select first_name, last_name, manager_id, substr(first_name, 1, 1) from employees;

select manager_id SZEF, substr(first_name, 1, 1) INICJAL, count(*) LICZBA_PRAC
from employees
group by manager_id, substr(first_name, 1, 1)
order by 1,2;
-- ORDER BY - sortowanie kolumn 

Ilu pracowników korzysta z telefonow wg nr kier (pierwsza cyfra numeru) i wg inicjalu im.
select substr(phone_number,1,1) KIERUNKOWY, substr(first_name, 1, 1) INICJAL, count(*) LICZBA_PRAC
from employees
group by substr(phone_number,1,1), substr(first_name, 1, 1)
order by 1,2;

Pogrupuj wg rok i job id i policz prac.
select to_char(hire_date,'yyyy'), job_id, count(*)
from employees
group by to_char(hire_date,'yyyy'), job_id
order by 1,3 desc;

Poka¿ œrednie wynagrodzenie wg miesiaca zatrudnienia i departamentu.
SELECT to_char(hire_date,'MON') AS MSC_ZATR, department_id AS DEPARTAMENT, avg(salary) AS SR_WYN
from employees
GROUP BY to_char(hire_date,'MON'), department_id
ORDER BY 1,2;

Poka¿ liczbê pracowników wg managera i wieku zatrudnienia.
SELECT manager_id, (trunc((to_char(hire_date,'YYYY')-1),-2)/100)+1 AS WIEK_ZATR, count(*)
from employees
group by manager_id, (trunc((to_char(hire_date,'YYYY')-1),-2)/100)+1;

Pokaz w porzadku malejacym najnizsze wynagrodzenia wg departamentow.
select min(salary), department_id
from employees
group by department_id
order by 1 desc;
-- DESC - posortuj malejaca

Poka¿ maksymalne wynagrodzenie wg dnia tygodnia zatrudnienia.
select to_char(hire_date,'DAY'), max(salary) from employees
group by to_char(hire_date,'DAY');

Poka¿ liczbê pracowników zatrudnianych wg kwartalów.
select to_char(hire_date,'q') kwartal, count(*) li_prac, avg(salary)
from employees
group by to_char(hire_date,'q');

Poka¿ liczbê pracowników wg polrocza zatrudnienia.
select round(to_char(hire_date,'Q')/2), count(*), avg(salary) from employees
group by round(to_char(hire_date,'Q')/2);