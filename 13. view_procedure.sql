-- view :  설치 데이터를 참조만 하는 가상의 테이블, SELECT만 가능.
-- 사용목적: 1) 복잡한 쿼리를 사전생성, 2) 테이블의 컬럼까지 권한 분리할 수 있다(권한분리)

-- view 생성
create view author_for_view as select name, email from author;

-- view 조회
select * from author_for_view;

-- view 권한부여
grant select on board.author_for_view to '계정명'@'%';

-- view 삭제
drop view author_for_view;


-- procedure 생성
DELIMITER(구분자라는 뜻) 

DELIMITER //
create procedure hello_procedure()
begin
    select "hello world";
end
// DELIMITER ;

-- procedure 호출
call hello_procedure();

-- procedure 삭제
drop procedure hello_procedure;

-- 회원목록 조회 : 한글명 프로시저 가능
DELIMITER //
create procedure 회원목록조회()
begin
    select * from author;
end
// DELIMITER ;

-- 회원상세 조회 :input값 사용 가능
DELIMITER //
create procedure 회원상세조회(in emailInput varchar(255))
begin
    select * from author where email = emailInput;
end
// DELIMITER ;

-- 글쓰기 : declare는 무조건 begin밑에 위치치
DELIMITER //
create procedure 글쓰기(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255))
BEGIN
    declare authorIdInput bigint;
    declare postIdInput bigint;
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
        select id into authorIdInput from author where email = emailInput;
        insert into post(title, contents) values (titleInput, contentsInput);
        select POST_id into postIdInput from post order by POST_id desc limit 1;
        insert into author_post(author_id, POST_id) values(authorIdInput, postIdInput);
        commit;
END //
DELIMITER ;
-- 글삭제
DELIMITER //
create procedure 글쓰기(in postidInput bigint, in emailInput varchar(255))
BEGIN
    declare authorId bigint;
    declare authorPostCont bigint;
    select count(*) into authorPostCount from author_post where POST_ID= postIdInput;
    select id into authorId from author where email = emailInput;
    -- 글쓴이가 나 밖에 없는 경우 : author_post 삭제, post까지 삭제
    -- 글쓴이가 나 이외에  다른 사람도 있는 경우 : author_post만 삭제
    if authorPostCount=1 then
    -- elseif도 사용 가능
        delete from author_post where author_id = authorId and POST_ID = postidInput;
        delete from post where id=postidInput;
    else
        delete from author_post where author_id = authorId and POST_ID = postidInput;
    end if;

END //
DELIMITER ;

-- 반복문을 통한 post 대량생성
DELIMITER //
create procedure 대량 글쓰기(in countInput bigint, in emailInput varchar(255));
BEGIN
    declare authorIdInput bigint;
    declare postIdInput bigint;
    declare countValue bigint default 0;
    while countValue<countInput do --조건식
        select id into authorIdInput from author where email = emailInput;
        insert into post(title) values ("안녕하세요");
        select POST_id into postIdInput from post order by POST_id desc limit 1;
        insert into author_post(author_id, POST_id) values(authorIdInput, postIdInput);
        set countValue = countValue+1;
    end while;

END
// DELIMITER ;