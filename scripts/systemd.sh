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

# spawn-fcgi
yum install epel-release -y && yum install -y spawn-fcgi php php-cli mod_fcgid

cp /vagrant/spawn/spawn-fcgi /etc/sysconfig/spawn-fcgi

cp /vagrant/spawn/spawn-fcgi.service /etc/sysconfig/spawn-fcgi.service

systemctl daemon-reload

systemctl enable spawn-fcgi.service

# httpd
