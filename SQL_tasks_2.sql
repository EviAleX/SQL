Poka� imiona, nazwiska, salary pracownikow zarabiajacych pomiedzy 8000 a 12000

select first_name, last_name, salary from employees 
where salary >=8000 and salary <=12000;

select first_name, last_name, salary from employees 
where salary between 8000 and 12000;
-- The BETWEEN...AND operator is used to select and display rows based on a range of values. 

Poka� i, n, nr_dept pracownikow z dept 10

select first_name, last_name, department_id from employees
where department_id = 10;

Poka� i, n, nr_dept pracownikow z dept 10, 30

select first_name, last_name, department_id from employees
where department_id=10 or department_id=30;

Poka� i, n, nr_dept pracownikow z dept 10,20, 30, 40

select first_name, last_name, department_id from employees
where department_id=10 or department_id=20 or department_id=30 or department_id=40;

select first_name, last_name, department_id from employees
where department_id IN (10, 20, 30, 40); 
-- The IN condition is also known as the "membership condition.".  
-- It is used to test whether a value is IN a specified set of values.

Wy�wietl wszystkich pracownik�w kt�rych prze�o�onym jest manager o id 123 (z tabeli employees)

select first_name, last_name from employees
where manager_id=123;

Wy�wietl wszystkich pracownik�w zarabiaj�cych wi�cej ni� 8000 rocznie.

select first_name, last_name from employees
where salary > 8000;

Wy�wietl wszystkich pracownik�w kt�rych miesi�czne przychody s� wi�ksze ni� 1100 dolar�w
desc employees;
select first_name, last_name from employees
where nvl(salary,0)/12 > 1100;
-- NVL lets you replace null (returned as a blank) with a string in the results of a query

Wy�wietl wszystkich kt�rzy zarabiaj� wi�cej ni� 9 ty� ale mniej ni� 13 ty� rocznie.

select first_name, last_name, salary from employees
where salary > 9000 and salary < 13000 ;

Wy�wietl wszystkich kt�rzy zarabiaj� miesi�cznie wi�cej ni� 800$ ale mniej ni� 1200$.

select first_name, last_name from employees
where salary/12 > 800 and salary/12<1200;

Wy�wietl wszystkich pracownik�w kt�rych imi� ko�czy si� na a.

select first_name from employees 
where first_name LIKE '%a'; 
-- The LIKE condition allows you to select rows that match either characters, dates, or number patterns.
-- The percent (%) symbol is used to represent any sequence of zero or more characters. 
-- The underscore (_) symbol is used to represent a single character.

Wy�wietl wszystkich kt�rych imienia maj� w �rodku liter� a i jednocze�nie zarabiaj� wi�cej ni� 8000 dolar�w rocznie.

select first_name from employees 
where first_name like '%_a_%' and salary > 8000;

... z nazwiskiem Smith.
select first_name, last_name from employees
where last_name = 'Smith';

... i wyst�puje na 2 pozycji w imieniu.
select first_name, last_name from employees
where first_name like '_i%'; 

... ma dwie litery l w imieniu.
select first_name, last_name from employees
where first_name like '%l%l%' ; 

... ma dwie litery n (ma�a lub wielka) w imieniu.
select first_name, last_name from employees
where first_name like '%n%n%' or first_name like '%N%N%' or first_name like '%N%n%' or first_name like '%n%N%'; 

... c w imieniu i b w nazwisku.
select first_name, last_name from employees
where first_name like '%c%' and last_name like '%b%';

... c w imieniu i d w nazwisku.
select first_name, last_name from employees
where (first_name like '%c%' or first_name like '%C%') and (last_name like '%d%' or last_name like '%D%');

... w 3 pozycji ma samog�oska.
-- upper, lower, initcap 
-- Writing tables with upper and lower letters

Poka� list� pracownik�w nazwiska pisane wielkimi literami, a imiona ma�ymi literami.

select upper(last_name) "Wielkie nazwiska", lower(first_name) "Ma�e imiona" from employees; 

-- concat ||
-- Adding tabels in one row

select first_name||last_name from employees;

Pokaz liste pseudonimow pracownikow (imie i nazwisko pisane bez dodatkowej spacji) pisane z wilkiej litery.

select initcap(first_name||last_name) from employees;
-- INITCAP returns char, with the first letter of each word in uppercase, all other letters in lowercase

-- lpad, rpad
-- LPAD function pads the left-side of a string with a specific set of characters

Uzupe�nij nazwiska pracowniow do 20 znakow po lewej znakiem '.'

select lpad(last_name, 20, '.') from employees;

Uzupe�nij nazwiska pracowniow do 6 znakow po lewej znakiem '.'

select lpad(last_name, 6, '.') from employees;

-- HW: Ltrim, Rtrim dla ch�tnych
select first_name, ltrim(first_name, 'Lex') "Short Name" from employees;
-- LTRIM removes from the left end of char all of the characters contained in set.

-- replace
Zamie� os na oska.

select replace(last_name, 'os', 'oska') "FIRST_NAME", last_name from employees;

Zaszyfruj nazwiska usuwajac samog�oski a,e,o; -- pytanie...

select replace(replace(replace(last_name, 'a'),'e'),'o') from employees;
select replace(last_name, 'aeo', '') from employees;

-- translate

Zamie� a na A, e na E, o na O.

-- pytanie odno�nie syntaksu
select translate(last_name, 'aeo', 'AEO') from employees; 

Zaszyfruj nazwiska zast�puj�c samog�oski a,e,o na .;

select last_name, translate(last_name, 'aeo', '...') from employees; 

Zaszyfruj nazwiska zast�puj�c samog�oski a,e,o niczym;

select last_name, translate(last_name, ' aeo', ' ') from employees;

-- HW substr
Poka� imiona pracownik�w zaczyn�� od 3-ej litery w imieniu
select substr(first_name, 3, 10) from employees;
-- 3 stands for number when function start counting, if it's strats with -, like -5 its starts counting from the right side
-- 10 stands for the lenght, in my example it's from the 3rd element throught the next 10.