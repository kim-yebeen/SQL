-- 트랜젝션은 2개 이상의 각종 쿼리문의 실행을 되돌리거나 영구히 반영할 때 사용한다.
-- 연습 테이블 생성
CREATE TABLE bank_account(
	act_num INT(5) primary key auto_increment,
    act_owner varchar(10) not null,
	balance int(10) default 0 not null
);

-- 계좌 데이터 2개를 집어넣음
-- 1번유저 : 잔고 5000, 이름 나구매
-- 2번유저 : 잔고 0, 이름 가판매
insert into bank_account values
	(null, '나구매', 50000),
    (null, '가판매', 0);
    
select * from bank_account;

-- 트랜젝션 시작(시작점, rollback; 수행시 이 지점 이후의 내용을 전부 취소한다.)
-- 트랜잭션 시작 구문도 ctrl+enter로 실행해줘야함
start transaction;

-- 나구매의 돈 30000원 차감
update bank_account set balance = (balance-30000) where act_num=1;

-- 가판매의 돈 30000원 증가
update bank_account set balance = (balance+30000) where act_num=2;

-- 알고보니 25000원을 이체했어야 하는데 깜빡하고 30000원으로 해서 돌려놓으려고 함
rollback;
select * from bank_account;

-- 25000원으로 다시 차감 및 증가하는 쿼리문을 작성해주시고, 이번에는 커밋도 해보세요
start transaction;

-- 나구매의 돈 25000원 차감
update bank_account set balance = (balance-25000) where act_num=1;

-- 가판매의 돈 25000원 증가
update bank_account set balance = (balance+25000) where act_num=2;

-- 커밋 수행
commit;

-- 커밋 수행 이후에 롤백 수행해보기(커밋 이후라 돌아갈 시작지점이 없어져서 복구되지는 않음)
rollback;

-- savepoint rollback 해당 지점 전가지는 반영, 해당 지점 이후는 반영 안하는 경우 사용한다.
start transaction; -- 0번 저장 지점

-- 나구매의 돈 3000원 차감
update bank_account set balance = (balance-3000) where act_num =1;
-- 가판매의 돈 3000원 증가
update bank_account set balance = (balance+3000) where act_num=2;
-- first_tx라는 저장 지점을 새롭게 생성, 1번 저장지점
savepoint first_tx;
select * from bank_account;

-- 나구매의 돈 5000원 차감
update bank_account set balance = (balance-5000) where act_num=1;
-- 가판매의 돈 5000원 증가
update bank_account set balance = (balance+5000) where act_num=2;

-- rollback; 만 호출하면 0번 지점으로 돌아감
-- rollback to 트랜잭션 지점명; 호출시 해당 트랜잭션 지점으로 돌아감
rollback to first_tx;
select * from bank_account;