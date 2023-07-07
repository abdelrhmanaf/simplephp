# Setting Up a LAMP Stack on Linux and Hosting a Simple Website

In this document, we will walk through the steps required to set up a LAMP stack on a Linux machine and host a simple website that displays the visitor's IP address and current time. We will also explain basic networking concepts such as IP address, MAC address, switches, routers, and routing protocols.

## Sub-task #1: Linux Server Simulation

1. Install Apache, MySQL, and PHP on the Linux machine using apt-get or another package manager of your choice.

```bash
sudo apt-get update
sudo apt-get install apache2 mysql-server php libapache2-mod-php -y
sudo apt-get install php-mysqli
```

2. Configure Apache to serve the website from the /var/www/html/ directory.
```bash
sudo nano /etc/apache2/sites-available/000-default.conf
```
Modify the file to add the following lines:
```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

3. Create a simple website that displays the message "Hello World!" when accessed through a web browser.
Create the file `/var/www/html/index.php` with the following contents:
```php
<?php
echo "Hello World!";
?>
```

4. Configure MySQL to create a new database, user, and password for the website.
```bash
sudo mysql_config_editor set --login-path=local --user=root --password
```
Create a new database:
```mysql
CREATE DATABASE users;
```
Create a new user and grant privileges:
```mysql
sudo mysql --login-path=local -e "CREATE USER 'ubuntu'@'localhost' IDENTIFIED BY '$DATABASE_PASS'"
sudo mysql --login-path=local -e "GRANT ALL PRIVILEGES ON users.* TO 'ubuntu'@'localhost'; SET PASSWORD FOR 'ubuntu'@'localhost' = '$DATABASE_PASS';"
```

5. Modify the website to use the newly created database to display a message that includes the visitor's IP address and the current time.
Modify the `/var/www/html/index.php` file to include the following PHP code:
```php
<?php
$ip_address = $_SERVER['REMOTE_ADDR'];
$current_time = date('Y-m-d H:i:s');

$conn = mysqli_connect('localhost', 'ubuntu', 'Admin@123', 'users');
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}
mysqli_select_db($conn, 'users');

$sql = "INSERT INTO visitors (ip_address, visit_time) VALUES ('$ip_address', '$current_time')";
if (mysqli_query($conn, $sql)) {
  echo "Hello World! Your IP address is $ip_address and the current time is $current_time.";
} else {
  echo "Error: " . $sql . "<br>" . mysqli_error($conn);
}

mysqli_close($conn);
?>
```

6. Test the website by accessing it through a web browser and verifying that it displays the expected message.

## Sub-task #2: Git & GitHub

1. Initialize a new Git repository on your local machine.
```bash
git init
```

2. Create a `.gitignore` file to exclude any sensitive files (like configuration files with passwords).

```
# .gitignore
config.php
```

3. Commit your Markdown documentation file in the Git repository.
```bash
git add README.md
git commit -m "Initial commit"
```

4. Create a new repository on GitHub and push your local repository to GitHub.
```bash
git remote add origin <github-repo-url>
git push -u origin master
```

## Sub-task #3: Networking Basics

### IP address

An IP address is a numerical label assigned to each device connected to a computer network that uses the Internet Protocol for communication. It is used to identify and locate devices on the network. There are two types of IP addresses - IPv4 and IPv6.

### MAC address

A MAC address is a unique identifier assigned to a network interface controller. It is used to identify devices on a physical network and is different from an IP address. MAC addresses are assigned by the manufacturer of the network interface controller.

### Switches

Switches are network devices that connect multiple devices together and filter and forward data to their destination. They operate at the data link layer (layer 2) of the OSI model and use MAC addresses to forward data.

### Routers

Routers are network devices that connect multiple networks together and route data between them. They operate at the network layer (layer 3) of the OSI model and use IP addresses to forward data.

### Routing protocols

Routing protocols are used to determine the best path for data to travel between networks. They are used by routers to exchange information about network topology and determine the optimal path for data to reach its destination.

### SSH process for connecting to a cloud instance

To connect to a cloud instance from a remote machine, you can use SSH (Secure Shell) to securely access the Linux machine. First, retrieve the public IP address of the cloud instance. Then, open a terminal on theremote machine and enter the following command:

```bash
ssh username@public-ip-address
```

Replace "username" with the username of the Linux machine and "public-ip-address" with the public IP address of the cloud instance. You will be prompted to enter the password for the user account.

Once you have successfully logged in, you can perform administrative tasks on the Linux machine through the terminal. To exit the SSH session, enter the following command:

```bash
exit
```

## Conclusion

In this document, we have demonstrated how to set up a LAMP stack on a Linux machine and host a simple website that displays the visitor's IP address and current time. We have also explained basic networking concepts such as IP address, MAC address, switches, routers, and routing protocols. Additionally, we have detailed the steps required to connect to a cloud instance from a remote machine using SSH.
