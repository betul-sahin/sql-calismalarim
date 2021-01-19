--sehirlere gore alinan siparisleri toplam olarak listeleme
select o.ship_city as sehir, 
count(o.order_id) as siparis_sayisi,
sum(od.quantity) as satilan_urun_adedi,
sum((od.unit_price*od.quantity)*(1-od.discount)) as toplam_tutar
from orders o
inner join order_details od
on o.order_id = od.order_id
group by o.ship_city
order by 1;

--urun kategorilerine gore siparis dagilimi
select c.category_name as kategori,
count(o.order_id) as siparis_sayisi,
sum(od.quantity) as satilan_urun_adedi,
sum((od.unit_price*od.quantity)*(1-od.discount)) as toplam_tutar,
from orders o
inner join order_details od
on o.order_id = od.order_id
inner join products p
on p.product_id = od.product_id
inner join categories c
on c.category_id = p.category_id
group by c.category_name
order by 1;

--yillara gore siparis dagilimi
select extract(year from o.order_date) as yil,
extract(month from o.order_date) as ay,
case
	when extract(month from o.order_date)=1 then 'ocak'
	when extract(month from o.order_date)=2 then 'subat'
	when extract(month from o.order_date)=3 then 'mart'
	when extract(month from o.order_date)=4 then 'nisan'
	when extract(month from o.order_date)=5 then 'mayıs'
	when extract(month from o.order_date)=6 then 'haziran'
	when extract(month from o.order_date)=7 then 'temmuz'
	when extract(month from o.order_date)=8 then 'ağustos'
	when extract(month from o.order_date)=9 then 'eylül'
	when extract(month from o.order_date)=10 then 'ekim'
	when extract(month from o.order_date)=11 then 'kasım'
	when extract(month from o.order_date)=12 then 'aralık'
end as ay_adi,
count(o.order_id) as siparis_sayisi,
sum(od.quantity) as satilan_urun_adedi,
sum((od.unit_price*od.quantity)*(1-od.discount)) as toplam_tutar
from orders o
inner join order_details od
on o.order_id = od.order_id
group by 1, 2
order by 3;

--navlun bedeli belli bir rakamin uzerinde gonderilen siparisler
select order_id as siparis_no,
ship_country as ihrac_edilen_ulke,
case
	when freight > 30 then '30 ustu'
	when freight < 30 then '30 altı'
end as navlun_bedeli
from orders;

--ortalama teslimat suresi
select 
order_id as siparis_no,
order_date as siparis_tarihi,
shipped_date as kargolandigi_tarih,
shipped_date - order_date as teslimat_suresi
from orders;

select
min(shipped_date - order_date) as enkisa_teslimat_suresi,
max(shipped_date - order_date) as enuzun_teslimat_suresi,
avg(shipped_date - order_date) as ortalama_teslimat_suresi
from orders;

--teslimat suresi 4 günü gecen musterilerin analizi
select
c.company_name as firma,
c.contact_name as yetkili,
order_id as siparis_no,
order_date as siparis_tarihi,
shipped_date as kargolandigi_tarih,
shipped_date - order_date as teslimat_suresi,
case
	when (shipped_date - order_date)>=4 then '4 gunun uzerinde'
	when (shipped_date - order_date)<4 then '3 gün icinde'
end as gec_kargolananlar
from orders o
inner join customers c
on o.customer_id = c.customer_id;

--teslimat suresi 4 gunu gecen musterilerin siparisleri
select
c.company_name as firma,
avg(shipped_date - order_date) as teslimat_suresi,
count(o.order_id) as siparis_sayisi,
sum((od.unit_price*od.quantity)*(1-od.discount)) as toplam_tutar
from orders o
inner join customers c
on o.customer_id = c.customer_id
inner join order_details od
on od.order_id = o.order_id
group by 1
having avg(shipped_date - order_date) > 4
order by 2 desc;