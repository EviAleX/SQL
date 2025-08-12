--- z�aczenia nierownosciowe

 

Lista pracownik�w oraz ich poziom zaszeregowania
select * from job_grades;
select first_name, salary from employees;

 

select first_name, last_name, salary, grade_level
from employees join job_grades 
on salary between lowest_sal and highest_sal;

 

Oblicz �rednie wynagrodzenie pracownik�w na ka�dym poziomie zaszeregowania.

 

select grade_level, avg(salary) 
from employees join job_grades 
on salary between lowest_sal and highest_sal
group by grade_level;

 

Oblicz dla kazdego pracownka jakim procentem maksymalnego wynagrodzenia na jego poziomie zaszeregowania jest jego wynagrodzenie.
(i,%)

 

select first_name, round(100*salary/highest_sal)||'%'
from employees join job_grades 
on salary between lowest_sal and highest_sal;

 


--- podzapytania nieskorelowane
Poka� liczb� pracownikow i �rednie wynagrodzen wg miast. 
Policz wska�nik jak dana srednia ma sie w procentach do sredniej w calej firmie.

 

select avg(salary) from employees;

 

select city, round(avg(salary)), count(employee_id), round(avg(salary)/8775*100)||'%'
from employees join departments using (department_id)
join locations using (location_id)
group by city;

 

select city, round(avg(salary)), count(employee_id), round(avg(salary)/(SELECT AVG(salary) FROM employees)*100)||'%'
from employees join departments using (department_id)
join locations using (location_id)
group by city;

 

Oblicz wskaznik przeludnienia w departamentach wg nazwy.
- licz prac w dept
- sr licz prac w dept calej firmy

 

select department_name, 
round(count(employee_id)/(select count(employee_id) from employees)*(select count(department_id) from departments)*100)||'%'
from employees right join departments using (department_id)
group by department_name;

 

ZADANIA
1.    Poka� raport zawieraj�cy imiona i nazwiska pracownik�w oraz nazw� departamentu, w kt�rym pracuj�.

 

select first_name, last_name, department_name
from employees
join departments using(department_id)
order by department_name;

 

2.    Poka� raport zawieraj�cy imi� i nazwisko pracownika oraz nazw� departamentu i miasto, w kt�rym pracuje.

 

select first_name, last_name, department_name, city
from employees join departments using(department_id)
join locations using (location_id);

 

3.    Poka� raport zawieraj�cy nazw� departamentu (wszystkie) oraz imi� i nazwisko jego szefa.

 

select department_name, first_name, last_name
from departments left join employees on departments.manager_id = employees.employee_id;

 


4.    Poka� imi� i nazwisko pracownika oraz pseudonim jego szefa (pseudonim AZurawski).

 

select prac.first_name, prac.last_name, replace(nvl(substr(szef.first_name,1,1)||szef.last_name,'KJ'),' ')
from employees prac left join employees szef
on prac.manager_id=szef.employee_id;

 

5.    Poka� �rednie wynagrodzenia zatrudnionych pracownik�w wg kraj�w. (Kraj, �r wyn). Poka� wszystkie kraje.

 

select  country_name, avg(salary)
from employees join departments using(department_id)
join locations using (location_id)
right join countries using (country_id)
group by country_name;

 

6.    Poka� �rednie wynagrodzenia zatrudnionych pracownik�w wg kraj�w i miast wraz z podsumowaniem dla kraj�w. 
    Posortuj elegancko. (Kraj, miasto, �r wyn)
    
select  country_name, city, round(avg(salary))
from employees join departments using(department_id)
join locations using (location_id)
 join countries using (country_id)
group by country_name, rollup(city);

 

    
7.    Wy�wietl id departamentu oraz miasto w kt�rym ten departament si� znajduje. 
    Wy�wietl sum� zarobk�w w tych miastach, z podzia�em na departamenty.
    Uwzgl�dnij tylko te departamenty, w kt�rych si� zarabia w sumie wi�cej ni� 20 000 miesi�cznie.
    
select  city, department_name, sum(salary)
from employees join departments using(department_id)
join locations using (location_id)
group by city, department_name
having sum(salary)>20000;