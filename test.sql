-- <ORDERDB 구축>

-- 유저 테이블
create table USERTB (
    id bigint auto_increment primary key,
    name varchar(50) not null,
    role enum('seller', 'consumer') not null default 'consumer',
    password varchar(255) not null, 
    email varchar(255) not null unique,
    address varchar(255) not null
);

-- 상품 테이블
create table PRODUCTTB (
    product_num bigint auto_increment primary key,
    product_name varchar(255) not null,
    stocks int not null default 0,
    status enum('sale', 'out of stock') not null default 'out of stock',
    price int not null,
    seller_id bigint not null,
    foreign key (seller_id) references USERTB(id)
);

-- 주문 테이블
create table ORDERTB(
    order_num bigint auto_increment primary key,
    consumer_id bigint not null,
    order_time datetime default current_timestamp(),
    total_price bigint not null,
    foreign key (consumer_id) references USERTB(id)
);

-- 주문상세 테이블
create table ORDER_INS(
    order_num bigint not null,
    consumer_id bigint not null,
    product_num bigint not null,
    seller_id bigint not null,
    ordered_ea int not null,
    ordered_ea_p bigint not null,

    foreign key (order_num) references ORDERTB(order_num),
    foreign key (consumer_id) references ORDERTB(consumer_id),
    foreign key (product_num) references PRODUCTTB(product_num),
    foreign key (seller_id) references PRODUCTTB(seller_id)
);

-- 회원가입 프로시저

DELIMITER //
create procedure insert_user(in nameInput varchar(50), in roleInput enum('seller', 'consumer'), in addressInput varchar(255))
BEGIN
    declare exit handler for SQLEXCEPTION
    begin
    rollback;
    end;
    start transaction;
    insert into USERTB(name, role, address) values (nameInput, roleInput, addressInput);
    commit;
END//
DELIMITER ;

-- 상품 등록 프로시저

DELIMITER //
create procedure insert_product(in product_nameInput varchar(50), in sthocksInput , in statusInput , pri)
BEGIN
    declare exit handler for SQLEXCEPTION
    begin
    rollback;
    end;
    start transaction;
    insert into PRODUCTTBTB(product_name, stocks, status, price, seller_id) values (nameInput, roleInput, addressInput);
    commit;
END//
DELIMITER ;