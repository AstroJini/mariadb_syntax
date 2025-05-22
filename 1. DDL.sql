-- mariadb 서버에 접속
mariadb -u root -p 입력 후 비밀번호 별도 입력

-- 스키마 (database) 생성
CREATE DATABASE board;
CREATE DATABASE auThor -> 잘못된 예) 소문자로 쓰는게 관례다.

-- 스키마 삭제
drop databases 스키마명;

-- 스키마 목록 조회
show databases;

-- 스키마 선택
use 스키마명;

-- 문자 인코딩 변경
alter database board default character set = utf8mb4;
*utf8mb4에서 mb4는 emoji문자를 입력할 수 있게 해주는 character set 값이다.

-- 문자 인코딩 조회
show variables like 'character_set_server';

-- 테이블 생성
create table author(id int primary key, name varchar(255), email varchar(255) password varchar(255));

-- 테이블 목록 조회
show tables;

-- 테이블 컬럼정보 조회
describe author;

-- 테이블 생성명령문 조회
show create table author;

-- posts테이블 신규 생성 (id, title, contents, author_id)
create table posts(id int, title varchar(255), contents varchar(255), author_id int not null, primary key(id), foreign key (author_id) references author(id));

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name='posts';

-- 테이블 index 조회
show index from author;

-- alter : 테이블의 구조를 변경
-- 테이블의 이름 변경
alter table posts rename post;
-- 테이블의 컬럼 추가
alter table author add column age int;
-- 테이블 컬럼 삭제
alter table author drop column age;
-- 테이블 컬럼명 변경
alter table post change column contents content varchar(255);
-- 테이블 컬럼의 타입과 제약조건 변경 => 덮어쓰기 (덮어쓰기 때문에 제약조건을 따로 적용하는 것이 아닌 동시에 해야만 함함)
alter table author modify column email varchar(100) not null;
alter table author modify column email varchar(100) not null unique;

-- 실습 : author 테이블에 address컬럼을 추가 (varchar255)
-- post 테이블에 title은 not null로 변경, content는 길이 3000자로 변경

alter table author add column address varchar(255);
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

둘다 동시에 하는 경우
alter table post modify column title varchar(255) not null, modify column contents varchar(3000);

-- drop : 테이블을 삭제하는 명령어
drop table abc;


-- 테이블을 삭제하기 전에 show create table 테이블명; 을 해서 복제를 해둔뒤 삭제를 하면 삭제하더라도 다시 살려낼 수 있음음





-- 테이블 생성 member (admin과 일반계정을 구분하는 colummn도 포함, id, name, user_name, created_at| )