#!/bin/bash
#block the idots before they touch your node or wallet
fail2ban-regex /home/bitcoin/.bitcoin/debug.log /etc/fail2ban/filter.d/bitcoind_banned.conf;
end;
