#!/bin/bash
sshKey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUXg7lIQEwyk4AP2cKxhg39HdtY4Z+tCrnuHJ9FaeUqmLVbQywQrXNIHNrQkCaalIjqgGu3S1CAHvBIFhdMy/filOh9okQou32DQqCa3yIUnrfUXhZrqm9cANg9I2QTuFKqhf0AanPBtTNO9UD08CP1MyMgtTZPIFR4DIU6ksWQ+r63NrrMs36qDe3xqNUVWNUl4XNG2/7xCSLwkUmztafZTgtio7B9p0UfLDC48BFH/0lo7x8CHQaSgRgP3cGzfUOSZOrDKb8ODcg22HUZHItfrTGR11CZrXsuf/zfH31xZkbxII0YGSJwvTN5pNYW+dI9ZEzZrlfAV7pAn6nZRQB sysansible@plutonium.truemoney.co.id"
domain=".truemoneyid.internal"
hostName="$(hostname -s)$domain"
changehostname="$(echo $hostName)"
setsshdir="$(chmod 0700 /root/.ssh)"
setsshfile="$(chmod 0640 /root/.ssh/authorized_keys)"
rm -f /root/.ssh/authorized_keys;
echo "Add ssh key"
echo $sshKey > /root/.ssh/authorized_keys && $setsshdir && $setsshfile
echo "Set hostname to $changehostname"
echo $changehostname > /etc/hostname
echo "$(hostname $changehostname)"
sed -i '/DNS1/c\DNS1=172.16.10.159' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i '/DNS2/c\DNS2=202.152.0.2' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i '/localhost/c\$changehostname' inventory/hosts
/etc/init.d/network restart
