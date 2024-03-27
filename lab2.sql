-- create database FurnitureFactory;

create table if not exists FurnitureTypes
(
    furniture_type_id serial      not null primary key check ( furniture_type_id between 1 and 9999),
    name              varchar(15) not null check ( name like '^[A-Za-zА-Яа-я-]+$' )
);

create table if not exists FurnitureModels
(
    furniture_model_id   serial       not null primary key check ( furniture_model_id between 1 and 9999),
    name                 varchar(30)  not null check ( name like '^[A-Za-zА-Яа-я-]+$' ),
    model_specifications varchar(100) not null check ( model_specifications like '^[A-Za-zА-Яа-я-]+$' )
);

create table if not exists Furniture
(
    furniture_id       serial      not null primary key check ( furniture_id between 1 and 9999),
    name               varchar(30) not null check ( name like '^[A-Za-zА-Яа-я-]+$' ),
    furniture_type_id  int         not null check ( furniture_type_id between 1 and 9999),
    price              decimal     not null check ( price between 1.00 and 1000000.00),
    furniture_model_id int         not null check ( furniture_model_id between 1 and 9999),
    stock_quantity     int         not null check ( stock_quantity between 1 and 100),

    foreign key (furniture_type_id) references FurnitureTypes (furniture_type_id),
    foreign key (furniture_model_id) references FurnitureModels (furniture_model_id)
);

CREATE TABLE IF NOT EXISTS Customers
(
    customer_id  serial      NOT NULL PRIMARY KEY CHECK (customer_id BETWEEN 1 AND 9999),
    surname      VARCHAR(30) NOT NULL CHECK (surname like '^[A-Za-zА-Яа-я-]+$'),
    name         VARCHAR(30) NOT NULL CHECK (name like '^[A-Za-zА-Яа-я-]+$'),
    patronymic   VARCHAR(30) NOT NULL CHECK (patronymic like '^[A-Za-zА-Яа-я-]+$'),
    address      VARCHAR(50) NOT NULL CHECK (address like '^[A-Za-zА-Яа-яёЁ -]+$'),
    phone_number VARCHAR(12) NOT NULL CHECK (phone_number like '^\+?[0-9]+$')
);

create table if not exists Documents
(
    document_id          serial  not null primary key check ( document_id between 1 and 9999),
    document_number      integer not null check ( document_number between 100000 and 999999),
    document_series      integer not null check ( document_number between 1000 and 9999),
    registration_address varchar(100) check ( registration_address like '^[A-Za-zА-Яа-я-]+$'),
    issued_by            varchar(100) check ( issued_by like '^[A-Za-zА-Яа-я-]+$' )
);

create table if not exists Employees
(
    employee_id  serial      not null primary key check ( employee_id between 1 and 9999),
    surname      varchar(30) not null check ( surname like '^[A-Za-zА-Яа-я-]+$' ),
    name         varchar(30) not null check ( name like '^[A-Za-zА-Яа-я-]+$' ),
    patronymic   varchar(30) check ( patronymic like '^[A-Za-zА-Яа-я-]+$' ),
    birthday     date        not null check ( birthday between '2000-01-01' and '2100-12-31'),
    address      varchar(50) not null check ( address like '^[A-Za-zА-Яа-яёЁ -]+$' ),
    phone_number varchar(12) not null check ( phone_number like '^\+?[0-9]+$' ),
    document_id  int         not null check ( document_id between 1 and 9999 ),

    foreign key (document_id) references Documents (document_id)
);

create table if not exists Orders
(
    order_id     serial not null primary key check ( order_id between 1 and 9999),
    customer_id  int    not null check ( customer_id between 1 and 9999 ),
    employee_id  int    not null check ( employee_id between 1 and 9999 ),
    furniture_id int    not null check ( furniture_id between 1 and 9999 ),
    quantity     int    not null check ( quantity between 1 and 1000 ),
    order_date   date   not null check ( order_date between '2000-01-01' and '2100-12-31' ),

    foreign key (customer_id) references Customers (customer_id),
    foreign key (employee_id) references Employees (employee_id),
    foreign key (furniture_id) references Furniture (furniture_id)
);

-- create table Test if not exists
create table if not exists Test
(
    id serial primary key,
    name varchar(100),
    date date
);

-- drop table Test
drop table if exists Test;

-- alter column name of table Test to be NOT NULL
alter table if exists Test
alter column name set not null;

-- add column locale to table Test and set its default value to 'ru'
alter table if exists Test
add column locale varchar(2) not null default 'ru';

-- drop column locale from table Test
alter table if exists Test
drop column if exists locale;

