/*
    Get all pages containing a word or phrase
*/

SET @table_prefix = 'wp_';
SET @database = 'database_name';
SET @expression = 'expression to search';

SET @stmt_one = CONCAT('SELECT DISTINCT post.id, post.post_title, post.post_type FROM ', @database, '.', @table_prefix, 'posts AS post WHERE post.post_content LIKE "', @expression, '"\n');
SET @stmt_two = CONCAT('ORDER BY post.id DESC');

SET @sql = CONCAT(@stmt_one, @stmt_two);

PREPARE stmt from @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @stmt_one = CONCAT('SELECT DISTINCT post.id, post.post_title, post.post_type FROM ', @database, '.', @table_prefix, 'postmeta AS pm\n');
SET @stmt_two = CONCAT('INNER JOIN ', @database, '.', @table_prefix, 'posts post ON post.id = pm.post_id\n');
SET @stmt_three = CONCAT('WHERE pm.meta_value LIKE "%', @expression, '%"\n');
SET @stmt_four = CONCAT('ORDER BY post.id DESC');

SET @sql = CONCAT(@stmt_one, @stmt_two, @stmt_three, @stmt_four);

PREPARE stmt from @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
