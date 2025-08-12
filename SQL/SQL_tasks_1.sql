SELECT
*
FROM
employees;

DESCRIBE employees;
desc employees;

SELECT
first_name, last_name
FROM
employees;

1. Pokaz nazwy wszytkich miast, w ktorych mamy biura.

select city from locations;

2. Pokaz numer departamentu i jego nazwe.

select department_id, department_name from departments;

3. Pokaz numery departamentów w ktorych pracuj¹ wszyscy pracownicy.

select department_id from employees;

4. Pokaz numery departamentów unikalne (bez powtorzen) w ktorych pracuj¹ wszyscy pracownicy.

select distinct department_id from employees;

4b. Pokaz numery departamentów unikalne (bez powtorzen) w ktorych pracuj¹ wszyscy pracownicy, a w przypadku braku tego numeru wypisz BRAK.

select distinct NVL(department_id,0) from employees;

5. Poka¿ imiona i nazwiska, nazwij kolumny Imie Pracownika; Nazwisko Pracownika.

SELECT
first_name AS imie, last_name
FROM
employees;

SELECT
first_name AS "Imiê Pracownika", last_name "Nazwisko Pracownika"
FROM
employees
ORDER BY
last_name DESC;

6. Poka¿ listê pracowników (nazwiska) oraz wynagrodzenie i numer departamentu pracownika.

select last_name, salary, department_id
from employees;

6. Poka¿ listê pracowników (nazwiska) oraz wynagrodzenie i numer departamentu pracownika, wyn rosn¹, dept malej, nazw rosn¹

select last_name, salary, department_id
from employees
order by 
salary, department_id desc, last_name;

select last_name, salary, department_id
from employees
order by 
2, 3 desc, 1;

select last_name,  department_id
from employees
order by 
department_id desc nulls last;

select last_name,  department_id
from employees
order by 
department_id nulls first;

select * from departments;

select department_name from departments;

select nvl(state_province, 'brak') as "lokalizacja", city
from locations;

select distinct department_id 
from employees 
order by 1 desc;

7. Poka¿ wszystkie informacje na temat pracownikow zarabiajacych wiecej niz 10000.

select * 
from employees
where salary > 10000;

select * 
from employees
where bonus > 0;

select * 
from employees
where salary+bonus > 0;

desc employees;

select * 
from employees
where nvl(salary, 0)+nvl(bonus, 0) > 0;

8. Poka¿ nazwiska i wyn pracownikow z dept 50 i 90 zarabiajacych powyzej 3000.

select last_name, salary
from employees
where salary > 3000 and (department_id=50 or department_id=90);