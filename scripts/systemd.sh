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
# yum install epel-release -y && yum install -y httpd mc vim

# cp /vagrant/spawn/spawn-fcgi /etc/sysconfig/spawn-fcgi

# cp /vagrant/spawn/spawn-fcgi.service /etc/sysconfig/spawn-fcgi.service

# systemctl daemon-reload

# systemctl enable spawn-fcgi.service

# systemctl start spawn-fcgi.service

# httpd
# cp /vagrant/httpd/httpd@.service /usr/lib/systemd/system/httpd@.service