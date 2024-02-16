-- user_tbl을 조회해보겠습니다.
select * from user_tbl;

-- 지금까지 배운 문법으로 수도권(서울, 경기)에 사는 사람을 쿼리문 하나로 조회하셈
select * from user_tbl where user_address = '서울' or user_address = '경기';

-- in 문법을 활용하면 좀 더 간결하게 수도권사는 사람들을 쿼리문 하나로 조회 가능
select * from user_tbl where user_address in ('서울','경기');

-- in 문법을 응용해서 구매내역이 있는 유저만 출력하라
select * from buy_tbl;

-- 힌트 : 구매내역이 있는 유저를 in 뒤쪽에 select문으로 조회
select distinct user_num from buy_tbl;
select * from user_tbl where user_num in (select distinct user_num from buy_tbl);

-- like 구문은 패턴 일치 여부를 통해 조회한다.
-- %는 와일드카드 문자로, 어떤 문자가 몇 글자가 와도 좋다는 의미
-- _는 와일드카드 문자로, 하나당 1글자가 매칭된다는 의미
-- 이름 글자수 상관없이 "희"로 끝나는 사람을 조회
select * from user_tbl where user_name like "%희";

-- _을 활용해 xx남도에 사는 사람만 조회
select * from user_tbl where user_address like '_남';

-- 이름에 '자바'가 들어가는 사람을 모두 조회하라
select * from user_tbl where user_name like '%자바';


select * from user_tbl where user_name like '_자바';

-- 키가 170 이상 180 이하인 사람을 And로도 조회해보고, between으로도 조회해보라
select * from user_tbl where user_height >= 170 and user_height <= 180;
select * from user_tbl where user_height between 170 and 180;

-- null을 가지는 데이터 생성
insert into user_tbl values
	(null, '박진영', 1990, '제주', null, '2024-10-01'),
    (null, '김혜경', 1992, '강원', null, '2024-10-02'),
    (null, '신지수', 1993, '서울', null, '2024-10-05');

-- user_heihgt이 null인 자료륿 비교연산자로 먼저 조회하라
select * from user_tbl where user_height is null; -- =null은 오류가 나고 isnull로 조회해야한다.


