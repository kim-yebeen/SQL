-- order by는 select 문의 질의결과를 정렬할 때 사용한다.
-- order by절 다음에는 어떤 컬럼을 기준으로 어떤 방식으로 정렬할지 적어줘야 한다.

-- 다음은 user_tbl에 대해 키순으로 내림차순 정렬한 예시이다.
select * from user_tbl order by user_height desc;

-- 문제
-- user)tbl에 대해 키순으로 오름차순 정렬, 키가 동률이라면 체중으로 내림차순 정렬
select * from user_tbl order by user_height, user_weight desc;

-- 이름을 가나다라 순으로 정렬하되, user_name대신 un 이라는 별칭을 써서 정렬
select user_num, user_name as un, user_birth_year, user_address
from user_tbl
order by un desc;

-- 컬럼 번호를(왼쪽부터 1번부터 시작, 우측으로 갈수록 1씩 증가) 이용해서도 정렬 가능합니다.
select user_num, user_name as un, user_birth_year, user_address
	from user_tbl
    order by 3 desc;
    
-- 지역별 키 평균을 내림차순으로 정렬하여 보여주세요.
select user_address, avg(user_height) as uh 
from user_tbl
group by user_address
order by uh desc;

-- case, when 절을 써서 작성, 조건에 맞지 않는 경우 else null로 처리하면 null 값이 들어간다.
-- 1992 년생만 키를 기준으로 내림차순 정렬. 나머지 지역은 정렬 기준이 없음.
select user_name, user_birth_year, user_address, user_height, user_weight
from user_tbl
order by
	case user_address -- 지역컬럼에서
		when '경기' then user_height
        else null
        end desc;

-- 생년도가 1992년인 사람은 키 기준 오름차순,
-- 생년도가 1998인 사람은 이름 기준 오름차순으로 정렬해 출력
-- 나머지들은 조건을 적용받지 않는다.
select *
from user_tbl
order by
	case user_birth_year 
		when 1992 then user_height
		when 1998 then user_name
    else null
    end desc;

