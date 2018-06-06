SELECT *
FROM survey
LIMIT 10
;


SELECT question,
   COUNT (user_id) AS "User IDs",
   COUNT (response) AS "Responses"
  
FROM survey

GROUP BY question
;

SELECT COUNT(DISTINCT user_id)  
FROM survey
;

SELECT question AS Question,
  response AS Response,
  COUNT (response) AS "Response Count"
  
FROM survey

WHERE Question like "1.%"
GROUP BY response
ORDER BY "Response Count" DESC
;

SELECT question AS Question,
  response AS Response,
  COUNT (response) AS "Response Count"
  
FROM survey

WHERE Question like "2.%"
GROUP BY response
ORDER BY "Response Count" DESC
;

SELECT question AS Question,
  response AS Response,
  COUNT (response) AS "Response Count"
  
FROM survey

WHERE Question like "3.%"
GROUP BY response
ORDER BY "Response Count" DESC
;


SELECT question AS Question,
  response AS Response,
  COUNT (response) AS "Response Count",
  COUNT(user_id)
  
FROM survey

WHERE Question like "4.%"
GROUP BY response
ORDER BY "Response Count" DESC
;

-- LOOKING TO SEE IF COLOR CHOICE IS UNIQUE OR IF PARTICIPANTS CHOSE MORE THAN ONE COLOR.
 SELECT user_id,
   COUNT(response) AS "RES"
  
 FROM survey
 
 WHERE question like "4.%"
 
 GROUP BY user_id
 ORDER BY 2 DESC
 ;

SELECT question AS Question,
  response AS Response,
  COUNT (response) AS "Response Count",
  COUNT (user_id)
  
FROM survey

WHERE Question like "5.%"
GROUP BY response
ORDER BY "Response Count" DESC
;

SELECT *
FROM quiz
LIMIT 5
;

SELECT *
FROM home_try_on
LIMIT 5
;

SELECT *
FROM purchase
LIMIT 5
;

WITH base_table AS(
SELECT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs AS 'AB_TEST',
  b.user_id IS NOT NULL AS 'is_purchase'
	
FROM quiz as q

LEFT JOIN home_try_on as h
   ON q.user_id = h.user_id
  
LEFT JOIN purchase as b -- 'b' for buy. p is too close to q
   ON q.user_id = b.user_id
)
SELECT
   --AB_TEST,
   COUNT(user_id) as "Quiz",
    SUM(CASE WHEN is_home_try_on = 1 THEN 1 ELSE 0 END) as "Home Trial",
   SUM(CASE WHEN is_purchase = 1 THEN 1 ELSE 0 END) as    "Purchase"
  
 FROM base_table
;

WITH base_table AS(
SELECT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs AS 'AB_TEST',
  b.user_id IS NOT NULL AS 'is_purchase'
	
FROM quiz as q

LEFT JOIN home_try_on as h
	ON q.user_id = h.user_id
  
LEFT JOIN purchase as b -- 'b' for buy. p is too close to q
	ON q.user_id = b.user_id
)

SELECT
   AB_TEST,
   COUNT(user_id) as "Quiz",
    SUM(CASE WHEN is_home_try_on = 1 THEN 1 ELSE 0 END) as "Home Trial",
   SUM(CASE WHEN is_purchase = 1 THEN 1 ELSE 0 END) as    "Purchase"
  
 FROM base_table
 
 GROUP BY AB_TEST
 HAVING "Home Trial" > 0
 ORDER BY AB_TEST
 ;

SELECT model_name AS "Model Name",
   COUNT (user_id) AS Total,
   SUM(CASE WHEN color = "Elderflower Crystal" then 1 else 0 END) AS "Elderflower Crystal",
   SUM (CASE WHEN color = "Jet Black" AND style = "Women's Styles" THEN 1 ELSE 0 END) AS "Jet Black (W)",
   SUM (CASE WHEN color = "Pearled Tortoise" THEN 1 ELSE 0 END) AS "Perled Tortoise",
   SUM (CASE WHEN color = "Rose Crystal" THEN 1 ELSE 0 END) AS "Rose Crystal",
   SUM (CASE WHEN color = "Rosewood Tortoise" THEN 1 ELSE 0 END) AS "Rosewood Tortoise"
    
FROM purchase

GROUP BY model_name
ORDER BY 2 DESC

;


SELECT model_name AS "Model Name",
   COUNT (user_id) AS Total,
   SUM(CASE WHEN color = "Driftwood Fade" then 1 else 0 END) AS Driftwood,
   SUM (CASE WHEN color = "Endangered Tortoise" THEN 1 ELSE 0 END) AS "Endangered Tortoise",
   SUM (CASE WHEN color = "Jet Black" AND style = "Men's Styles" THEN 1 ELSE 0 END) AS "Jet Black (M)",
   SUM (CASE WHEN color = "Layered Tortoise Matte" THEN 1 ELSE 0 END) AS "Layered Tortoise Matte",
   SUM (CASE WHEN color = "Sea Glass Gray" THEN 1 ELSE 0 END) AS "Sea Glass Gray"
    
FROM purchase

GROUP BY model_name
ORDER BY 2 DESC

;






