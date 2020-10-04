#!/bin/bash

# Авторизуемся для получения root прав
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

# Monitor
cp /vagrant/monitor/monitor.config /etc/sysconfig/monitor.config

cp /vagrant/monitor/monitor.timer /etc/systemd/system/monitor.timer

cp /vagrant/monitor/monitor.service /etc/systemd/system/monitor.service

chmod +x /vagrant/monitor/monitor.sh

systemctl daemon-reload

systemctl enable monitor.timer

systemctl start monitor.timer

# spawn-fcgi
yum install epel-release -y && yum install -y spawn-fcgi php php-cli mod_fcgid httpd mc vim

echo "SOCKET=/var/run/php-fcgi.sock" >> /etc/sysconfig/spawn-fcgi
echo "OPTIONS=\"-u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -P /var/run/spawn-fcgi.pid -- /usr/bin/php-cgi\"" >> /etc/sysconfig/spawn-fcgi

cp /vagrant/spawn/spawn-fcgi.service /etc/sysconfig/spawn-fcgi.service

systemctl daemon-reload

systemctl enable spawn-fcgi.service

systemctl start spawn-fcgi.service

# httpd
cp /vagrant/httpd/httpd@.service /etc/systemd/system/httpd@.service

cp /vagrant/httpd/httpd-80 /etc/sysconfig/httpd-80
cp /vagrant/httpd/httpd-8080 /etc/sysconfig/httpd-8080

cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/80.conf
sed  's!Listen 80!Listen 8080!' /etc/httpd/conf/httpd.conf > /etc/httpd/conf/8080.conf
echo "PidFile /var/run/httpd/httpd-8080.pid" >> /etc/httpd/conf/8080.conf

cp /vagrant/httpd/start_httpd.service /etc/systemd/system/start_httpd.service

chmod +x /vagrant/httpd/start_httpd.service

systemctl daemon-reload

systemctl enable start_httpd.service

systemctl start httpd@80
systemctl start httpd@8080
