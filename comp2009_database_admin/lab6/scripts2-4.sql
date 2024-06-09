--  PART 2 -- TRANSACTION ROLLED BACK
start transaction;
	set sql_safe_updates=0;
	update accounts set balance=25001	where name='manolo';
	set sql_safe_updates=1;
	select * from accounts;
rollback;

select * from accounts;
-- PART 4 -- TRANSACTION COMMITTED
start transaction;
	set sql_safe_updates=0;
	update accounts set balance=25001 where name='manolo';
	set sql_safe_updates=1;
commit;

select * from accounts;