1. Wyœwietl listê osób (i i n), które maja podw³adnych oraz liczbê tych podw³adnych.

 

- co to znaczy ma podw³adnych? = jest managerem
select distinct manager_id from employees where manager_id is not null; 

 

- ile osób w kol man_id=100?
select count(employee_id) from employees where manager_id=100;

 

select  first_name, last_name,
        (select count(employee_id) from employees where manager_id=e1.employee_id) "Liczba podwladnych"
from employees e1
where employee_id in (select distinct manager_id from employees where manager_id is not null);

 

1b. Lista wszystkich pracowników i liczbê podw³adnych (0 tam gdzie brak).

 

select first_name, last_name,
        (select count(employee_id) from employees where manager_id=e1.employee_id) "Liczba podwladnych"
from employees e1;

 

2. Dla ka¿dego kraju poka¿:
    - najliczniejsze miasto wraz z liczb¹ pracownikow oraz 
    - miasto o najni¿szym wynagrodzeniu wraz z znajnizszym wynagrodzeniem.
    
kraj | miasto | najliczniejsze | 12

 

select country_name, city, 'najliczniejsze', count(employee_id)
from countries join locations using (country_id)
join departments using (location_id)
join employees using (department_id)
group by country_name, city;

 

-- w USA:
select max(licznosc)
from (select count(employee_id) as licznosc
from countries c3 join locations l3 using (country_id)
join departments using (location_id)
join employees using (department_id)
group by c3.country_name, l3.city
having country_name='United States of America');

 


select c1.country_name, 
(select max(licznosc)
from (select count(employee_id) as licznosc
from countries c3 join locations l3 using (country_id)
join departments using (location_id)
join employees using (department_id)
group by c3.country_name, l3.city
having c3.country_name=c1.country_name)),
city, 'najliczniejsze', count(employee_id)
from countries c1 join locations using (country_id)
join departments using (location_id)
join employees using (department_id)
group by c1.country_name, city;

 

 

kraj | misato | najnizej oplacane| 1000

 

select country_name, city, 'najnizej oplacane', min(salary)
from countries join locations using (country_id)
join departments using (location_id)
join employees using (department_id)
group by country_name, city;

 


3. wyœwietl listê miast w których nie zatrudniamy pracowników

 

select city
from locations left join departments using (location_id)
left join employees using(department_id)
where employee_id is null;

 

select city, department_name,first_name
from locations left join departments using (location_id)
left join employees using(department_id)
where employee_id is null and department_id is null;

 


select city
from locations left join departments using (location_id)
left join employees using(department_id)
group by city
having count(employee_id)=0;

 


4. Policz pracownikow posiadaj¹cych litere "a" lub "A" w imieniu w kazdym z (wg) departamentow.

 


select department_id, count(first_name) from employees 
where first_name like '%a%' or first_name like '%A%'
group by department_id;