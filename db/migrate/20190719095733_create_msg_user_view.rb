class CreateMsgUserView < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW msg_users AS
        SELECT user_id, relation_id  FROM (
          SELECT 
          a.id AS user_id,
          b.reciever_id AS relation_id
          FROM users AS a
          LEFT JOIN msgs AS b ON b.sender_id = a.id
          
          UNION ALL
          SELECT
          a.id AS user_id,
          b.sender_id AS relation_id
          FROM users AS a
          LEFT JOIN msgs AS b ON b.reciever_id = a.id
        ) AS z GROUP BY z.user_id,z.relation_id HAVING relation_id IS NOT NULL
        
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW msg_users
    SQL
  end
end
