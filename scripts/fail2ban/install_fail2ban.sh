##!/bin/bash

su --

apt remove fail2ban
systemctl unmask fail2ban

git clone https://github.com/fail2ban/fail2ban.git;
sync;
cd fail2ban;
sudo python setup.py install;
sync;

cp files/debian-initd /etc/init.d/fail2ban;
sync;
update-rc.d fail2ban defaults;
service fail2ban start;

fail2ban-client -h
end;
