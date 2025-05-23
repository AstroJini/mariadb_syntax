<post>
select * from post;
select * from post where title like '%hello%';

select * from post where title regexp '[a-z]';

select cast(20250523 as date);

select cast('20250523' as date);

select cast('12' as unsigned);

select * from post where created_time like '2025-05%';


select * from post;


select * from post where cast( date_format(created_time, '%m')as unsigned)=5;



select * from post where date_format(created_time, '%Y') = '2025';
select * from post where date_format(created_time, '%m') = '05';
select * from post where date_format(created_time, '%d') = '23';

select * from post where created_time >= '2025-05-01' and created_time <= '2025-05-25';

select * from post where created_time >= '2025-05-22' and created_time < '2025-05-23 23:59:59';

select * from post where cast( date_format(created_time, '%m')as unsigned)=5;

select now();



<author>

select * from author;
alter table author add column birthday date;
describe author;
select * from author where id>=2 and id<=4;
select * from author where id between 2 and 4;