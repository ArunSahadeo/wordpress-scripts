/*
    Update all WordPress URLs in the DB to your local
*/

SET @table_prefix = 'wp_';
SET @database_name = 'sample_database';
SET @live_domain = 'https://example.com';
SET @local_domain = 'http://example.com';

SET @stmt_one = CONCAT('USE ', @database_name, '\n');
SET @stmt_two = CONCAT('UPDATE ', @table_prefix, 'options SET option_value = REPLACE(option_value, "', @live_domain, '", "', @local_domain, '");\n');
SET @stmt_three = CONCAT('UPDATE ', @table_prefix, 'posts SET guid = REPLACE(guid, "', @live_domain, '", "', @local_domain, '");\n');
SET @stmt_four = CONCAT('UPDATE ', @table_prefix, 'posts SET post_content = REPLACE(post_content, "', @live_domain, '", "', @local_domain, '");\n');
SET @stmt_five = CONCAT('UPDATE ', @table_prefix, 'postmeta SET meta_value = REPLACE(meta_value, "', @live_domain, '", "', @local_domain, '");\n');

SET @sql = CONCAT(@stmt_one, @stmt_two, @stmt_three, @stmt_four, @stmt_five);

PREPARE stmt from @sql;
EXECUTE stmt;
