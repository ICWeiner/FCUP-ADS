# FCUP-ADS


Steps

create ssh key in ceph-mon

add ceph-mon's public key to all other ceph nodes's root authorized_keys (~/.ssh/authorized_keys)

run " sudo cephadm bootstrap --mon-ip *<ceph-mon-internal-ip>* "

run " ssh-copy-id -f -i /etc/ceph/ceph.pub root@<ceph-node> "

run " ceph orch host add <ceph-node> <ceph-node-ip>"

run "ceph orch daemon add osd <ceph-osd-node>:<disk-path>" 

... more to come