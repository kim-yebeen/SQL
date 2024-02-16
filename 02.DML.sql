/* 좌측의 schemas database는 더블클릭, 우클릭 등으로 지정 가능하지만
cli 에서는 use 스키마명;으로 호출할 수도 있습니다.*/

-- workbench(윈도우)에서 수행간으한 구문은 거의 모두 cli에서 수행 가능합니다.
use sys;
use swudb;

/* DATABASE 정보 조회*/
show databases;

-- 테이블 생성
create table user_tbl(
	user_num int(5) primary key auto_increment, -- insert시 자동 숫자 배정
    user_name varchar(10) not null,
    user_birth_year int not null,
    user_address char(5) not null,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원 가입일
    );

/* 특정 테이블은 원래 조회할 때
select *from 데이터베이스명.테이블명;
형식으로 조회해야 한다.
그러나 use 구문등을 이용해 데이터베이스를 지정한 경우는 db명을 생략할 수 있습니다.*/
select * from user_tbl;

insert into user_tbl values(null, '김자바', 1987, '서울', 180, '2021-05-03');
insert into user_tbl values(null, '이연희', 1992, '경기', 165, '2024-05-12');
insert into user_tbl values(null, '박종현', 1990, '부산', 177, '2024-06-01');
insert into user_tbl 
	(user_name, user_birth_year, user_address, user_height, entry_date) 
    values ('임영우', 1995, '광주', 180, '2001-05-03');
    
-- where 조건절을 이용해서 조회
-- 90년대 이후 출생자만 조회하기 : user_birthday_year가 1989보다 큰 유저만 조회하기
select * from user_tbl where user_birth_year > 1989;

-- 키 175미만만 조회하는 구문을 작성
select * from user_tbl where user_height<175;

-- and 혹은 or을 이용해 조건을 두 개 이상 걸 수도 있다.
select *from user_tbl where user_num > 2 or user_height < 178;

-- update from 테이블명 set 컬럼명 1 = 대입값1, 컬럼명2 = 대입값2 ... ;
-- 주의! where을 걸지 않으면 해당 컬럼의 모든 값을 다 통일시켜버립니다.
update user_tbl set user_address = '서울';

-- where절 + pk 없는 update 구문 실행 방지, 0대입시 안전모드 해제, 1대입시 안전모드 적용
set sql_safe_updates=0;

select * from user_tbl;

-- drop table은 테이블이 없는데 삭제명령을 내리면 에러 발생
drop table user_tbl;
drop table user_tbl; -- 오류발생

-- 테이블이 존재하지 않는다면 삭제구문을 실행하지 않아 에러를 발생시키지 않음
drop table if exists user_tbl;

select * from user_tbl; -- 위의 구문을 다시 실행하여 복구 시킨 후 실행

-- 1번 유저 김자바가 강원으로 이사를 감. 지역을 바꾸셈
update user_tbl set user_address='강원' where user_num=1;

-- 삭제는 특정 컬럼만 떼서 삭제할 일이 없으므로 select와 달리 *등을 쓰지 않음
-- 박종현이 db에서 삭제되는 상황, safety 모드를 끄고 user_name을 이용하라
set sql_safe_updates=1;
delete from user_tbl where user_name='박종현';

-- 만약 where절 없이 delete from 구문으로 삭제하면 truncate와 같이 테이블 구조는 유지하고 데이터만 삭제
delete from user_tbl;

-- 다중 insert 구문을 사용해보겠다.
/* insert into 테이블명(컬럼1, 컬럼2, 컬럼3...)
	values (값1, 값2, 값3 ...),
		(값4, 값5, 값6 ...),
        (값4, 값5, 값6 ...),
        ... */

insert into user_tbl
	values (null, '강개발', 1994, '경남', 178, '2024-08-02'),
			(null, '최지선', 1998, '전북', 170, '2024-08-03'),
            (null, '류가연', 2000, '전남', 158, '2024-08-20');


-- insert ~select를 이용한 데이터 삽입을 위해 user_tbl과 동일한 테이블을 하나 더 만듭니다.
create table user_tbl2(
	user_num int(5) primary key auto_increment, -- insert시 자동 숫자 배정
    user_name varchar(10) not null,
    user_birth_year int not null,
    user_address char(5) not null,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원가입일
    );
    
