#!/bin/bash

# Проверка наличия ключевого слова в лог файле, переменные $KEYWORD $PATHLO задаются в /etc/sysconfig/monitor.config
if grep $KEYWORD $PATHLOG
then
echo "The keyword $KEYWORD exists!!!"
else
echo "No keyword 143!!!"
exit 143
fi

