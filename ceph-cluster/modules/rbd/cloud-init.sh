#!/bin/bash

# Update package lists
apt-get update

# Install cephadm
sudo apt install -y docker.io
sudo apt install -y ceph-common
sudo apt install -y postgresql-12