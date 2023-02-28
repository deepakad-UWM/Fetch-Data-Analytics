●	What is the name of the most expensive item purchased?

select recp_items.ORIGINAL_RECEIPT_ITEM_TEXT as Name_of_the_most_expensive_item,
(recp_items.TOTAL_FINAL_PRICE/recp_items.QUANTITY_PURCHASED) as Product_Price 
from receipts as recp 
inner join receipt_items as recp_items on recp.ID=recp_items.REWARDS_RECEIPT_ID
where recp_items.QUANTITY_PURCHASED is not null and recp_items.QUANTITY_PURCHASED != '' and recp_items.QUANTITY_PURCHASED !=0.0
order by Product_Price DESC
limit 1;


●	What user bought the most expensive item?

select recp.USER_ID as User_who_purchased_most_expensive_item,
(recp_items.TOTAL_FINAL_PRICE/recp_items.QUANTITY_PURCHASED) as Product_Price 
from receipts as recp 
inner join receipt_items as recp_items on recp.ID=recp_items.REWARDS_RECEIPT_ID
where recp_items.QUANTITY_PURCHASED is not null and recp_items.QUANTITY_PURCHASED != '' and recp_items.QUANTITY_PURCHASED !=0.0
order by Product_Price DESC
limit 1;


●	How many users scanned in each month?

select COUNT(DISTINCT recp.USER_ID) as Count_of_users_scanned_each_month,
CAST(STRFTIME ('%m', recp.DATE_SCANNED) AS NUMERIC) as scan_month
from receipts as recp 
inner join receipt_items as recp_items on recp.ID=recp_items.REWARDS_RECEIPT_ID
where recp_items.QUANTITY_PURCHASED is not null and recp_items.QUANTITY_PURCHASED != '' and recp_items.QUANTITY_PURCHASED !=0.0
group by scan_month
order by scan_month ASC;


●	Which user spent the most money in the month of August?

select recp.USER_ID as User,
SUM(recp.TOTAL_SPENT) as Total_amount_spent_by_the_user_in_August,
CAST(STRFTIME ('%m', recp.PURCHASE_DATE) AS NUMERIC) as purchase_month
from receipts as recp 
inner join receipt_items as recp_items on recp.ID=recp_items.REWARDS_RECEIPT_ID
where purchase_month = 8
group by purchase_month, recp.USER_ID
order by Total_amount_spent_by_the_user_in_August DESC
limit 1;


●	Which brand saw the most dollars spent in the month of June?

select recp_items.BARCODE as BARCODE,
recp_items.BRAND_CODE as Brand,
--brd.NAME as brand name,
SUM(recp_items.TOTAL_FINAL_PRICE) as Total_amount_spent_per_Brand_in_June,
CAST(STRFTIME ('%m', recp.PURCHASE_DATE) AS NUMERIC) as purchase_month
from receipts as recp 
inner join receipt_items as recp_items on recp.ID=recp_items.REWARDS_RECEIPT_ID
--inner join brand as brd on brd.BARCODE=recp_items.BARCODE
where purchase_month = 6 and recp_items.BRAND_CODE is not null and recp_items.BRAND_CODE != ''
group by purchase_month, recp_items.BRAND_CODE
order by Total_amount_spent_per_Brand_in_June DESC
limit 1;

