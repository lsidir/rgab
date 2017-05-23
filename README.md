This is a small Relational Graph Analytics Benchmark (sRGAB) to test the capabilities
and the correctness of a relational database that supports graph analytics.

There are three relational tables (airports, airlines, and routes) and x queries.

The data are taken from the OpenFlights Airport, Airline and Route Databases
which are made available under the Open Database License.
(link: https://openflights.org/data.html)

First run generate-sql.sh to create sql script files with local paths.

Setup the database by executing sql scripts in the following order:
openflights_schema.sql
openflights_copy.sql
openflights_alter.sql

And to drop the database run
openflights_drop.sql
