-- union all, union, minus, intersect
Poka¿ pracownikow imiê z dzialu IT (60). (3 rekordy)

 

select first_name from employees where department_id=60;

 

Poka¿ pracowników imiê zarabiaj¹cych >5000. (14 rekordów)

 

select first_name from employees where salary > 5000;

 


Poka¿ pracowników z dzialu it lub zarabiaj¹cych >5000;

 

select first_name from employees where department_id=60 OR salary>5000;

 

select first_name from employees where department_id=60
UNION 
select first_name from employees where salary > 5000;

 

select first_name from employees where department_id=60
UNION ALL
select first_name from employees where salary > 5000;

 

Poka¿ pracowników z dzialu it i zarabiaj¹cych >5000;

 

select first_name from employees where department_id=60 AND salary>5000;

 

select first_name from employees where department_id=60
INTERSECT
select first_name from employees where salary > 5000;

 

Poka¿ raport zawieraj¹cy pracowników zarabiaj¹cych >5000 i nie pracuj¹cych w IT.

 

select first_name from employees where (department_id<>60 or department_id is null) AND salary>5000;

 


select first_name from employees where salary > 5000
MINUS
select first_name from employees where department_id=60;

 

Wygeneruj raport zawierajacy w wierszach statystyki dzia³ów: Liczba pracownikow, Maksymalne wynagrodzenie

 

Dzia³ | Wskaznik | Wartoœæ
D1    | Liczba pracownikow | 10
D1    | Max wynagrodzenie | 1000
D2    | Liczba pracownikow | 10
D2    | Max wynagrodzenie | 1000

 

 

Dzia³ | Wskaznik           | Wartoœæ
D1    | Liczba pracownikow | 10
D2    | Liczba pracownikow | 10

 

select nvl(department_name,'- brak nazwy -') "Dzia³", 'Liczba pracownikow' "Wskaznik", count(employee_id) "Wartoœæ"
from employees full join departments using(department_id)
group by department_name;

 


Dzia³ | Wskaznik | Wartoœæ
D1    | Max wynagrodzenie | 1000
D2    | Max wynagrodzenie | 1000

 

select nvl(department_name,'- brak nazwy -') "Dzia³", 'Maksymalne wynagrodzenie' "Wskaznik", max(salary) "Wartoœæ"
from employees full join departments using(department_id)
group by department_name;

 

select nvl(department_name,'- brak nazwy -') "Dzia³", 'Liczba pracownikow' "Wskaznik", count(employee_id) "Wartoœæ"
from employees full join departments using(department_id)
group by department_name
UNION ALL
select nvl(department_name,'- brak nazwy -'), 'Maksymalne wynagrodzenie', max(salary)
from employees full join departments using(department_id)
group by department_name
order by 1,2;

 

select nvl(department_name,'- brak nazwy -') "Dzia³", 'Liczba pracownikow' "Wskaznik", count(employee_id) "Wartoœæ"
from employees full join departments using(department_id)
group by department_name
UNION ALL
select nvl(department_name,'- brak nazwy -'), 'Maksymalne wynagrodzenie', max(salary)
from employees full join departments using(department_id)
group by department_name
UNION ALL
select nvl(department_name,'- brak nazwy -'), 'Sumaryczne wynagrodzenie', sum(salary)
from employees full join departments using(department_id)
group by department_name
order by 1,2;

 

Policz pracownków zarabiajacych poni¿ej œredniej na kontynencie i powy¿ej œredniej na kontynencie/regionie.

 

select first_name, salary,0 "sr na kontynencie"
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries using(country_id)
left join regions using (region_id);

 

jaka sr wun w regionie 2?

 

select avg(salary) 
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries using(country_id)
left join regions on regions.region_id=countries.region_id
where regions.region_id=2;

 

select first_name, salary, (select avg(salary) 
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries using(country_id)
left join regions on regions.region_id=countries.region_id
where regions.region_id=r1.region_id) "sr na kontynencie"
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries c1 using(country_id)
left join regions r1 on c1.region_id=r1.region_id;

 

tylko prac powyzej sredniej
select first_name, region_name
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries c1 using(country_id)
left join regions r1 on c1.region_id=r1.region_id
WHERE
salary > (select avg(salary) 
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries using(country_id)
left join regions on regions.region_id=countries.region_id
where regions.region_id=r1.region_id);

 


Select region_name, 'Wiêksze' "WskaŸnik", count(employee_id) liczba from employees
left join departments using (department_id)
left join locations using (location_id)
left join countries using (country_id)
left join regions r using(region_id)
where salary>(Select avg(salary)from employees
left join departments using (department_id)
left join locations using (location_id)
left join countries using (country_id)
left join regions using(region_id)
where region_name=r.region_name)
group by region_name
UNION
Select region_name, 'Mniejsze' "WskaŸnik", count(employee_id) liczba from employees
left join departments using (department_id)
left join locations using (location_id)
left join countries using (country_id)
left join regions rr using(region_id)
where salary<=(Select avg(salary)from employees
left join departments using (department_id)
left join locations using (location_id)
left join countries using (country_id)
left join regions using(region_id)
where region_name=rr.region_name)
group by region_name;

 


select region_name,
sum(case 
when salary > (select avg(salary) 
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries using(country_id)
left join regions on regions.region_id=countries.region_id
where regions.region_id=r1.region_id) then 1 else 0
end) "czy powyzej",
sum(case 
when salary > (select avg(salary) 
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries using(country_id)
left join regions on regions.region_id=countries.region_id
where regions.region_id=r1.region_id) then 0 else 1
end) "czy poni¿ej"
from employees left join departments using(department_id)
left join locations using(location_id)
left join countries c1 using(country_id)
left join regions r1 on c1.region_id=r1.region_id

 

group by region_name;

 

Poka¿ listê pracowników zarabiaj¹cych najmniej w swoim departamencie.

 

select first_name, department_name
from employees x left join departments d on x.department_id=d.department_id
where salary = (select min(salary) from employees where department_id=x.department_id);