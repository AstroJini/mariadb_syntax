-- 흐름제어 : case when, if, ifnull
-- SQL문에서는 조건문과 반복문을 자유롭게 쓸 수 없다가 전제임. (proceduer에서는 나름 자유롭게 사용가능)

-- if (a, b, c) : a조건이 참이면 b반환, 그렇지 않으면 c를 반환
select id, if(name is null, '익명사용자', name) from author;
 

-- ifnull(a, b) : a가 null이면 b를 반환, null이 아니면 a를 그대로 반환
select id, ifnull(name, '익명사용자') from author;


-- case when
select id, ifnull(name, '익명사용자') from author;

select id,
case 
    when name is null then '익명 사용자' 
    when name='hong1' then '홍길동'
    else name
end as name
from author;


-- 경기도에 위치한 식품창고 목록 출력하기

SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, IFNULL(FREEZER_YN, 'N') AS FREEZER_YN
FROM FOOD_WAREHOUSE WHERE ADDRESS LIKE '경기도%' ORDER BY WAREHOUSE_ID;


-- 조건에 부합하는 중고거래 상태 조회하기
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
CASE
    WHEN STATUS="SALE" THEN "판매중"
    WHEN STATUS= "RESERVED" THEN "예약중"
    ELSE "거래완료"
END AS STATUS
FROM USED_GOODS_BOARD
WHERE CREATED_DATE LIKE '2022-10-05%'
ORDER BY BOARD_ID DESC;

-- CASE WHEN문 사용할 때 ELSE에는 "=" 사용 금지!!! 이거때매 오류 5만8천번 남 


-- 12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME, PT_NO, GEND_CD, AGE, IFNULL(TLNO, "NONE") AS TLNO FROM  PATIENT
WHERE AGE<=12 AND GEND_CD="W" ORDER BY AGE DESC, PT_NAME;