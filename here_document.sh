#!/bin/bash

export DB_NAME=tpc
export TABLE_NAME=customer_address
export CRITERIA=Oakland
export CUTOFF=20

impala-shell -d $DB_NAME <<EOF
select * from $DB_NAME.$TABLE_NAME where ca_city = '$CRITERIA' limit $CUTOFF;
EOF

...more shell code...
