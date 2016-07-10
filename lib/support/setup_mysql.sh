## MySQL

MYSQL_ROOT_PASSWD=vagrantmysql
MYSQL_USERNAME=cupboard
MYSQL_USERPASS=cupboardmysql
MYSQL_DATABASE_DEV=cupboard_dev
MYSQL_DATABASE_TEST=cupboard_test
MYSQL_DATABASE_PROD=cupboard_prod

## install
#echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWD" | debconf-set-selections
#echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWD" | debconf-set-selections
#aptitude -yq install mysql-server mysql-client redis-server

## create db, user and grant
mysql -u root "-p$MYSQL_ROOT_PASSWD" <<EOF
CREATE DATABASE $MYSQL_DATABASE_DEV;
CREATE DATABASE $MYSQL_DATABASE_TEST;
CREATE DATABASE $MYSQL_DATABASE_PROD;
CREATE USER '$MYSQL_USERNAME'@'localhost' IDENTIFIED BY '$MYSQL_USERPASS';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_DEV}.* TO '$MYSQL_USERNAME'@'localhost';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_TEST}.* TO '$MYSQL_USERNAME'@'localhost';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_PROD}.* TO '$MYSQL_USERNAME'@'localhost';
FLUSH PRIVILEGES;
EOF
