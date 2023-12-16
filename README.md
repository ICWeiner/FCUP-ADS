# FCUP-ADS Group A

For this project we deployed a ceph cluster consisting of:
    2x OSD Nodes
    1x Monitor Node
    1x Manager Node
    1x RBD Client
    1x Backup Server

We built a terraform script that deploys everything needed such as VMs with the respective packages, opening of required TCP ports.

To use it just open the " teraform.tfvars " and fill the fields gcp_credentials_path with your service account json file path and gcp_project_id with the project id.
Also in this file you may edit the OSD node count and capacity.

All machines have the same base configuration in terms of hardware with the exception of the OSD nodes, those each employ a spare HDD that is used exclusively by ceph.

For ceph deployment we used the recommended tool (by the ceph developers), cephadm.

You will find a full guide on deploying this cluster setup in " general_config.md ".

To effectively demonstrate the functioning of the cluster a postgres database is installed on the RBD, with backups being done on a scheduled basis by the backup server node.

Postgres is also configured to accept remote connections, so you may use pgadmin if you'd like.

Daniela Tomás up202004946  
Diogo Nunes up202007895  
João Veloso up202005801  