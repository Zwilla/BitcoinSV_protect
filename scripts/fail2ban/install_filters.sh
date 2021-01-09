#!/bin/bash
# this is for linux / ubuntu tested only at momnet
# always install fail2ban from source!!
# rewrite your path if needed
# https://www.us-cert.gov/ncas/alerts/TA13-088A

su bitcoin
cat >>/home/bitcoin/.bitcoin/bitcoin.conf <<\EOF
# https://bitcointalk.org/index.php?topic=1380642.msg14097654#msg14097654
logips=1
EOF;

su --

if [ -f /etc/fail2ban/filter.d/bitcoin.conf ]; then
cat >/etc/fail2ban/filter.d/bitcoin.conf <<\EOF
# Fail2Ban configuration file for bitcoin
#
[Definition]
failregex = .*receive version message: Why\? Because fuck u.*peeraddr=<HOST>:.*
ignoreregex =
EOF;
fi;

if [ -f /etc/fail2ban/filter.d/bitcoin_banned.conf ]; then
cat >/etc/fail2ban/filter.d/bitcoin_banned.conf <<\EOF
[Definition]
failregex = .*connection from <HOST>:.* dropped
ignoreregex =
EOF;
fi;

if [ -f /etc/fail2ban/jail.local ]; then
cat >/etc/fail2ban/jail.local <<\EOF
[bitcoin]

enabled = true
port    = 8333
filter  = bitcoin
logpath = /home/bitcoin/.bitcoin/debug.log
maxretry = 0
bantime  = 1w
findtime = 1d

[bitcoin_banned]
enabled = true
port    = 8333
filter = bitcoin_banned
logpath = /home/bitcoin/.bitcoin/debug.log
maxretry = 0
bantime  = 1w
findtime = 1d
EOF;
fi;

touch /etc/fail2ban/filter.d/bitcoin.conf
chown root:root /etc/fail2ban/filter.d/bitcoin.conf
chmod 644 /etc/fail2ban/filter.d/bitcoin.conf


fail2ban-client reload
fail2ban-client status

end;
