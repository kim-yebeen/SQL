-- GROUP BY는 기준컬럼을 하나 이상 제시할 수 있고, 기준컬럼에서 동일한 값을 가지는 것 끼리
-- 같은 집단으로 보고 집계하는 쿼리문입니다.
-- SELECT 집계컬럼명 FROM 테이블명 GROUP BY 기준컬럼명;

-- 지역별 평균 키를 구해보겠습니다.(지역정보 : user_address)
SELECT * FROM user_tbl;

SELECT 
	user_address AS 지역명,
    AVG(user_height) AS 평균키
FROM 
	user_tbl
GROUP BY
	user_address;
    
-- 생년별 인원수alter
-- 생년, 인원수 컬럼이 노출되어야 함

select
	user_birth_year as 생년,
    count(user_num) as 인원수 -- 뭘 넣든 상관 없으나, PK를 넣어줌
from 
	user_tbl
group by
	user_birth_year;


-- user_tbl 전체에서 가장 큰 키, 가장 빠른 출생년도가 각각 무슨 값인지 구해주세요.
-- gorupo by 없이 집계함수를 사용

select
	max(user_height) as 가장큰키,
    min(user_birth_year) as 가장빠른출생년도
from 
	user_tbl;
    
-- having을 써서 거주자가 2명 이상인 지ㅕ역 카운드
-- 거주지별 생년평균도 같이 보여주라
select
	user_address as 거주지역,
    count(user_num) as 인원수
from
	user_tbl
group by
	user_address
having
	count(user_address)>=2;


-- having 사용 문제
-- 생년 기준으로 평균 키가 160 이상인 생년만 출력해주세요.
-- 생별 평균 키도 출력해주세요.
select
	user_birth_year as 생년,
    avg(user_height) as 생별평균키
from
	user_tbl
group by
	user_birth_year
having
	avg(user_height) >= 160;