# cephadm-config.yaml.tpl

osd:
  count: ${osd_instance_count}
  hosts:
    - ${osd_host_1}
    - ${osd_host_2}

mon:
  count: 1
  hosts:
    - ${mon_host}

mgr:
  count: 1
  hosts:
    - ${mgr_host}

rbd:
  count: 1
  hosts:
    - ${rbd_host}