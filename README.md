# FCUP-ADS

Steps

create project

create service account

add service account key (json)

add path to service account key in terraform.tfvars

add project name to terraform.tfvars

enable compute engine API

create ssh key in ceph-mon

add ceph-mon's public key to all other ceph nodes's root authorized_keys (~/.ssh/authorized_keys)

run " sudo cephadm bootstrap --mon-ip *<ceph-mon-internal-ip>* "

run " ssh-copy-id -f -i /etc/ceph/ceph.pub root@<ceph-node> "

run " ceph orch host add <ceph-node> <ceph-node-ip>"

run "ceph orch daemon add osd <ceph-osd-node>:<disk-path>" 

run "sudo ceph orch apply mgr --placement "<ceph-mgr-node>""

run "ceph dashboard create-self-signed-cert"

run "ceph config set mgr mgr/dashboard/server_addr <ceph-mgr-ip>"

run "ceph mgr module disable dashboard
     ceph mgr module enable dashboard"

on ceph RBD client:

    run "apt -y install ceph-common"

    run "ceph osd pool create rbd 32"

    run "ceph osd pool set rbd pg_autoscale_mode on"

    run "rbd pool init rbd"

    run "rbd create --size 10G --pool rbd rbd01"

    run "rbd map rbd01"

    run "mkfs.xfs /dev/rbd0"

    run "mount /dev/rbd0 /mnt"

    run "apt -y install postgresql-12"

    run "sudo systemctl stop postgresql"
    
    run "sudo rsync -av /var/lib/postgresql /mnt/postgres"

    access  /etc/postgresql/12/main/postgresql.conf and modify:
        
        data_directory entry to "/mnt/postgres"

        listen_addresses to " '*' "
    
    access /etc/postgresql/12/main/pg_hba.conf  and add to the end " host all all 10.0.0.0/24 md5"

    run "sudo systemctl start postgresql"

create ssh access from <backup-server-node> to <ceph-rbd-client> 

on <backup-server-node> create a script with "rsync -avz --delete ceph-rbd-client:/mnt/postgres/12/main/ /backup/ceph-data/"

access cron using "crontab -e" and add "*/30 * * * * ~/backup-script.sh >> /path/to/backup.log 2>&1" to the end

