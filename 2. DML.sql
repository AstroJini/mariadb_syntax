-- insert : 테이블에 데이터 삽입
insert into 테이블명 (컬럼1, 컬럼2, 컬럼3) values (데이터1, 데이터2, 데이터3)
insert into author (id, name, email) values (3, 'hong3', 'hong3@naver.com'); --문자열은 일반적으로 작은 따옴표를 사용한다. '

-- update : 테이블의 데이터 변경
update author set name="홍길동", email="hong100@naver.com" where id=3;

-- select : 조회
select 컬럼1, 컬럼2 from 테이블명;
select name, email from author;
select * from author;

-- delete : 삭제
delete from 테이블명 where 테이블명;
delete from author where id=3;

-- select 조건절 활용 조회
-- 테스트 데이터 삽입
-- insert문을 활용해서 author 데이터 3개, post데이터 5개



insert into author (id, name, email, password) values (3, "홍길동3", "hong3@naver.com", "1234" where id=3);
insert into author (id, name, email, password) values (3, "홍길동4", "hong3@naver.com", "1234" where id=4);
insert into author (id, name, email, password) values (3, "홍길동5", "hong3@naver.com", "1234" where id=5);




--정답
select * from author; --어떤 조회조건없이 모든 컬럼 조회
select * from author where id=1; --where 뒤에 조회조건을 통해 filtering
select * from author where name='홍길동동';
select * from author where id>3;
select * from author where id>2 and name='홍길동4';


-- 중복 제거 조회 : distinct
select name from author;
select distinct name from author;

-- 정열 : order by + 컬럼명
-- asc : 오름차순 | desc : 내림차순 | 안붙이면 오름차순(default) |각 자리마다 비교한 다음에 오름차순으로 정리함
-- 아무런 정렬조건 없이 조회할 경우에는 pk기준으로 오름차순
select * from author;
select * from author order by name;
