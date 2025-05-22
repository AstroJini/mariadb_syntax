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
