--urunlerin fiyat analizi
select product_name as urun_adi,
(select min(unit_price) from order_details where product_id=products.product_id) as en_dusuk_fiyat,
(select max(unit_price) from order_details where product_id=products.product_id) as en_yuksek_fiyat,
(select avg(unit_price) from order_details where product_id=products.product_id) as ortalama_fiyat
from products
order by product_name

--urun en cok hangi ay satildi ?
select product_name as urun_adi,
(select sum(quantity) from order_details where product_id=products.product_id) as toplam_adet,
(select 
 extract(month from o.order_date) as ay
 from order_details od
 inner join orders o
 on o.order_id=od.order_id
 group by 1
 order by sum(od.quantity) desc
 limit 1
) as en_cok_hangi_ay
from products
order by product_name
