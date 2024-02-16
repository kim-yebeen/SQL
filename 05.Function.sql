-- 영어로 된 사람을 추가해보겠습니다.
select * from user_tbl;

insert into user_tbl values
	(null, 'alex', 1986, 'NY', 173, '2024-11-01'),
    (null, 'Smith', 1992, 'Texas', 181, '2024-11-05'),
    (null, 'Emma', 1995, 'Tampa', 168, '2024-12-13'),
    (null, 'JANE', 1986, 'LA', 157, '2024-12-15');

-- 문자열 함수를 활용해서, 하나의 컬럼을 여러 형식으로 조회해보겠다.
select
	user_name,
    upper(user_name) as 대문자유저명,
    lower(user_name) as 소문자유저명,
    length(user_name) as 문자길이,
    substr(user_name, 1, 2) as 첫2글자,
    concat(user_name, ' 회원이 존재합니다.' ) as 회원목록
from  user_tbl;

-- 이름이 4글자 이상인 유저만 출력
-- length()는 byte길이로 글자수를 산정하므로 한글은 한 글자에 3바이트로 간주한다.
-- 따라서 length() 대신 char_length()을 이용하면 언어 상관없이 글자를 하나씩 세준다.
select * from user_tbl where char_length(user_name) > 3;

-- 함수 도움 없이 4글자만 뽑는 방법
select * from user_tbl where user_name like '____';

-- 함수 도움 없이 4글자 이상만 뽑는 방법
select * from user_tbl where user_name like '____%';

-- alter table을 이용해서 user_tbl에 소수점 아래를 저장받을 수 있는 컬럼을 추가해보겠습니다.
-- decimal은 고정자리수이므로 반드시 소수점 아래 2자리까지 표시해야합니다.
-- 전체 3자리 중, 소수점 아래에 2자리, 정수 부분은 1자리 배정하겠다
alter table user_tbl add(user_weight decimal(3,2)); -- 없던걸 추가하는 것은 add
alter table user_tbl modify user_weight decimal(5,2); -- 있던 걸 변경하는 것은 modify
select * from user_tbl;

-- 10번 유저의 체중을 52.12로 바꿔보겠습니다.
update user_tbl set user_weight = 52.12 where user_num=10;

-- 숫자 함수 사용 예제
select
	user_name, user_weight,
    round(user_weight, 0) as 체중반올림,
    truncate(user_weight, 1) as 체중소수점아래1자리절사,
    mod(user_height, 150) as 키_150으로나눈나머지,
    ceil(user_height) as 키올림,
    floor(user_height) as 키내림,
    sign(user_height) as 양수음수0여부,
    sqrt(user_height) as 키제곱근
from user_tbl;

-- 날짜함수를 활용한 예제
select
	user_name, entry_date,
    date_add(entry_date, interval 3 month) as _3개월후,
    last_day(entry_date) as 해달월마지막날짜,
    timestampdiff(day, entry_date, str_to_date('2024-08-01', '%Y-%m-%d')) as 오늘과의일수차이
from
	user_tbl;
    
-- 현재 시간을 조회하는 구문
select now();

-- 변환 함수를 활용한 예제
select 
	user_num, user_name, entry_date,
    date_format(entry_date, '%Y%m%d') as 일자표현변경,
	cast(user_num as char) as 문자로바꾼회원번호
from 
	user_tbl;
    
-- user_height, user_weigh이 null인 자료를 추가해보겠습니다.
insert into user_tbl values(null, '임쿼리', 1986, '제주', null, '2025-01-03', null);

select * from user_tbl;

-- ifnull()을 이용해서 특정 컬럼의 값이 null인 경우 대체값으로 표현하는 예제
select
	user_name,
    user_height, user_weight,
    ifnull(user_height, 167) as _NULL대신평균키,
    IFNULL(user_weight, 65) as _NULL대신평균체중
from
	user_tbl;

-- 