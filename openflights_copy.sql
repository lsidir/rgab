COPY 7184  RECORDS INTO AIRPORTS from '/home/lsidir/monetdb/data/rgab/airports.dat' USING DELIMITERS ',', '\n', '"' NULL AS '\N'  LOCKED;
COPY 6162  RECORDS INTO AIRLINES from '/home/lsidir/monetdb/data/rgab/airlines.dat' USING DELIMITERS ',', '\n', '"' NULL AS '\N'  LOCKED;
COPY 65612 RECORDS INTO ROUTES   from '/home/lsidir/monetdb/data/rgab/routes.dat'   USING DELIMITERS ',', '\n', '"' NULL AS '\N'  LOCKED;
