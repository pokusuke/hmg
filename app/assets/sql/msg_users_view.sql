CREATE VIEW msg_users AS  

SELECT user_id, relation_id  FROM (
SELECT 
a.id AS user_id,
b.reciever_id AS relation_id
FROM users AS a
LEFT JOIN msgs AS b  b.sender_id= a.id

UNION ALL
SELECT
a.id AS user_id,
b.sender_id AS relation_id
FROM users AS a
LEFT JOIN msgs AS b ON b.reciever_id = a.id
) AS z GROUP BY z.user_id,z.relation_id HAVING relation_id IS NOT NULL;
