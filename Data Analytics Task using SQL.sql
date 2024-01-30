


SELECT merchant_id,case when (balance_after+balance_before)<500 then 'red' 
when (balance_after+balance_before) between 500 and 1000 then 'brown'
when (balance_after+balance_before)>1000 then 'green' end
as ZONE, action_date AS Zone_start_date, LEAD(DATEADD(DAY, 2, action_date)) OVER(ORDER BY action_date) AS Zone_end_date
FROM fawry
order by merchant_id DESC
