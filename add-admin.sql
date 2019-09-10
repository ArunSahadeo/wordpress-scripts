/*
    Add an admin user
*/

SET @table_prefix = 'wp_';
SET @database = '';
SET @username = '';
SET @password = '';
SET @user_nicename = '';
SET @user_email = '';

SET @stmt_one = CONCAT('INSERT INTO ', @database, '.', @table_prefix, 'users (user_login, user_pass, user_nicename, user_email, user_registered, user_status) VALUES("', @username, '", MD5("', @password, '"), "', @user_nicename, '", "', @user_email, '", NOW(), "0");\n');
SET @stmt_two = CONCAT('INSERT INTO ', @database, '.', @table_prefix, 'usermeta (umeta_id, user_id, meta_key, meta_value) VALUES(NULL, (SELECT MAX(id) FROM ', @table_prefix, 'users), "', @table_prefix, 'capabilities", "a:1:{s:13:\'administrator\';b:1;}");\n');
SET @stmt_three = CONCAT('INSERT INTO ', @database, '.', @table_prefix, 'usermeta (umeta_id, user_id, meta_key, meta_value) VALUES(NULL, (SELECT MAX(id) FROM ', @table_prefix, 'users), "', @table_prefix, 'user_level", "10");\n');

PREPARE stmt from @stmt_one;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

PREPARE stmt from @stmt_two;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

PREPARE stmt from @stmt_three;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
