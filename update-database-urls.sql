/*
    Update all WordPress URLs in the DB to your local
*/

SET @table_prefix = 'wp_';
SET @database = 'wordpress';
SET @live_domain = 'http://test.wp';
SET @local_domain = 'http://example.com';

SET @stmt_one = CONCAT('UPDATE ', @database, '.', @table_prefix, 'options SET option_value = REPLACE(option_value, "', @live_domain, '", "', @local_domain, '");\n');
SET @stmt_two = CONCAT('UPDATE ', @database, '.', @table_prefix, 'posts SET guid = REPLACE(guid, "', @live_domain, '", "', @local_domain, '");\n');
SET @stmt_three = CONCAT('UPDATE ', @database, '.', @table_prefix, 'posts SET post_content = REPLACE(post_content, "', @live_domain, '", "', @local_domain, '");\n');
SET @stmt_four = CONCAT('UPDATE ', @database, '.', @table_prefix, 'postmeta SET meta_value = REPLACE(meta_value, "', @live_domain, '", "', @local_domain, '");\n');

PREPARE stmt from @stmt_one;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

PREPARE stmt from @stmt_two;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

PREPARE stmt from @stmt_three;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

PREPARE stmt from @stmt_four;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
