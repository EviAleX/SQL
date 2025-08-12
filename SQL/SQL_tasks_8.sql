1.    Pokaø listÍ pracownikÛw (imiÍ i nazwisko) oraz:
a)    Nazwisko szefa

 

select p.first_name, p.last_name, s.last_name
from employees p left join employees s on p.manager_id=s.employee_id;

 

b)    PensjÍ szefa

 

select p.first_name, p.last_name, s.salary
from employees p left join employees s on p.manager_id=s.employee_id;

 

c)    % wskaünik pensji pracownika do pensji szefa

 

select p.first_name, p.last_name, nvl(round(p.salary/s.salary*100),0)||'%'
from employees p left join employees s on p.manager_id=s.employee_id;

 

2.    Polecenie 1b z uøyciem podzapytania

 

select * from employees;

 

select first_name, last_name, manager_id from employees;
select salary from employees where employee_id=100;

 

select first_name, last_name, 
manager_id, 'select salary from employees where employee_id='||manager_id||';', (select salary from employees e2 where e2.employee_id=e1.manager_id)
from employees e1;

 

select first_name, last_name, (select salary from employees e2 where e2.employee_id=e1.manager_id)
from employees e1;

 

3.    Pokaø nazwisko, wynagrodzenie i miasto pracownika oraz úrednie wynagrodzenie w mieúcie pracownika.

 

select last_name, salary, city
from employees left join departments using (department_id)
left join locations using (location_id);

 

ile úrednio zarabia siÍ w Toronto?

 

select avg(salary) 
from employees left join departments using (department_id)
left join locations using (location_id) 
where city='Toronto';

 


ile úrednio zarabia siÍ w Oxford?

 


select avg(salary) 
from employees left join departments using (department_id)
left join locations using (location_id) 
where city='Oxford';

 

select last_name, salary, city, 
                (select avg(salary) 
                from employees left join departments using (department_id)
                left join locations using (location_id) 
                where city=l1.city) "årednia w miescie"
from employees e1 left join departments d1 using (department_id)
left join locations l1 using (location_id);

 

4.    Oblicz dla kaødego pracownika wysokoúÊ podwyøki, aby jego wynagrodzenie wyrÛwnaÊ do úredniej w departamencie przed tπ podwyøkπ.

 

select last_name, (select avg(salary) from employees where department_id=e1.department_id)-salary "podwyzka"
from employees e1
where (select avg(salary) from employees where department_id=e1.department_id)>salary;

 

dept_id 60 ile srednio zarabia sie w 60?

 

select avg(salary) from employees where department_id=60;

 

5.    Pokaø nazwisko pracownika, jego wynagrodzenie oraz 
    wskaünik, ktory informuje jakim % sredniej w kraju jest wynagrodzenie danego pracownika 
    oraz wskaünik, ktÛry informuje jakim % úredniej w firmie jest wynagrodzenie danego pracownika.

 

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

 

6.    Pokaø i,n,wynagrodzenie pracownika, úr w dept, úr w mieúcie, úr w kraju.

 

select first_name, last_name, salary,
       round((select avg(salary) from employees where department_id=e1.department_id)) "sr w dept",
       round((select avg(salary) from employees left join departments using (department_id) left join locations using (location_id)where city=l1.city))  "sr w miasto",
       round((select avg(salary) from employees left join departments using (department_id) left join locations using (location_id) left join countries using (country_id) where country_name=c1.country_name)) "sr w kraj"
from    employees e1 left join departments d1 on e1.department_id=d1.department_id
        left join locations l1 using (location_id) 
        left join countries c1 using (country_id);

 

7.    Pokaø pracownikÛw zarabiajπcych powyøej jednokrotnoúci úredniej w ich mieúcie.

 

select last_name
from employees e1 left join departments d1 on e1.department_id=d1.department_id
        left join locations l1 using (location_id) 
where salary > (select avg(salary) from employees left join departments using (department_id) left join locations using (location_id)where city=l1.city);

 

8.    Pokaø pracownikÛw zarabiajπcych powyøej dwukrotnoúci minimalnej w ich kraju.

 

select last_name
from employees e1 left join departments d1 on e1.department_id=d1.department_id
        left join locations l1 using (location_id) 
        left join countries c1 using (country_id)
where salary > 2*(select min(salary) from employees left join departments using (department_id) left join locations using (location_id) left join countries using (country_id) where country_name=c1.country_name);

 

9.    Oblicz dla kaødego kraju wskaünik % pokazujπcy stosunek úredniego wynagrodzenia w tym kraju do úredniej w ca≥ej firmie.

 

select country_name,  (select avg(salary) from employees left join departments using (department_id) left join locations using (location_id) right join countries using (country_id) where country_name=c1.country_name) / (select avg(salary) from employees) "wskaznik"
from countries c1;