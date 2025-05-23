-- tinyint : -128~127까지 표현
-- author 테이블에 age컬럼 변경

alter table author modify column age tinyint unsigned;
insert into author (id, emailm, age) values (6, 'abc@naver.com', 300);

-- int : 4바이트(대략 40억 숫자범위)

-- bigint : 8바이트
-- author, post 테이블의 id값 bigint 변경
alter table author modify column id bigint;

-- DECIMAL (총자릿수, 소수부 자리수)
alter table post add column price decimal(10, 3);
-- DECIMAL 소수점 초과시 잘림현상 발생생
insert into post (id, title, price, author_id) values(7, 'hello puthon,', 10.33412)

-- 문자타입: 고정길이(char), 가변길이(varchar, text)
alter table author add column gender char(10);
alter table author add column self_introduction text;

-- blob(바이너리데이터) 타입 실습
-- 일반적으로 blob으로 저장하기 보다, varchar로 설계하고 이미지 경로만을 지정함.
alter table author add column profile_image longblob;
insert into author(id, email, profile_image) values(8, 'aaa@naveer.com', LOAD_FILE('C:\'))

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role칼럼 추가
alter table author add column role enum('admin', 'user') not null default'user';
-- enum에 지정된 값이 아닌경우우
insert into author(id, email, role) values(11, 'sss@naver.com', 'admin2');
-- role을 지정 안한경우
insert into author(id, email) values(12, 'sss@naver.com');
-- enum에 지정된 값인경
insert into author(id, email, role) values(13, 'sss@naver.com', 'admin');



-- date 와 datetime
-- 날짜타입의 입력, 수정, 조회 시에 문자열 형식을 사용용
alter table author add column birthday date;
alter table post add column created_time datetime;
insert into post (id, title, author_id, created_time) values (8, 'hello', 3, '2025-05-23 14:36:30');
alter table post add column created_time datetime default current_timestamp();