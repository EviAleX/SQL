Pokaz liste i, n, nazwa regionu dla pracownikow
select first_name, last_name, region_name
from employees
join departments using (department_id)
join locations using (location_id)
join countries using (country_id)
join regions using (region_id);

Pokaz liste i, n, nazwa regionu dla regionow. Pokaz rowniez regiony bez pracownikow
select first_name, last_name, region_name
from employees
join departments using (department_id)
join locations using (location_id)
join countries using (country_id)
right join regions using (region_id);

Pokaz liste i, n, nazwa regionu dla regionow. Pokaz rowniez pracownikow bez regionow
select first_name, last_name, region_name
from employees
left join departments using (department_id)
left join locations using (location_id)
left join countries using (country_id)
full join regions using (region_id);

Pokaz liczbe pracownikow i widelki ich wynagrodzen wg miast. Oznacz "brak miast"
select nvl(city, 'Brak miasta') "Miasto zatrudnienia", count(employee_id) "Liczba pracownikow", min(salary)|| '-' || max(salary) "Widelki placowe"  
from employees
left join departments using (department_id)
left join locations using (location_id)
group by city;

select nvl(city, 'Brak miasta') "Miasto zatrudnienia", count(employee_id) "Liczba pracownikow", min(salary)|| '-' || max(salary) "Widelki placowe", nvl(department_name, 'Brak departamentu') 
from locations
right join departments using (location_id)
right join employees using (department_id)
group by city, rollup (department_name)
order by 1,2;

Pokaz liczbe i srednie wynagrodzenie wg miast
Policz wskaznik jak dana srednia ma sie w procentach do srednije w calej firmie, ktora wynosi 8775
select city "Miasto zatrudenienia", count(employee_id) "Liczba pracownikow", round(avg(salary)) "Sr wyn", round(avg(salary)/8775*100,1)||'%'"wsk proc"
from locations
right join departments using (location_id)
right join employees using (department_id)
group by city
order by 1,2;

Pokaz liczbe i srednie wynagrodzenie wg miast
Policz wskaznik jak dana srednia ma sie w procentach do srednije w calej firmie, ktora wynosi 8775
Poka¿ wylacznie miasta ponizej 100% wskaznika
select city "Miasto zatrudenienia", count(employee_id) "Liczba pracownikow", round(avg(salary),1) "Sr wyn", round(avg(salary)/8775*100,1)||'%'"wsk proc"
from locations
 join departments using (location_id)
 join employees using (department_id)
group by city
having round(avg(salary)/8775*100,1) < 100
order by 1,2;

select prac.first_name, prac.last_name "nazw pracownika", szef.last_name "nazw szef"
from employees prac join employees szef on prac.manager_id=szef.employee_id;

select prac.first_name, prac.last_name "nazw pracownika", szef.last_name "nazw szef"
from employees prac left join employees szef on prac.manager_id=szef.employee_id;