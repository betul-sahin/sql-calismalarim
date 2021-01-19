--ASCI
select ascii('A');

--substring
select substring('Betül Şahin', 1, 5);

--position
select position('a' in 'Betül Şahin');

--char_length
select char_length('Betül');

--lower and upper
select lower('BETÜL');
select upper('şahin');

--trim
select trim(both 'x' from 'xTomx');

--concat
select concat('btk' , 'akademi', 'sql' , 'eğitimi');

--date functions
select now();
select timeofday();
select date_part('hour', timestamp '2001-02-16 20:38:40');
select date_part('month', now());
select date_trunc('hour', timestamp '2001-02-16 20:38:40');
select age(timestamp '1987-09-12');

--left
select left('sql eğitimi', 7);

--right
select right('sql eğitimi', 5);

--replace
select replace('betül şahin', 'betül', 'fatma');
