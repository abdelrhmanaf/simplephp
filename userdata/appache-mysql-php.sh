#!/bin/bash
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https -y
sudo apt update
sudo apt upgrade -y
sudo apt-get install apache2 mysql-server php libapache2-mod-php -y
sudo apt install php8.2-mysql php8.2-mbstring php8.2-xml php8.2-curl  -y


DATABASE_PASS='admin123'
sudo apt install mysql-server
sudo systemctl start mysql-server
sudo systemctl enable mysql-server
sudo mysqladmin -u root password "$DATABASE_PASS"
sudo mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') WHERE User='root'"
sudo mysql -u root -p"$DATABASE_PASS" -e "create database users"
sudo mysql -u root -p"$DATABASE_PASS" -e "select users"
sudo mysql -u root -p"$DATABASE_PASS" -e "CREATE TABLE visitors (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ip_address VARCHAR(30) NOT NULL,
    visit_time TIMESTAMP)" 
sudo mysql -u root -p"$DATABASE_PASS" -e "create database users"
sudo mysql -u root -p"$DATABASE_PASS" -e "CREATE USER 'aaf'@'localhost' IDENTIFIED BY'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on users.* TO 'aaf'@'localhost' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on users.* TO 'aaf'@'%' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
