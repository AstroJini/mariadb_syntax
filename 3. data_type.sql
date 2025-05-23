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
-- DECIMAL 소수점 초과시 잘림현상 발생
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


-- 비교연산자
select * from author where id>=2 and id<=4;
select * from author where id between 2 and 4; --위 구문과 같은 구문
select * from author where id in(2, 3, 4);
select * from author where id not in(2, 3, 4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위한 키워드
select * from post where title like '%h'
select * from post where title like '%h'
select * from post where title like '%h%'

-- regexp : 정규 표현식을 활용한 조회
select * from post where title regexp '[a-z]'; --하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]'; --하나라도 한글이 있으면


-- 숫자 -> 날짜
select cast(20250523 as date) (from author); -- 2025-05-23 | from을 사용해도 괜찮다.
-- 문자 -> 날짜
select cast('20250523' as date) (from author); -- 2025-05-23 | from을 사용해도 괜찮다.
-- 문자 -> 숫자
select cast('12' as signed) --signed unsigned 중에 하나 사용하면 된다다
select cast('12' as int) --int를 쓰면 안되는 경우도 있음 예를들면 코테

-- 날짜조회 방법 : 2025-05-23 14:30:25
-- like패턴, 부등호 활용, date_format
select * from post where created_time like '2025-05%'; --문자열처럼 조회
select * from post where created_time >= '2025-05-01 00:00:00' and created_time < '2025-05-31 00:00:00'; --범위를 지정하여 조회
-- *뒤에 오는 시간 값까지 비교하고 있기에 뒤에 오는 시간은 하루 뒤로 조회한다. | 또한 날짜만 입력시 시간까지 자동으로 기입되기때문에 주의해야한다!!!!!!!!
--  | 본래 실 데이터는 시분초까지 나온다. 하지만, 데이터의 범위가 크거나 같은걸 조회 했기 때문에 시분초를 입력하지 않더라도 해당일에 포함되어 조회가 가능하다.

-- date format 활용
--Y와 H는 무조건 대문자로 사용해야함
select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H-%i-%s') from post;

select * from post where date_format(created_time, '%Y') = '2025';--연도
select * from post where date_format(created_time, '%m') = '05';--연도
select * from post where date_format(created_time, '%d') = '23';--날짜

select * from post where cast( date_format(created_time, '%m')as unsigned)=5;