-- =====================================================
-- PROJECT 5 : A/B Testing PRODUCT ANALYTICS
-- Dataset  : Custom A/B Testing Dataset
-- Author   : Amit Kumar
-- Tool     : MySQL
-- =====================================================

create  database AB_Testing;
use ab_testing;

-- SECTION 1 : BUSINESS OVERVIEW
-- Query 1 : Total Customers
select
count(distinct user_id) as Total_users
from ab_testing;

-- Query 2 : Total Amount
select
sum(revenue) as Total_Amount
from ab_testing;

-- Query 3 : Variant or Traffic Analysis
select
variant,
count(distinct user_id) as Users
from ab_testing
group by 1;

-- Query 4 :   Total users by Variant, Buyers by Variant, Total Renvenue by variant then  conversation rate 
select
variant,
count(distinct user_id) as users,
count( distinct case when converted = 1 then user_id else 0 end) as Buyers,
sum(  case when converted = 1 then revenue else 0 end) as Total_Amount_Buyers,
round(count( distinct case when converted = 1 then user_id else 0 end)*100/count(distinct user_id),2) as conversation_rate
from ab_testing
group by 1
order by 3;

-- Query 5 : Total  Amount by Buyers, APRU,Avg Amount by Buyer
select
variant,
count(distinct user_id) as users,
count( distinct case when converted = 1 then user_id end) as Buyers,
sum(  case when converted = 1 then revenue else 0 end) as Total_Amount_Buyers,
round(sum(  case when converted = 1 then revenue else 0 end)/count(distinct user_id),2) as ARPU,
round(sum(  case when converted = 1 then revenue else 0 end)/count( distinct case when converted = 1 then user_id end),2) as Avg_Amount_By_Buyer
from ab_testing
group by 1
order by 4 desc;
SELECT
variant,
ROUND(avg(  case when converted = 1 then revenue else 0 end),2) AS arpu
FROM ab_testing
GROUP BY variant;

-- Query 6 :  Device Analysis
select
variant,
device,
count(distinct user_id) as users,
count( distinct case when converted = 1 then user_id end ) as Buyers,
sum(  case when converted = 1 then revenue else 0 end) as Total_Amount_Buyers,
round(count( distinct case when converted = 1 then user_id else 0 end)*100/count(distinct user_id),2) as Device_conversation_Rate
from ab_testing
group by 1,2
order by 6 desc;

-- Query 7 : Country Analysis
select
variant,
country,
count(distinct user_id) as users,
count( distinct case when converted = 1 then user_id  end) as Buyers,
sum(  case when converted = 1 then revenue else 0 end) as Total_Amount_Given_by_Buyers,
round(count( distinct case when converted = 1 then user_id else 0 end)*100/count(distinct user_id),2) as Country_conversation_Rate
from ab_testing
group by 1,2
order by 6 desc;

-- Query 1 :  Uplift Analysis
select
variant,
count(distinct user_id) as users,
count( distinct case when converted = 1 then user_id else 0 end) as Buyers,
sum(  case when converted = 1 then revenue else 0 end) as Total_Amount_Buyers,
round(count( distinct case when converted = 1 then user_id else 0 end)*100/count(distinct user_id),2) as conversation_rate
from ab_testing
group by 1
order by 3;


WITH rates AS
(
SELECT
variant,
Round(100.0*SUM(converted)/COUNT(*),2) as conversion_rate
FROM ab_testing
GROUP BY variant
)
SELECT *
FROM rates;








