-- 1) найти сотрудников, которые родились в 2002 году
select surname    as Фамилия,
       name       as Имя,
       patronymic as Отчество,
       birthday   as ДатаРождения
from employees
where birthday between '2002-01-01' and '2002-12-31';

-- 2) посчитать сумму всех продаж на февраль
select sum(price) as СуммаПродажЗаФевраль
from orders
where order_date between '2024-02-01' and '2024-02-29';

-- 3) получить название типа мебели, у которого id = 4
select name as Название
from furniture;

-- 4) найти все продажи, у которых общая сумма больше чем среднее арифметическое всех продаж
select order_id as НомерЗаказа,
       price    as Цена
from orders
where price > (select avg(price) from orders);

-- 5) получить полную иноформацию о мебели
select f.name as НазваниеМебели,
       ft.name as ТипМебели,
       fm.name as МодельМебели,
       fm.model_specifications as СпецификацияМодели
from furniture f
         inner join public.furnituremodels fm on fm.furniture_model_id = f.furniture_model_id
         inner join public.furnituretypes ft on ft.furniture_type_id = f.furniture_type_id;

-- 6) получить количество сотрудников, сгруппированное по их годам рождедения
select extract(year from e.birthday) as ГодРождения,
       count(o.order_id)          as КоличествоПродаж
from employees e
         join orders o on e.employee_id = o.employee_id
group by ГодРождения;

-- 7) получить паспортные данные сотрудника с фамилией, похожей на 'Смирнов'
select e.surname as Фамилия,
       e.name as Имя,
       e.patronymic as Отчество,
       d.document_series as Серия,
       d.document_number as Номер
from employees e
         inner join public.documents d on d.document_id = e.document_id
where e.surname like '%Смирнов%';

-- 8) получить покупателей по фамилии продавца
select c.surname as Фамилия,
       c.name as Имя,
       c.patronymic as Отчество
from customers c
         join public.orders o on c.customer_id = o.customer_id
         join public.employees e on e.employee_id = o.employee_id
where e.surname like '%Смирнов%';

-- 9) получить полную информацию по продажам, где количество проданной мебели >= 3
select concat(c.surname, ' ', c.name, ' ', c.patronymic) as ФИОПокупателя,
       f.name as НазваниеМебели,
       o.price as ЦенаПродажи,
       o.quantity as Количество,
       concat(e.surname, ' ', e.name, ' ', e.patronymic) as ФИОПродавца
from orders o
         join public.customers c on c.customer_id = o.customer_id
         join public.employees e on e.employee_id = o.employee_id
         join public.furniture f on f.furniture_id = o.furniture_id
where o.quantity >= 3;

-- 10) получить ФИО сотрудников, прописанных в Москве
select concat(e.surname, ' ', e.name, ' ', e.patronymic) as ФИОСотрудника,
       d.registration_address as Прописка
from employees e
         join public.documents d on d.document_id = e.document_id
where d.registration_address like '%Москва%';
