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
    
)