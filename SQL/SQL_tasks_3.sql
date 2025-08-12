Pokaz i, n, wynagrodzenie w formacie z walut¹ i 2 miejsca po przecinku.
select first_name, last_name, salary, to_char (salary, 'L09,999.99')
from employees;

select first_name, last_name, salary, to_char (salary, 'L99999.99')
from employees;

select first_name, last_name, salary, to_char (salary, 'L99,999.99')
from employees;

select first_name, last_name, salary, to_char (-salary, '09,999.99MI')
from employees;

select first_name, last_name, salary, to_char (-salary, '09,999.99PR')
from employees;

select first_name, last_name, salary, to_char (-salary, 'L09,999.99MI')
from employees;
-- TO_CHAR converts a datetime or interval value of date

Poka¿ i,n i kwartal zatrudnienia pracownikow.
select first_name, last_name, hire_date, to_char (hire_date, 'Q')
from employees;

Poka¿ listê prac i, n zatrudnionych w 4 Q.
select first_name, last_name from employees where to_char(hire_date,'Q')='4';
select first_name, last_name from employees where to_char(hire_date,'Q')=4;

Pokaz i, n, date zatrudnienia w formacie '01 styczen 2021'.
select first_name, last_name, hire_date, to_char (hire_date, 'DD month yyyy')
from employees;

select first_name, last_name, hire_date, to_char (hire_date, 'DD-month-yyyy')
from employees;

select first_name, last_name, hire_date, to_char (hire_date, 'DD ')||rtrim(to_char(hire_date, 'month'))||to_char (hire_date, ' YYYY')
from employees;
-- || concatenates character strings and clob data 

Poka¿ pracowników zatrudnionych w lipcu.
select first_name, last_name from employees where to_char(hire_date,'month') like '%lipiec%';
select first_name, last_name from employees where to_char(hire_date,'mm') = 7;
 
Poka¿ pracowników zatrudnionych we wtorek
select first_name, last_name from employees where to_char(hire_date,'d') = 2;
select to_char(sysdate,'D, HH24:MI:SS YY, MONTH, DD') from dual;

-- MONTHS_BETWEEN - zwraca iloœæ miesiêcy pomiêdzy datami.

Za ile miesiecy bêdzie mikolaj? 6 grudzieñ 2022
select months_between ('22-12-06', sysdate) from dual;
select months_between (to_date('6 grudzieñ 2022','DD MONTH YYYY'), sysdate) from dual;

Za ile miesiecy bêdzie mikolaj? 6.12.2022. OdpowiedŸ zaprezentuj jako pelne zdanie po polsku.
Kolumne nazwij odpowiedz.

-- Miko³aj bêdzie za 1,37 miesi¹ca.
select 'Miko³aj bêdzie za ' || to_char(months_between(to_date('6.12.2022','DD.MM.YYYY'), sysdate),'9.99') ||' miesi¹ca.' from dual;

-- ADD_MONTHS - dodaje do podanej daty n miesiêcy.
 
Za 3 miesiace dostane 1000zl. Kiedy to bêdzie?
select ADD_MONTHS (sysdate, 3) from dual;
select to_char(ADD_MONTHS (sysdate, 3),'dd.mm.yyyy') from dual;

-- LAST_DAY - zwraca datê ostatniego dnia miesi¹ca zawieraj¹cego podan¹ datê.

Jaka datê ma ostatni dzien biezacego miesiaca?
select LAST_DAY(sysdate) from dual;

Jaka datê ma ostatni dzien lutego 2026?
select LAST_DAY(to_date('15.02.026','dd.mm.yyy')) from dual;
 
Jak¹ datê ma ostatni dzien nastepnego miesiaca?
select LAST_DAY(LAST_DAY(sysdate)+1) from dual;

Co bêdzie miesi¹c po 29.02.2024.
Co bêdzie miesi¹c po 31.03.2024.
select add_months (to_date ('31.03.2024','dd.mm.yyyy'),1) from dual; 
select add_months (to_date ('28.02.2024','dd.mm.yyyy'),1) from dual;

select Round (sysdate,'month') from dual;
select Round (sysdate, 'year') from dual;
-- ROUND returns n rounded to integer places to the right of the decimal point

Pokaz i, n oraz dziesieciolecie zatrudnienia prac. (80th, 90th, 00th)
select to_char(trunc(to_char(hire_date,'yy'),-1),'09')||'th', first_name from employees;
-- TRUNC function returns date with the time portion of day truncated to the unit/

-- SUBSTR functions return a portion of char, beggining at character position, substring_length
select substr(first_name, 2), substr(first_name, -2), substr(first_name, 2, 2), substr(first_name, -3, 2) from employees;