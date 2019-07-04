/*
    Get all pages using an attachment
*/

SET @table_prefix = 'wp_';
SET @database = 'database_name';

SET @stmt_one = CONCAT('SELECT attachment.id, attachment.post_title AS attachment_title, attachment.guid AS attachment_filename, (SELECT post_title FROM ', @database, '.', @table_prefix, 'posts WHERE id = attachment.post_parent) AS post_title, (SELECT guid FROM ', @database, '.', @table_prefix, 'posts WHERE id = attachment.post_parent) AS post_slug FROM ', @database, '.', @table_prefix, 'posts as attachment\n'); 
SET @stmt_two = CONCAT('WHERE attachment.post_type = "attachment" AND attachment.post_parent > 0\n');
SET @stmt_three = CONCAT('ORDER BY attachment.id ASC');

SET @sql = CONCAT(@stmt_one, @stmt_two, @stmt_three);

PREPARE stmt from @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
