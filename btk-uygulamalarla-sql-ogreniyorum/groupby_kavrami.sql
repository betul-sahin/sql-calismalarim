--SQL de group by kullanimi
--group by, order by, having, aggregate functions

--en cok satis yapan personeller
select e.employee_id, e.first_name, e.last_name, count(o.order_id) as total_order
from employees e
inner join orders o
on e.employee_id = o.employee_id
group by 1
order by 4 desc;

--en cok satis yapan 10 personel
select e.employee_id, e.first_name, e.last_name, count(o.order_id) as total_order
from employees e
inner join orders o
on e.employee_id = o.employee_id
group by 1
order by 4 desc
limit 10;

--bir urunun gun bazli satis rakamlari
select p.product_name, o.order_date, sum((od.unit_price*od.quantity)*(1-od.discount)) as total_price
from order_details od
inner join orders o
on od.order_id = o.order_id
inner join products p
on p.product_id = od.product_id
group by 1, 2
order by 1, 2;

--bir gunun urun bazli satis rakamlarini getirme
select o.order_date, p.product_name, sum((od.unit_price*od.quantity)*(1-od.discount)) as total_price
from order_details od
inner join orders o
on od.order_id = o.order_id
inner join products p
on p.product_id = od.product_id
where o.order_date = '1996-07-04'
group by o.order_date, p.product_name
order by o.order_date, 3 desc;

--urunlerin aylara gore satis rakamlari
select p.product_name, extract(month from o.order_date), sum((od.unit_price*od.quantity)*(1-od.discount)) as total_price
from order_details od
inner join products p
on od.product_id = p.product_id
inner join orders o
on o.order_id = od.order_id
group by 1, 2
order by 1, 2;

--urun kategorilerine gore satis rakamlari
select c.category_name as kategori, count(*) as satir_sayisi, sum((od.unit_price*od.quantity)*(1-od.discount)) as toplam_tutar
from products p
inner join categories c
on p.category_id = c.category_id
inner join order_details od
on od.product_id = p.product_id
group by c.category_name;

--ulkelere gore ihrac edilen urunlerin sayisi
select o.ship_country, count(od.product_id) as urun_sayisi
from order_details od
inner join orders o
on od.order_id = o.order_id
inner join products p
on p.product_id = od.product_id
group by o.ship_country
order by o.ship_country;

--belli bir satis rakaminin uzerinde satilan urunleri getirme
select p.product_name, count(distinct p.product_name) as urun_sayisi, 
sum((od.unit_price*od.quantity)*(1-od.discount)) as toplam_tutar
from order_details od
inner join orders o
on od.order_id = o.order_id
inner join products p
on p.product_id = od.product_id
group by p.product_name
having sum((od.unit_price*od.quantity)*(1-od.discount))>30000
order by p.product_name;





