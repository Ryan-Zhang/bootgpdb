Use following command to create config for GPDB cluster:

`git clone https://github.com/lij55/bootgpdb.git`
`cd bootgpdb`
`source /path/to/gpdb/greenplum_path.sh`
`./prepare.sh -n num_of_segment_per_host -s num_of_seg_hosts`
`source env.sh`
`gpinitsystem -a -c gpinitsystem_config`

