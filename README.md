# FCUP-ADS


Steps

create ssh key in ceph-mon

add ceph-mon's public key to all other ceph nodes's root authorized_keys (~/.ssh/authorized_keys)

run " sudo cephadm bootstrap --mon-ip *<ceph-mon-internal-ip>* "

run " ssh-copy-id -f -i /etc/ceph/ceph.pub root@<ceph-node> "

run " ceph orch host add <ceph-node>"

... more to come