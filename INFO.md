Wazuh indexer components were installed

1) Wazuh indexer is based on opensearch project. This guide help you for adapt
   wazuh configuration for it works on FreeBSD using apps are part of ports
   tree.

2) Copy /usr/local/etc/wazuh-indexer/wazuh-indexer.yml to /usr/local/etc/opensearch/opensearch.yml

3) Edit /usr/local/etc/opensearch/opensearch.yml and changes options accord to your
   setup. For example host, ssl, nodes options, etc. On this guide we will use
   like host 10.0.0.10

4) If you want use a simple way to generate wazuh infrastructure certificates
   you can use a simplified version of certificates generator script located at:

   https://people.freebsd.org/~acm/ports/wazuh/wazuh-gen-certs.tar.gz

5) Wazuh needs opensearch-security features. Rename or copy samples files
   into /usr/local/etc/opensearch/opensearch-security

   # cd /usr/local/etc/opensearch/opensearch-security
   # sh -c 'for i in $(ls *.sample ) ; do cp -p ${i} $(echo ${i} | sed "s|.sample||g") ; done'

6) You can define a custom admin password modifying internal_users.yml file into 
   /usr/local/etc/opensearch/opensearch-security/

   admin:
     hash: "$2a$12$VcCDgh2NDk07JGN0rjGbM.Ad41qVR/YFJcgHp0UGns5JDymv..TOG"

   Hash password can be generated using opensearch-security hash script tool

   # cd /usr/local/lib/opensearch/plugins/opensearch-security/tools/
   # sh -c "OPENSEARCH_JAVA_HOME=/usr/local/openjdk17 ./hash.sh -p adminpass"
   $2y$12$ipq2jMBHVUd1Wlkf22N61Os/5LjcVRF2C55omeBOaFOz7nB8J0I5u

7) Add OpenSearch to /etc/rc.conf

   # sysrc opensearch_enable="YES"
   # sysrc opensearch_java_home="/usr/local/openjdk17"

8) Start OpenSearch

  # service opensearch start

9) Finally you must initialize opensearch cluster

  # cd /usr/local/lib/opensearch/plugins/opensearch-security/tools/
  # sh -c "OPENSEARCH_JAVA_HOME=/usr/local/openjdk17 ./securityadmin.sh \
    -cd /usr/local/etc/opensearch/opensearch-security/ -cacert /usr/local/etc/opensearch/certs/root-ca.pem \
    -cert /usr/local/etc/opensearch/certs/admin.pem -key /usr/local/etc/opensearch/certs/admin-key.pem -h 10.0.0.1 -p 9200 -icl -nhnv"

10) You can look more useful information at the following link:

    https://documentation.wazuh.com/current/installation-guide/wazuh-indexer/step-by-step.html

    Take on mind wazuh arquitecture on FreeBSD is configurated not similar like
    you can read at wazuh guide

11) Testing your server installation

   # curl -k -u admin:adminpass https://10.0.0.1:9200
   # curl -k -u admin:adminpass https://10.0.0.1:9200/_cat/nodes?v

12) Enjoy it
