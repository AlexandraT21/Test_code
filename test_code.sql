select *
from purchases

drop table if exists #all_info_tb
create table #all_info_tb (
purchaseID nvarchar(255),
UserID nvarchar(255),
itemId nvarchar(255),
date date,
Age numeric,
price float)

insert into #all_info_tb
select p.purchaseID, p.UserID, i.itemId, p.date, u.Age, i.price
from purchases as p
join users as u on u.UserID = p.UserID
join items as i on i.itemId = p.itemId

select *
from #all_info_tb


----- A 1

--new month column 
alter table #all_info_tb
add num_month as datepart(MM,date);

select *
from #all_info_tb


select num_month, convert(decimal(15,2), avg(price)) as avg_price
from #all_info_tb
where Age >= 18 and Age <= 25
group by num_month
order by num_month


----- A 2

select num_month, convert(decimal(15,2), avg(price)) as avg_price
from #all_info_tb
where Age >= 26 and Age <= 35
group by num_month
order by num_month


----- Á
select num_month, convert(decimal(15,2), sum(price)) as revenue
from #all_info_tb
where Age >= 35
group by num_month
order by revenue desc

----- Â
select itemId, convert(decimal(15,2), sum(price)) as revenue
from #all_info_tb
group by itemId
order by revenue desc

----- Ã
select top 3 itemId, 
       sum(price) as revenue,
	   convert(decimal(15,2), sum(price) / (select sum(price) from items) * 100) as percent_of_revenue
from #all_info_tb
where year(date) = '2021'
group by itemId
order by revenue desc


select top 10 itemId, 
       sum(price) as revenue,
	   convert(decimal(15,2), sum(price) / (select sum(price) from items) * 100) as percent_of_revenue
from #all_info_tb
where year(date) = '2021'
group by itemId
order by revenue desc

