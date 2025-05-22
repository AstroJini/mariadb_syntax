-- 복습하기!

-- 고객 주문내역 넣는 DB구축 해보기
-- 필요한 테이블 -고객 정보 | -고객 주문

-- 고객 정보| id, name, address, joined_at
-- 고객 주문| id(주문번호), contents(주문내역), cost(결제비용), datetime(주문시간), ordered_user

create table USER (id int primary key, name varchar(100), address varchar(255), joined_at DATETIME CURRENT_TIMESTAMP )

create table order(id int, order_number int, contents varchar(255), order_id int not null, primary key(id), foreign key(order_id) references USER(id)); 

orderdfdf