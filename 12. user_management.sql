-- 사용자 관리
-- 사용자 목록조회
 select * from mysql.user;

-- 사용자 생성
create user 'jini'@'%' identified by '4321';
-- dockerdb로 들어갈 때는 localhost로 들어갈 수 없음 내 local컴퓨터가 아니기 때문에

-- 사용자에게 권권한부여
-- 특정 스키마와 테이블에 대하여 
grant select on board.author to 'jini'@ '%';
grant select, insert on board.* to 'jini'@'%';
grant all privileges on board.* to 'jini'@'%';
grant select on board.author to 'jini'@ '%';

-- 사용자 권한 회수
revoke select on board.author from 'jini'@'%';
-- 사용자 권한 조회
show grants for 'jini'@'%';

-- 사용자 계정삭제
drop user 'jini'@'%';