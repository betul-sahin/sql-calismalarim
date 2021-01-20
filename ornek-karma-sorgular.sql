--Kaynak: https://gist.github.com/sedayenturk/2d2f2e794200e8c5fd4038adf69b4207

--Ispanya'da bulunan musterilerin sirket adi, temsilci adi, adres ve sehir bilgileri
select company_name, contact_name, address, city, country
from customers
where country = 'Spain';

--Ispanya'da kac musteri var ?
select count(*) as musteri_sayisi
from customers
where country = 'Spain';

--Ispanya'da olmayan musteriler
select company_name, contact_name, address, city, country
from customers
where country != 'Spain'
order by company_name;

--Faks numarasını bilmediğim müşteriler
select company_name, fax
from customers
where fax is null
order by company_name;

--Madrid’de yada Londra'da bulunan müşterilerim
select company_name, contact_name, address, city, country
from customers
where city='Madrid' or city='London';

--Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
select company_name, contact_name, address, city, country
from customers
where city='México D.F.' and contact_title='Owner';

--C ile başlayan ürünlerimin isimleri ve fiyatları
select * from products
where product_name like 'C%';

--ismi ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
select first_name as adi, last_name as soyadi, birth_date as dogum_tarihi
from employees
where first_name like 'A%';

--İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
select company_name
from customers
where company_name like '%Restaurant%';

--50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
select product_name, unit_price
from products
where unit_price between 50 and 100;

--1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin, SiparişID ve SiparişTarihi bilgileri
select order_id as siparisno, order_date as siparis_tarihi
from orders
where order_date between '1996-07-01' and '1996-12-31';

--Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
select product_name, unit_price
from products
order by unit_price desc;

--Ürünlerimi en pahalıdan en ucuza doğru sıralasın, 
--ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
select product_name as urun_adi, unit_price as fiyati, units_in_stock as stok
from products
order by unit_price desc, units_in_stock asc;

--1 Numaralı kategoride kaç ürün vardır ?
select count(*) as urun_sayisi
from products
where category_id=1;

--Kaç farklı ülkeye ihracat yapıyorum?
select count(distinct country)
from customers;

--ihrac yaptigim ulkeler
select distinct country
from customers;

--En Pahalı 5 ürün
select product_name as urun_adi, unit_price as fiyati
from products
order by unit_price desc
limit 5;

--ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
select count(*) as siparis_sayisi
from customers
where customer_id='ALFKI';

--Şirketim, şimdiye kadar ne kadar ciro yapmış ?
select sum((unit_price*quantity)*(1-discount)) as ciro
from order_details;

--en pahalı urunun adı
select product_name, unit_price
from products
where unit_price = (select max(unit_price) from products);

--en az kazandıran siparis
select order_id, sum((unit_price*quantity)*(1-discount)) as en_az_kazandiran
from order_details
group by order_id
order by 2 asc
limit 1;

---Müşterilerimin içinde en uzun isimli müşteri (harf sayısı)
select company_name, char_length(company_name) as harf_sayisi
from customers
order by 2 desc
limit 1;

--calisanlarin ad, soyad ve yaslari
select first_name, last_name, age(birth_date)
from employees;

--1000 Adetten fazla satılan ürünler?
select p.product_name, sum(od.quantity) as toplam_satilan_miktar
from order_details od
inner join products p
on od.product_id = p.product_id
group by p.product_name
having sum(od.quantity)>1000;

--Hangi Müşterilerim hiç sipariş vermemiş ?
select company_name
from customers
where customer_id not in (select distinct customer_id from orders);

--ürünlerin kategorileri
select p.product_name, c.category_name
from products p
inner join categories c
on p.category_id = c.category_id
order by 1 asc; 

--Hangi tedarikçi hangi ürünü sağlıyor ?
select s.company_name as tedarikci, p.product_name as urun
from suppliers s
inner join products p
on s.supplier_id = p.supplier_id
order by 1 asc;

--Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş ?
select o.order_id as siparisno, s.company_name as kargo_sirketi, o.shipped_date as kargo_tarihi
from orders o
inner join shippers s
on o.ship_via = s.shipper_id;

--En fazla siparişi kim almış..?
select first_name, last_name, count(*) as siparis_sayisi
from orders o
inner join employees e
on o.employee_id = e.employee_id
group by first_name, last_name
order by 3 desc
limit 1;

--Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
select p.product_name, c.category_name, s.company_name as tedarikci
from products p
inner join categories c
on p.category_id = c.category_id
inner join suppliers s
on s.supplier_id = p.supplier_id
order by 1 asc; 

--91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
select c.company_name, o.order_id
from orders o
right join customers c
on o.customer_id = c.customer_id
where o.customer_id is null;

--Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
select e.first_name, e.last_name, count(o.order_id) as aldigi_toplam_siparis
from orders o
inner join employees e
on o.employee_id = e.employee_id
group by 1, 2
order by 1 asc;
