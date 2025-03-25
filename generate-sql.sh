#!/bin/bash
FILES="airlines.dat  airports.dat routes.dat"
COPY_SQL="openflights_copy.sql"

for f in $FILES
do
	if [ ! -f $f ]; then
		echo "File $f does not exist."
		exit 1;
	fi
done

cat > $COPY_SQL <<EOF
COPY 7184  RECORDS INTO AIRPORTS from '`pwd`/airports.dat' USING DELIMITERS ',', '\n', '"' NULL AS '\\\N';
COPY 6162  RECORDS INTO AIRLINES from '`pwd`/airlines.dat' USING DELIMITERS ',', '\n', '"' NULL AS '\\\N';
COPY 65612 RECORDS INTO ROUTES   from '`pwd`/routes.dat'   USING DELIMITERS ',', '\n', '"' NULL AS '\\\N';
EOF