-- user_tbl2에 user_tbl의 자료 중 생년 1995년 이후인 사람 자료만 복사해서 삽입하기
insert into user_tbl2
	select * from user_tbl where user_birth_year > 1995;

select * from user_tbl2;

-- 두번째 테이블인 구매내역을 나타내는 buy_tbl을 생성해보겠습니다.
-- 어떤 유저가 무엇을 샀는지 저장하는 테이블입니다.
-- 어떤 유저는 반드지 user_tbnl에 존재하는 유저만 추가할 수 있습니다.
create table buy_tbl(
		buy_num int auto_increment primary key,
        user_num int(5) not null,
        prod_name varchar(10) not null,
        prod_cate varchar(10) not null,
        price int not null,
        amount int not null
        );
        
select * from user_tbl;

-- 외래키 설정 없이 추가해보겠다.
insert into buy_tbl values(null,5,'아이패드','전자기기',100,1);
insert into buy_tbl values(null, 5,'애플펜슬', '전자기기',15,1);
insert into buy_tbl values
	(null, 6,'트레이닝복','의류',10,2),
    (null,7,'안마의자','의료기기',400,1),
    (null,5,'sql책','도서',2,1);

select * from buy_tbl;

-- 있지도 않은 99번 유저의 구매내역을 넣어보겠습니다. -> 오류임.
insert into buy_tbl values(null,99,'핵미사일','전략무기',100000,5);

-- 6번 구매 내역을 삭제
delete from buy_tbl where buy_num=6;

-- 이제 외래키 설정을 통해서, 있지 않은 유저는 등록될 수 없도록 처리하겠다.
-- buy_tbl의 user_num 컬럼에 들어갈 수 있는 값은, user_tbl의 user_num 컬럼에 존재하는 값으로 한정한다.
-- buy_tbl이 user_tbl을 참조하는 관계임
			-- 참조하는 테이블 			--제약조건 이름부여			--어떤컬럼을참조
alter table buy_tbl add constraint fk_buy_tbl foreign key (user_num)
			-- 원본테이블명(컬럼명)
	references user_tbl(user_num);
    
-- 만약 user_tbl에 있는 요소를 삭제하는 경우, buy_tbl에 구매내역이 남은 user_num을 삭제한다면
-- 특별히 on_delete를 걸지 않은 경우는 참조 무결성 원칙에 위배되어 삭제가 되지 않습니다.
delete from user_tbl where user_num=5;
            
		-- 임시 테이블인 usertbl2를 조회
        select * from user_tbl2;
        
        -- delete from을 이용해서 user_tbl2의 2024-08-15일 이후 가입자를 삭제해보세요.
        -- unix 시간은 1970년 1월 1일 00시 00분 00초부터 얼마나 경과했는지로 시간을 따지므로
        -- 시점이 뒤일수록 값이 더 큽니다.
        delete from user_tbl2 where entry_date > '2024-08-15';
        
        -- delete from 을 이용해서 2024년 08월 3일 가입한 유저만 정확하게 집어서 삭제해주세요.
        set sql_safe_updates=0;
        
        -- distinct 실습을 위해 데이터를 몇개 집어넣습니다.
        insert into user_tbl values
			(null, '이자바', 1994, '서울', 178, '2024-09-01;'),
            (null, '신디비', 1992, '경기', 164, '2024-09-01;'),
            (null, '최다희', 1998, '경기', 158, '2024-09-01;');
            
select * from user_tbl;

-- distinct는 특정 컬럼에 들어있는 데이터의 "종류"만 한 번씩 나열해 보여줍니다.
-- 교안을 보고 user_birth_year와 user_address에 들어있는 데이터의 종류를 distinct를 이용해 조회
select distinct user_birth_year from user_tbl;
select distinct user_address from user_tbl;

-- 컬럼 이름을 바꿔서 조회하고 싶다면, 컬럼명 as 바꿀이름 형식을 따르면 된다.
-- user_name 컬럼을 '유저명' 이라는 이름으로 바꿔 조회해보세요.

select user_name as 유저명 from user_tbl;