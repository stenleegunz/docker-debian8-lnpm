#!/bin/bash
mkdir -p /var/run/sshd && \
sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
rm -f /etc/ssh/ssh_host_key       && ssh-keygen -b 1024 -t rsa   -f /etc/ssh/ssh_host_key       && \
rm -f /etc/ssh/ssh_host_rsa_key   && ssh-keygen -b 1024 -t rsa   -f /etc/ssh/ssh_host_rsa_key   && \
rm -f /etc/ssh/ssh_host_dsa_key   && ssh-keygen -b 1024 -t dsa   -f /etc/ssh/ssh_host_dsa_key   && \
rm -f /etc/ssh/ssh_host_ecdsa_key && ssh-keygen -b 256  -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key