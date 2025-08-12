SELECT first_name, last_name, department_id,
DECODE(department_id, 
90, 'Grube ryby',
60, 'Komputerowcy',
'Pozostali') GRUPKA
FROM employees;

 


select DECODE(department_id, 
90, 'Grube ryby',
60, 'Komputerowcy',
'Pozostali') GRUPKA, count(*)
from employees
group by DECODE(department_id, 
90, 'Grube ryby',
60, 'Komputerowcy',
'Pozostali');

 

 


select first_name, last_name, 
case department_id 
when 90 then 'Grube ryby'
when 60 then 'Komputerowcy'
else 'Pozostali'
end GRUPKA
from employees;

 


Pooznaczaj pracowników ze wzglêdu na dochody. (H >10k; M >4000-10000 L:other)

 

select first_name, last_name, 
case 
when salary>10000 then 'H'
when salary<4000 then 'L'
else 'M'
end WD
from employees;

 


Policz pracownikow ze wzgledu na dochody HML (powy¿sze).

 


select case 
when salary>10000 then 'H'
when salary<4000 then 'L'
else 'M'
end, count(*)
from employees
group by 
case 
when salary>10000 then 'H'
when salary<4000 then 'L'
else 'M'
end;

 


Poka¿ liczby pracowników zatrudnionych Zim¹ (grudzieñ - luty) oraz w pozostaych miesi¹cach.

 


select  
case
when to_char(hire_date,'MM') in ('12','01','02') then 'ZIMA'
else 'Pozosta³e'
end, count(*)
from employees
group by 
case
when to_char(hire_date,'MM') in ('12','01','02') then 'ZIMA'
else 'Pozosta³e'
end;

 

Pokaz a potem policz jak litera a jest w nazwie miesiaca to etykieta ok, nie_ok.

 

select 
case
when to_char(hire_date,'month') like '%a%' then 'OK'
else 'nie_ok'
end, count(*)
from employees
group by case
when to_char(hire_date,'month') like '%a%' then 'OK'
else 'nie_ok'
end
;

 

 

Poka¿ liczbê pracowników zatrudnionych w parzystych i nieparzystych miesi¹cach.
select case mod(to_char(hire_date,'MM'), 2) when 0 then 'parzyste' else 'nieparzyste' end, count(*)
from employees
group by case mod(to_char(hire_date,'MM'), 2) when 0 then 'parzyste' else 'nieparzyste' end;

 


Poka¿ liste pracownikow (i i n) oraz nazwe departamentu, w ktoreym pracuje.

 


select first_name, last_name, department_name
from employees, departments
where employees.department_id=departments.department_id;

 

select first_name, last_name, department_name
from employees INNER JOIN departments ON employees.department_id=departments.department_id; 

 

select first_name, last_name, department_name
from employees JOIN departments ON employees.department_id=departments.department_id; 

 

-- inner join

 

select first_name, last_name, department_name
from employees e JOIN departments d ON e.department_id=d.department_id; 

 

-- left join

 

select first_name, last_name, department_name
from employees e LEFT JOIN departments d ON e.department_id=d.department_id; 

 

-- right join

 

select first_name, last_name, department_name
from employees e RIGHT JOIN departments d ON e.department_id=d.department_id; 

 

-- full join

 

select first_name, last_name, department_name
from employees e FULL JOIN departments d ON e.department_id=d.department_id; 

 


-- left join bez dopasowanych

 

select first_name, last_name, department_name
from employees e LEFT JOIN departments d ON e.department_id=d.department_id
where d.department_id is null;

 

-- right join bez dopasowanych

 

select first_name, last_name, department_name
from employees e RIGHT JOIN departments d ON e.department_id=d.department_id
where e.department_id is null;

 

-- full join bez dopasowanych

 

select first_name, last_name, department_name
from employees e FULL JOIN departments d ON e.department_id=d.department_id
where e.department_id is null or d.department_id is null;

 


Poka¿ nazwy departamenty bez pracowników.

 

select department_name 
from departments left join employees ON departments.department_id=employees.department_id
where employees.department_id is null;

 


Poka¿ nazwy wszystkich departamentow i liczbê pracowników, ktorzy w nich pracuj¹.

 

select department_name, count(employee_id)
from departments d left join employees e on d.department_id=e.department_id
group by department_name;

 


select department_name
from departments d left join employees e on d.department_id=e.department_id;