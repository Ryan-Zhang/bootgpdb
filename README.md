git clone https://github.com/lij55/bootgpdb.git

cd bootgpdb

source /pato/to/gpdb/greenplum_path.sh

./prepare.sh localhost

source env.sh 

gpinitsystem -c gpinitsystem_config


....
