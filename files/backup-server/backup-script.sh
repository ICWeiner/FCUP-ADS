rsync -avz --delete ceph-rbd-client:/mnt/postgres/12/main/ /backup/ceph-data/
#ceph-rbd-client is the hostname of the RBD client

# Below is an example that you can add to your cron service to schedule the script to run every 30 mins and save the output to a log file
### 
#*/30 * * * * ~/backup-script.sh >> /tmp/backup.log 2>&1 
###