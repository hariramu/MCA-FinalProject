#!/bin/bash
sudo yum update -y
sudo yum install httpd unzip -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Download the Little Fashion template
wget -O /tmp/little-fashion.zip "https://www.free-css.com/assets/files/free-css-templates/download/page296/little-fashion.zip"

# Ensure Apache directory is clean
sudo rm -rf /var/www/html/*

# Unzip the template into the Apache web root
sudo unzip /tmp/little-fashion.zip -d /var/www/html/

# Move files correctly (sometimes templates unzip into a subfolder)
sudo mv /var/www/html/*/* /var/www/html/

# Set correct permissions
sudo chmod -R 755 /var/www/html/
sudo chown -R apache:apache /var/www/html/

# Restart Apache to apply changes
sudo systemctl restart httpd
