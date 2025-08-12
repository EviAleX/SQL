Pokaz i, n, wynagrodzenie w formacie z walut� i 2 miejsca po przecinku.
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

Poka� i,n i kwartal zatrudnienia pracownikow.
select first_name, last_name, hire_date, to_char (hire_date, 'Q')
from employees;

Poka� list� prac i, n zatrudnionych w 4 Q.
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

Poka� pracownik�w zatrudnionych w lipcu.
select first_name, last_name from employees where to_char(hire_date,'month') like '%lipiec%';
select first_name, last_name from employees where to_char(hire_date,'mm') = 7;
 
Poka� pracownik�w zatrudnionych we wtorek
select first_name, last_name from employees where to_char(hire_date,'d') = 2;
select to_char(sysdate,'D, HH24:MI:SS YY, MONTH, DD') from dual;

-- MONTHS_BETWEEN - zwraca ilo�� miesi�cy pomi�dzy datami.

Za ile miesiecy b�dzie mikolaj? 6 grudzie� 2022
select months_between ('22-12-06', sysdate) from dual;
select months_between (to_date('6 grudzie� 2022','DD MONTH YYYY'), sysdate) from dual;

Za ile miesiecy b�dzie mikolaj? 6.12.2022. Odpowied� zaprezentuj jako pelne zdanie po polsku.
Kolumne nazwij odpowiedz.

-- Miko�aj b�dzie za 1,37 miesi�ca.
select 'Miko�aj b�dzie za ' || to_char(months_between(to_date('6.12.2022','DD.MM.YYYY'), sysdate),'9.99') ||' miesi�ca.' from dual;

-- ADD_MONTHS - dodaje do podanej daty n miesi�cy.
 
Za 3 miesiace dostane 1000zl. Kiedy to b�dzie?
select ADD_MONTHS (sysdate, 3) from dual;
select to_char(ADD_MONTHS (sysdate, 3),'dd.mm.yyyy') from dual;

-- LAST_DAY - zwraca dat� ostatniego dnia miesi�ca zawieraj�cego podan� dat�.

Jaka dat� ma ostatni dzien biezacego miesiaca?
select LAST_DAY(sysdate) from dual;

Jaka dat� ma ostatni dzien lutego 2026?
select LAST_DAY(to_date('15.02.026','dd.mm.yyy')) from dual;
 
Jak� dat� ma ostatni dzien nastepnego miesiaca?
select LAST_DAY(LAST_DAY(sysdate)+1) from dual;

Co b�dzie miesi�c po 29.02.2024.
Co b�dzie miesi�c po 31.03.2024.
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