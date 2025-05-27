-- read uncommitted : 커밋되지 않은 데이터 read가능 -> 커밋 되지 않은 데이터까지 다 읽어버려서 쓸모없는 READ가 많음 이를 dirty read 라고 함 
-- dirty read 문제 발생
-- 실습절차
-- 1) 워크벤치에서 auto_commit 해제. update 후, commit하지 않음.(transaction1)
-- 2) 터미널을 열어 select했을 때 위 변경사항이 읽히는 지 확인(transaction2)
-- 결론 : mariadb는 기본이 repeatable read이므로 dirty read 발생하지 않음.


-- read committed : 커밋한 데이터만 read 가능 ->phantom read 발생(또는 non-repeatable read)
-- worck 벤치에서 실행
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에서 실행 
insert into author (email) values("xxxxxx@naver.com");
-- 위 코드들을 순서대로 진행한 후 count(*)를 다시 조회 해보면 조회 하지 않았던 카운트가 하나 늘어나게 됨 이것이 phantom read임.


-- repeatable read : phantom read 해결(읽기의 일관성 보장) -> lost update 문제 발생 -> 배타적 잠금으로 해결.
-- lost update 문제 발생
DELIMITER //
create procedure concurrent_test1()
BEGIN
    declare count int;
    start transaction;
    insert into post(title, author_id) values ('hello world', 1);
    select post_count into count from author where id=1;
    doseleep(15);
    update author set post_count = count+1 where id = 1;
    commit;
END//
DELIMITER ;
-- 터미널에서는 아래코드 실행
select post_count from author where id=1;


-- lost update 문제 해결 : select for update시에 트랜잭션이 종료 후에 특정 행에 대한 lock이 풀림
DELIMITER //
create procedure concurrent_test2()
BEGIN
    declare count int;
    start transaction;
    insert into post(title, author_id) values ('hello world', 1);
    select post_count into count from author where id=1 for update;
    doseleep(15);
    update author set post_count = count+1 where id = 1;
    commit;
END//
DELIMITER ;
-- 터미널에서는 아래코드 실행
select post_count from author where id=1 for update;


-- 위 코드 실행시 처음에 concurrent_test1 트랜잭션이 실행중인데 터미널에 post_count를 조회하면 동시성 이슈가 발생하는 것을 막고자 concurrent_test1의
-- select 문에 lock을 걸어서 update가 끝날 때까지 조회가 불가능 하게 만들기 때문에 터미널로 입력한 명령은 대기 상태가 된다. 
-- concurrent_test1이 모두 실행되고 난 뒤 비로소 터미널 명령어가 실행된다.

-- serializable : 모든 트랜잭션 순차적 실행  -> 동시성 문제 없음 but, 성능 저하