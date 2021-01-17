--SQL de aggregate fonksiyonlarin kullanimi
--Aggregate fonksiyonlar: count, max, min, sum, avg

-- alinan siparislerin tumunun toplam sayisi
select count(*) from order_details;

-- ayni urunden en az 1 tane, en fazla 130 tane siparis edilmis
SELECT * FROM order_details
ORDER BY quantity;

-- bir üründen en az 5 tane, en fazla 54 tane siparis edilmis
select count(product_id) as amount, product_id
from order_details
group by product_id
order by 1;

--toplam ne kadar siparis gelmis
select count(order_id)
from order_details;

--toplam kac farkli siparis gelmis
select count(distinct order_id)
from order_details;

--toplam en az, en fazla ve toplam kac urun siparis edilmis
select min(quantity), max(quantity), sum(quantity)
from order_details;

select min(quantity), max(quantity), sum(quantity)
from order_details od
inner join orders o
on od.order_id = o.order_id
where o.ship_country = 'Spain';

--ilgili kategorideki ürünlerin sayisi
select count(od.product_id)
from order_details od
inner join products p
on od.product_id = p.product_id
where category_id = 1;

--kac farkli ulkeye ihracat yapiliyor
select count(distinct ship_country)
from orders;

select distinct ship_country
from orders;