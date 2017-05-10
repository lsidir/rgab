COPY 7184  RECORDS INTO AIRPORTS from '/export/scratch2/lsidir/openflights/airports.dat' USING DELIMITERS ',', '\n', '"' NULL AS '\\N'  LOCKED;
COPY 6162  RECORDS INTO AIRLINES from '/export/scratch2/lsidir/openflights/airlines.dat' USING DELIMITERS ',', '\n', '"' NULL AS '\\N'  LOCKED;
COPY 65612 RECORDS INTO ROUTES   from '/export/scratch2/lsidir/openflights/routes.dat'   USING DELIMITERS ',', '\n', '"' NULL AS '\\N'  LOCKED;
