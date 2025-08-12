--- z³aczenia nierownosciowe

 

Lista pracowników oraz ich poziom zaszeregowania
select * from job_grades;
select first_name, salary from employees;

 

select first_name, last_name, salary, grade_level
from employees join job_grades 
on salary between lowest_sal and highest_sal;

 

Oblicz œrednie wynagrodzenie pracowników na ka¿dym poziomie zaszeregowania.

 

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
Poka¿ liczbê pracownikow i œrednie wynagrodzen wg miast. 
Policz wska¿nik jak dana srednia ma sie w procentach do sredniej w calej firmie.

 

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
1.    Poka¿ raport zawieraj¹cy imiona i nazwiska pracowników oraz nazwê departamentu, w którym pracuj¹.

 

select first_name, last_name, department_name
from employees
join departments using(department_id)
order by department_name;

 

2.    Poka¿ raport zawieraj¹cy imiê i nazwisko pracownika oraz nazwê departamentu i miasto, w którym pracuje.

 

select first_name, last_name, department_name, city
from employees join departments using(department_id)
join locations using (location_id);

 

3.    Poka¿ raport zawieraj¹cy nazwê departamentu (wszystkie) oraz imiê i nazwisko jego szefa.

 

select department_name, first_name, last_name
from departments left join employees on departments.manager_id = employees.employee_id;

 


4.    Poka¿ imiê i nazwisko pracownika oraz pseudonim jego szefa (pseudonim AZurawski).

 

select prac.first_name, prac.last_name, replace(nvl(substr(szef.first_name,1,1)||szef.last_name,'KJ'),' ')
from employees prac left join employees szef
on prac.manager_id=szef.employee_id;

 

5.    Poka¿ œrednie wynagrodzenia zatrudnionych pracowników wg krajów. (Kraj, œr wyn). Poka¿ wszystkie kraje.

 

select  country_name, avg(salary)
from employees join departments using(department_id)
join locations using (location_id)
right join countries using (country_id)
group by country_name;

 

6.    Poka¿ œrednie wynagrodzenia zatrudnionych pracowników wg krajów i miast wraz z podsumowaniem dla krajów. 
    Posortuj elegancko. (Kraj, miasto, œr wyn)
    
select  country_name, city, round(avg(salary))
from employees join departments using(department_id)
join locations using (location_id)
 join countries using (country_id)
group by country_name, rollup(city);

 

    
7.    Wyœwietl id departamentu oraz miasto w którym ten departament siê znajduje. 
    Wyœwietl sumê zarobków w tych miastach, z podzia³em na departamenty.
    Uwzglêdnij tylko te departamenty, w których siê zarabia w sumie wiêcej ni¿ 20 000 miesiêcznie.
    
select  city, department_name, sum(salary)
from employees join departments using(department_id)
join locations using (location_id)
group by city, department_name
having sum(salary)>20000;