#!/bin/bash

# Install required packages
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https -y

# Update package list
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Install Apache, MySQL, and PHP
sudo apt-get install apache2 mysql-server php libapache2-mod-php -y
sudo apt-get install php-mysqli

# Set the database password as an environmental variable
export DATABASE_PASS='Admin@123'

# Start MySQL and enable it to start automatically on boot
sudo systemctl start mysql
sudo systemctl enable mysql

systemctl start apache2
systemctl enable apache2

# Set the root password for MySQL
sudo mysql_config_editor set --login-path=local --user=root --password


# Create a new database and table
sudo mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE users"
sudo mysql -u root -p"$DATABASE_PASS" -e "USE users;  CREATE TABLE visitors (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ip_address VARCHAR(30) NOT NULL,
    visit_time TIMESTAMP)" 

# Create a new MySQL user and grant privileges
sudo mysql --login-path=local -e "CREATE USER 'ubuntu'@'localhost' IDENTIFIED BY '$DATABASE_PASS'"
sudo mysql --login-path=local -e "GRANT ALL PRIVILEGES ON users.* TO 'ubuntu'@'localhost'; SET PASSWORD FOR 'ubuntu'@'localhost' = '$DATABASE_PASS';"
sudo mysql --login-path=local -e "GRANT GRANT OPTION ON *.* TO 'root'@'localhost';"

# Flush privileges to ensure that the new user has the correct permissions
sudo mysql --login-path=local -e "FLUSH PRIVILEGES"