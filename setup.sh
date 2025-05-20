bastille create wazuh-indexer 14.2-RELEASE 10.0.0.10
bastille cmd wazuh-indexer echo "10.0.0.10 indexer.wazuh" > /etc/hosts
bastille cmd wazuh-indexer sed -e "s|quarterly|latest|g" -i.bak /etc/pkg/FreeBSD.conf
bastille cmd wazuh-indexer sed -e "s|#PermitRootLogin no|PermitRootLogin yes|g" -i.bak /etc/ssh/sshd_config
bastille cmd wazuh-indexer sed -e "s|#PasswordAuthentication no|PasswordAuthentication yes|g" -i.bak /etc/ssh/sshd_config
bastille cmd wazuh-indexer sed -e "s|#PermitEmptyPasswords no|PermitEmptyPasswords yes|g" -i.bak /etc/ssh/sshd_config
bastille cmd wazuh-indexer service sshd enable
bastille cmd wazuh-indexer service sshd start
bastille cmd wazuh-indexer passwd -p 'sshroot'
#cp config/* /usr/local/bastille/jails/wazuh-indexer/
bastille stop wazuh-indexer; bastille start wazuh-indexer
bastille pkg wazuh-server update -y; bastille pkg wazuh-server update
bastille pkg wazuh-indexer install -y wazuh-indexer
bastille pkg wazuh-indexer info -D -x wazuh-indexer | less

bastille bootstrap https://github.com/bastille-templates/wazuh-indexer
bastille template wazuh-indexer bastille-templates/wazuh-indexer
