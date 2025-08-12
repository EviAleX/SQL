CREATE VIEW view_employees
AS
select first_name, last_name, salary, department_name, city, country_name, region_name
from employees el
left join departments dl on el.department_id = dl.department_id
left join locations ll on dl.location_id = ll.location_id
left join countries cl on ll.country_id = cl.country_id
left join regions rl on cl.region_id = rl.region_id;

select * from view_employees;

select region_name, city, count(*)
from view_employees
group by rollup(region_name, city);

-- sekwencje
CREATE SEQUENCE 