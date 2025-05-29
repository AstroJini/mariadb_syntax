-- <ORDERDB 구축>

-- 유저 테이블
create table USERTB (
    id bigint auto_increment primary key,
    name varchar(50) not null,
    role enum('seller', 'consumer') not null default 'consumer',
    address varchar(255) not null
)

-- 상품 테이블
create table PRODUCTTB (
    id bigint auto_increment primary key,
    product_name varchar(255) not null,
    stocks int not null default 0,
    status enum('sale', 'out of stock') not null default 'out of stock',
    seller 
)