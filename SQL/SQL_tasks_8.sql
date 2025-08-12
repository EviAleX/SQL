1.    Poka� list� pracownik�w (imi� i nazwisko) oraz:
a)    Nazwisko szefa

 

select p.first_name, p.last_name, s.last_name
from employees p left join employees s on p.manager_id=s.employee_id;

 

b)    Pensj� szefa

 

select p.first_name, p.last_name, s.salary
from employees p left join employees s on p.manager_id=s.employee_id;

 

c)    % wska�nik pensji pracownika do pensji szefa

 

select p.first_name, p.last_name, nvl(round(p.salary/s.salary*100),0)||'%'
from employees p left join employees s on p.manager_id=s.employee_id;

 

2.    Polecenie 1b z u�yciem podzapytania

 

select * from employees;

 

select first_name, last_name, manager_id from employees;
select salary from employees where employee_id=100;

 

select first_name, last_name, 
manager_id, 'select salary from employees where employee_id='||manager_id||';', (select salary from employees e2 where e2.employee_id=e1.manager_id)
from employees e1;

 

select first_name, last_name, (select salary from employees e2 where e2.employee_id=e1.manager_id)
from employees e1;

 

3.    Poka� nazwisko, wynagrodzenie i miasto pracownika oraz �rednie wynagrodzenie w mie�cie pracownika.

 

select last_name, salary, city
from employees left join departments using (department_id)
left join locations using (location_id);

 

ile �rednio zarabia si� w Toronto?

 

select avg(salary) 
from employees left join departments using (department_id)
left join locations using (location_id) 
where city='Toronto';

 


ile �rednio zarabia si� w Oxford?

 


select avg(salary) 
from employees left join departments using (department_id)
left join locations using (location_id) 
where city='Oxford';

 

select last_name, salary, city, 
                (select avg(salary) 
                from employees left join departments using (department_id)
                left join locations using (location_id) 
                where city=l1.city) "�rednia w miescie"
from employees e1 left join departments d1 using (department_id)
left join locations l1 using (location_id);

 

4.    Oblicz dla ka�dego pracownika wysoko�� podwy�ki, aby jego wynagrodzenie wyr�wna� do �redniej w departamencie przed t� podwy�k�.

 

select last_name, (select avg(salary) from employees where department_id=e1.department_id)-salary "podwyzka"
from employees e1
where (select avg(salary) from employees where department_id=e1.department_id)>salary;

 

dept_id 60 ile srednio zarabia sie w 60?

 

select avg(salary) from employees where department_id=60;

 

5.    Poka� nazwisko pracownika, jego wynagrodzenie oraz 
    wska�nik, ktory informuje jakim % sredniej w kraju jest wynagrodzenie danego pracownika 
    oraz wska�nik, kt�ry informuje jakim % �redniej w firmie jest wynagrodzenie danego pracownika.

 

select last_name, salary, "wskaznik 1", "wskaznik 2"

 

from employees e1 left join departments d1 using (department_id)
                left join locations l1 using (location_id) 
                left join countries c1 using (country_id);

 

wskaznik 1 -> srednia w kraju skorelowane

 

Canada jaka srednia?

 

select avg(salary) 
from employees 
left join departments using (department_id)
left join locations using (location_id) 
left join countries using (country_id)
where country_name='Canada';

 


wskaznik 2 -> srednia w firmie nieskorelowane
select avg(salary) from employees;

 


select last_name, salary, 
                    
                    round(salary/(select avg(salary) 
                    from employees 
                    left join departments using (department_id)
                    left join locations using (location_id) 
                    left join countries using (country_id)
                    where country_name=c1.country_name),2) "wskaznik 1", 
                    
                    round(salary/(select avg(salary) from employees),2) "wskaznik 2"

 

from employees e1 left join departments d1 using (department_id)
                left join locations l1 using (location_id) 
                left join countries c1 using (country_id);

 

6.    Poka� i,n,wynagrodzenie pracownika, �r w dept, �r w mie�cie, �r w kraju.

 

select first_name, last_name, salary,
       round((select avg(salary) from employees where department_id=e1.department_id)) "sr w dept",
       round((select avg(salary) from employees left join departments using (department_id) left join locations using (location_id)where city=l1.city))  "sr w miasto",
       round((select avg(salary) from employees left join departments using (department_id) left join locations using (location_id) left join countries using (country_id) where country_name=c1.country_name)) "sr w kraj"
from    employees e1 left join departments d1 on e1.department_id=d1.department_id
        left join locations l1 using (location_id) 
        left join countries c1 using (country_id);

 

7.    Poka� pracownik�w zarabiaj�cych powy�ej jednokrotno�ci �redniej w ich mie�cie.

 

select last_name
from employees e1 left join departments d1 on e1.department_id=d1.department_id
        left join locations l1 using (location_id) 
where salary > (select avg(salary) from employees left join departments using (department_id) left join locations using (location_id)where city=l1.city);

 

8.    Poka� pracownik�w zarabiaj�cych powy�ej dwukrotno�ci minimalnej w ich kraju.

 

select last_name
from employees e1 left join departments d1 on e1.department_id=d1.department_id
        left join locations l1 using (location_id) 
        left join countries c1 using (country_id)
where salary > 2*(select min(salary) from employees left join departments using (department_id) left join locations using (location_id) left join countries using (country_id) where country_name=c1.country_name);

 

9.    Oblicz dla ka�dego kraju wska�nik % pokazuj�cy stosunek �redniego wynagrodzenia w tym kraju do �redniej w ca�ej firmie.

 

select country_name,  (select avg(salary) from employees left join departments using (department_id) left join locations using (location_id) right join countries using (country_id) where country_name=c1.country_name) / (select avg(salary) from employees) "wskaznik"
from countries c1;