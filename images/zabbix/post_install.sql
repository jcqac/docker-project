-- CREATE JIRA DB TABLE AND RESPECTIVE USER
CREATE USER 'zabbix'@'%' IDENTIFIED BY 'G4lacT1ca';
CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%';

-- THIS SECURES THE DB INSTALLATION
ALTER USER 'root'@'localhost' IDENTIFIED BY 'V1p3r';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY 'V1p3r';
ALTER USER 'root'@'::1' IDENTIFIED BY 'V1p3r';

DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;