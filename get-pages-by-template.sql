/*
    Get all pages using a specific template
*/

SET @table_prefix = 'wp_';
SET @template_name = 'template-name.php';
SET @stmt_one = CONCAT('SELECT * FROM ', @table_prefix, 'posts as posts\n');
SET @stmt_two = CONCAT('INNER JOIN ', @table_prefix, 'postmeta pm ON posts.id = pm.post_id\n');
SET @stmt_three = CONCAT('WHERE pm.meta_key = "_wp_page_template" AND pm.meta_value ="', @template_name, '"\n');
SET @stmt_four = CONCAT('ORDER BY posts.post_name ASC');
SET @sql = CONCAT(@stmt_one, @stmt_two, @stmt_three, @stmt_four);

PREPARE stmt from @sql;
EXECUTE stmt;
