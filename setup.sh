bastille create wazuh-indexer 14.2-RELEASE 10.0.0.10
cp config/* /usr/local/bastille/jails/wazuh-indexer/
bastille stop wazuh-indexer; bastille start wazuh-indexer
bastille cmd wazuh-indexer sed -e "s|quarterly|latest|g" -i.bak /etc/pkg/FreeBSD.conf
bastille pkg wazuh-server update -y; bastille pkg wazuh-server update
bastille pkg wazuh-indexer install -y wazuh-indexer
bastille pkg wazuh-indexer info -D -x wazuh-indexer | less

bastille bootstrap https://github.com/bastille-templates/wazuh-indexer
bastille template wazuh-indexer bastille-templates/wazuh-indexer
